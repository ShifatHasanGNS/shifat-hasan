using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace shifat_hasan.Pages.Admin.Dashboard
{
    public partial class AdminInfo : Page
    {
        private bool IsEditMode
        {
            get => ViewState["IsEditMode"] as bool? ?? false;
            set => ViewState["IsEditMode"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check authentication first
            RequireAuthentication();

            if (!IsPostBack)
            {
                LoadAdminInfo();
                LoadSessionInfo();
            }

            // Handle the view mode on postback
            SetViewMode();
        }

        private void SetViewMode()
        {
            if (IsEditMode)
            {
                displayMode.Style["display"] = "none";
                editMode.Style["display"] = "block";
                btnToggleEdit.Text = "View";
            }
            else
            {
                displayMode.Style["display"] = "block";
                editMode.Style["display"] = "none";
                btnToggleEdit.Text = "Edit";
            }
        }

        protected void btnToggleEdit_Click(object sender, EventArgs e)
        {
            if (IsEditMode)
            {
                // Switch to view mode
                IsEditMode = false;
            }
            else
            {
                // Switch to edit mode and populate fields
                IsEditMode = true;
                LoadEditFields();
            }

            LiteralMessage.Text = "";

            SetViewMode();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            IsEditMode = false;
            SetViewMode();
            LiteralMessage.Text = "";
        }

        private void LoadEditFields()
        {
            try
            {
                var admin = GetAdminFromDatabase();
                if (admin != null)
                {
                    PopulateEditFields(admin);
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error loading data for editing: " + Server.HtmlEncode(ex.Message);
            }
        }

        private void RequireAuthentication()
        {
            if (IsAuthenticated()) return;
            Response.Redirect("~/Pages/Admin/Login.aspx?msg=access", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private bool IsAuthenticated()
        {
            return Session["IsAdminAuthenticated"] != null &&
                   (bool)Session["IsAdminAuthenticated"] &&
                   !IsSessionExpired();
        }

        private bool IsSessionExpired()
        {
            if (Session["LoginTime"] == null) return true;

            try
            {
                var loginTime = (DateTime)Session["LoginTime"];
                var timeoutMinutes = int.Parse(ConfigurationManager.AppSettings["SessionTimeoutMinutes"] ?? "30");
                return DateTime.Now.Subtract(loginTime).TotalMinutes > timeoutMinutes;
            }
            catch (Exception)
            {
                Console.WriteLine("Error checking session expiration.");
                return true;
            }
        }

        private void LoadSessionInfo()
        {
            try
            {
                if (Session["LoginTime"] != null)
                {
                    var loginTime = (DateTime)Session["LoginTime"];
                    var duration = DateTime.Now - loginTime;
                    var adminName = Session["AdminName"]?.ToString() ?? "Admin";

                    LiteralSessionInfo.Text =
                        $"Logged in as: {Server.HtmlEncode(adminName)} | Session: {duration.Hours:00}:{duration.Minutes:00}:{duration.Seconds:00}";
                }
                else
                {
                    LiteralSessionInfo.Text = "Session information not available";
                }
            }
            catch (Exception ex)
            {
                LiteralSessionInfo.Text = "Error loading session info: " + Server.HtmlEncode(ex.Message);
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            // Update database to set is_signed_in = false
            try
            {
                var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"]?.ConnectionString;
                if (!string.IsNullOrEmpty(connectionString))
                {
                    using var conn = new SqlConnection(connectionString);
                    conn.Open();
                    const string query = "UPDATE [admin] SET is_signed_in = 0 WHERE is_signed_in = 1";
                    using var cmd = new SqlCommand(query, conn);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Log error but continue with logout
                System.Diagnostics.Debug.WriteLine($"Database update failed during sign out: {ex.Message}");
            }

            // Clear session
            Session.Clear();
            Session.Abandon();

            // Redirect to login page with success message
            Response.Redirect("~/Pages/Admin/Login.aspx?msg=signout", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void LoadAdminInfo()
        {
            try
            {
                var admin = GetAdminFromDatabase();

                if (admin != null)
                {
                    PopulateDisplayFields(admin);
                    PopulateEditFields(admin);
                }
                else
                {
                    // No admin record found - show empty state
                    ShowEmptyState();
                    LiteralMessage.Text = "No admin information found. Please add your information.";
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error loading admin information: " + Server.HtmlEncode(ex.Message);
                ShowEmptyState(); // Show empty state if there's an error
            }
        }

        private void PopulateDisplayFields(AdminModel admin)
        {
            // Personal Information
            DisplayName.Text = Server.HtmlEncode(admin.Name ?? "Not specified");
            DisplayCountry.Text = Server.HtmlEncode(admin.Country ?? "Not specified");
            DisplayEmail.Text = !string.IsNullOrEmpty(admin.Email) ? Server.HtmlEncode(admin.Email) : "Not specified";

            // Academic Information
            DisplayUniversity.Text = Server.HtmlEncode(admin.University ?? "Not specified");
            DisplayCurrentInstitution.Text = Server.HtmlEncode(admin.CurrentInstitution ?? "Not specified");

            // Social Media Links
            DisplayGithub.Text = FormatSocialLink(admin.Github, "GitHub");
            DisplayLinkedIn.Text = FormatSocialLink(admin.LinkedIn, "LinkedIn");
            DisplayFacebook.Text = FormatSocialLink(admin.Facebook, "Facebook");
            DisplayInstagram.Text = FormatSocialLink(admin.Instagram, "Instagram");
            DisplayYoutube.Text = FormatSocialLink(admin.Youtube, "YouTube");

            // System Information
            DisplaySignInStatus.Text = admin.IsSignedIn
                ? "<span class='status-online'>Online</span>"
                : "<span class='status-offline'>Offline</span>";
            DisplaySignInCount.Text = admin.SignedInCount.ToString();

            LiteralStatus.Text = admin.IsSignedIn ? "Online" : "Offline";
        }

        private void PopulateEditFields(AdminModel admin)
        {
            // Use null coalescing operator to ensure empty string instead of null
            txtName.Text = admin.Name ?? "";
            txtCountry.Text = admin.Country ?? "";
            txtEmail.Text = admin.Email ?? "";
            txtUniversity.Text = admin.University ?? "";
            txtCurrentInstitution.Text = admin.CurrentInstitution ?? "";
            txtGitHub.Text = admin.Github ?? "";
            txtLinkedIn.Text = admin.LinkedIn ?? "";
            txtFacebook.Text = admin.Facebook ?? "";
            txtInstagram.Text = admin.Instagram ?? "";
            txtYoutube.Text = admin.Youtube ?? "";
        }

        private void ShowEmptyState()
        {
            // Clear display fields
            DisplayName.Text = "Not specified";
            DisplayCountry.Text = "Not specified";
            DisplayEmail.Text = "Not specified";
            DisplayUniversity.Text = "Not specified";
            DisplayCurrentInstitution.Text = "Not specified";
            DisplayGithub.Text = "Not specified";
            DisplayLinkedIn.Text = "Not specified";
            DisplayFacebook.Text = "Not specified";
            DisplayInstagram.Text = "Not specified";
            DisplayYoutube.Text = "Not specified";
            DisplaySignInStatus.Text = "<span class='status-offline'>Offline</span>";
            DisplaySignInCount.Text = "0";
            LiteralStatus.Text = "Offline";

            // Clear edit fields
            txtName.Text = "";
            txtCountry.Text = "";
            txtEmail.Text = "";
            txtUniversity.Text = "";
            txtCurrentInstitution.Text = "";
            txtGitHub.Text = "";
            txtLinkedIn.Text = "";
            txtFacebook.Text = "";
            txtInstagram.Text = "";
            txtYoutube.Text = "";
        }

        private string FormatSocialLink(string url, string platform)
        {
            if (string.IsNullOrEmpty(url))
            {
                return "Not specified";
            }

            // Ensure URL has protocol
            var formattedUrl = url;
            if (!url.StartsWith("http://") && !url.StartsWith("https://"))
            {
                formattedUrl = "https://" + url;
            }

            var encodedUrl = Server.HtmlEncode(formattedUrl);
            var encodedPlatform = Server.HtmlEncode(platform);

            return
                $"<a href='{encodedUrl}' target='_blank' rel='noopener noreferrer' title='Open {encodedPlatform} profile'>{formattedUrl}</a>";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate email format if provided
                var email = txtEmail.Text.Trim();
                if (!string.IsNullOrEmpty(email) && !IsValidEmail(email))
                {
                    LiteralMessage.Text = "Please enter a valid email address.";
                    return;
                }

                var admin = new AdminModel
                {
                    Name = txtName.Text.Trim(),
                    Country = txtCountry.Text.Trim(),
                    Email = email,
                    University = txtUniversity.Text.Trim(),
                    CurrentInstitution = txtCurrentInstitution.Text.Trim(),
                    Github = txtGitHub.Text.Trim(),
                    LinkedIn = txtLinkedIn.Text.Trim(),
                    Facebook = txtFacebook.Text.Trim(),
                    Instagram = txtInstagram.Text.Trim(),
                    Youtube = txtYoutube.Text.Trim()
                };

                // Debug: Check what values we're trying to save
                System.Diagnostics.Debug.WriteLine(
                    $"Saving - Email: '{admin.Email}', GitHub: '{admin.Github}', LinkedIn: '{admin.LinkedIn}'");

                var success = SaveAdminToDatabase(admin);

                if (success)
                {
                    LoadAdminInfo(); // Refresh display
                    IsEditMode = false; // Switch back to view mode
                    SetViewMode();
                    LiteralMessage.Text = "Admin information saved successfully!";
                }
                else
                {
                    LiteralMessage.Text = "Failed to save admin information. Please try again.";
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error saving admin information: " + Server.HtmlEncode(ex.Message);
            }
        }

        private static bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private static AdminModel GetAdminFromDatabase()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"]?.ConnectionString;
            if (string.IsNullOrEmpty(connectionString))
            {
                throw new InvalidOperationException("Database connection string not found.");
            }

            AdminModel admin = null;

            using var connection = new SqlConnection(connectionString);
            const string query = @"SELECT TOP 1 * FROM [admin] ORDER BY CASE WHEN is_signed_in = 1 THEN 0 ELSE 1 END";

            using var command = new SqlCommand(query, connection);
            connection.Open();
            using var reader = command.ExecuteReader();

            if (!reader.Read()) return admin;
            admin = new AdminModel();

            // Handle boolean fields safely
            if (reader["is_signed_in"] != null && reader["is_signed_in"] != DBNull.Value)
            {
                admin.IsSignedIn = Convert.ToBoolean(reader["is_signed_in"]);
            }

            // Handle integer fields safely
            if (reader["signed_in_count"] != null && reader["signed_in_count"] != DBNull.Value)
            {
                admin.SignedInCount = Convert.ToInt32(reader["signed_in_count"]);
            }

            // Handle string fields safely - Convert DBNull to empty string, not null
            admin.Name = reader["name"] == DBNull.Value ? "" : reader["name"]?.ToString() ?? "";
            admin.Country = reader["country"] == DBNull.Value ? "" : reader["country"]?.ToString() ?? "";
            admin.University = reader["university"] == DBNull.Value ? "" : reader["university"]?.ToString() ?? "";
            admin.CurrentInstitution = reader["current_institution"] == DBNull.Value
                ? ""
                : reader["current_institution"]?.ToString() ?? "";
            admin.Email = reader["email"] == DBNull.Value ? "" : reader["email"]?.ToString() ?? "";
            admin.Github = reader["github"] == DBNull.Value ? "" : reader["github"]?.ToString() ?? "";
            admin.LinkedIn = reader["linkedin"] == DBNull.Value ? "" : reader["linkedin"]?.ToString() ?? "";
            admin.Facebook = reader["facebook"] == DBNull.Value ? "" : reader["facebook"]?.ToString() ?? "";
            admin.Instagram = reader["instagram"] == DBNull.Value ? "" : reader["instagram"]?.ToString() ?? "";
            admin.Youtube = reader["youtube"] == DBNull.Value ? "" : reader["youtube"]?.ToString() ?? "";

            return admin;
        }

        private static bool SaveAdminToDatabase(AdminModel admin)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"]?.ConnectionString;
            if (string.IsNullOrEmpty(connectionString))
            {
                throw new InvalidOperationException("Database connection string not found.");
            }

            using var connection = new SqlConnection(connectionString);
            connection.Open();

            // Check if admin record exists
            const string checkQuery = "SELECT COUNT(*) FROM [admin]";
            bool hasRecord;

            using (var checkCommand = new SqlCommand(checkQuery, connection))
            {
                var count = (int)checkCommand.ExecuteScalar();
                hasRecord = count > 0;
            }

            var query =
                // Update existing record - preserve is_signed_in and signed_in_count
                hasRecord
                    ? @"UPDATE [admin] SET 
                         name = @name, 
                         country = @country, 
                         university = @university,
                         current_institution = @currentInstitution, 
                         email = @email,
                         github = @github, 
                         linkedin = @linkedin, 
                         facebook = @facebook,
                         instagram = @instagram, 
                         youtube = @youtube"
                    :
                    // Insert new record
                    @"INSERT INTO [admin] (is_signed_in, signed_in_count, name, country, university,
                         current_institution, email, github, linkedin, facebook, instagram, youtube)
                         VALUES (0, 0, @name, @country, @university, @currentInstitution, @email,
                         @github, @linkedin, @facebook, @instagram, @youtube)";

            using var command = new SqlCommand(query, connection);

            // Add parameters - handle empty strings and null values properly
            command.Parameters.AddWithValue("@name",
                string.IsNullOrWhiteSpace(admin.Name) ? DBNull.Value : (object)admin.Name);
            command.Parameters.AddWithValue("@country",
                string.IsNullOrWhiteSpace(admin.Country) ? DBNull.Value : (object)admin.Country);
            command.Parameters.AddWithValue("@university",
                string.IsNullOrWhiteSpace(admin.University) ? DBNull.Value : (object)admin.University);
            command.Parameters.AddWithValue("@currentInstitution",
                string.IsNullOrWhiteSpace(admin.CurrentInstitution) ? DBNull.Value : (object)admin.CurrentInstitution);
            command.Parameters.AddWithValue("@email",
                string.IsNullOrWhiteSpace(admin.Email) ? DBNull.Value : (object)admin.Email);
            command.Parameters.AddWithValue("@github",
                string.IsNullOrWhiteSpace(admin.Github) ? DBNull.Value : (object)admin.Github);
            command.Parameters.AddWithValue("@linkedin",
                string.IsNullOrWhiteSpace(admin.LinkedIn) ? DBNull.Value : (object)admin.LinkedIn);
            command.Parameters.AddWithValue("@facebook",
                string.IsNullOrWhiteSpace(admin.Facebook) ? DBNull.Value : (object)admin.Facebook);
            command.Parameters.AddWithValue("@instagram",
                string.IsNullOrWhiteSpace(admin.Instagram) ? DBNull.Value : (object)admin.Instagram);
            command.Parameters.AddWithValue("@youtube",
                string.IsNullOrWhiteSpace(admin.Youtube) ? DBNull.Value : (object)admin.Youtube);

            var result = command.ExecuteNonQuery();
            return result > 0;
        }
    }

    // Admin model class
    public class AdminModel
    {
        public bool IsSignedIn { get; set; }
        public int SignedInCount { get; set; }
        public string Name { get; set; }
        public string Country { get; set; }
        public string University { get; set; }
        public string CurrentInstitution { get; set; }
        public string Email { get; set; }
        public string Github { get; set; }
        public string LinkedIn { get; set; }
        public string Facebook { get; set; }
        public string Instagram { get; set; }
        public string Youtube { get; set; }

        public bool is_signed_in => IsSignedIn;
        public int signed_in_count => SignedInCount;
        public string name => Name;
        public string country => Country;
        public string university => University;
        public string current_institution => CurrentInstitution;
        public string email => Email;
        public string github => Github;
        public string linkedin => LinkedIn;
        public string facebook => Facebook;
        public string instagram => Instagram;
        public string youtube => Youtube;
    }
}