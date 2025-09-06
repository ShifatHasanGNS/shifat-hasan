using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace shifat_hasan.Pages.Admin
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if admin is already logged in
                if (IsAuthenticated())
                {
                    Response.Redirect("~/Pages/Admin/Dashboard/AdminInfo.aspx");
                }

                // Handle query string messages
                string msg = Request.QueryString["msg"];
                switch (msg)
                {
                    case "expired":
                        ShowMessage("Your session has expired. Please sign in again.", "error");
                        break;
                    case "access":
                        ShowMessage("Access denied. Please sign in to continue.", "error");
                        break;
                    case "signout":
                        ShowMessage("You have been signed out successfully.", "success");
                        break;
                }
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string id = txtAdminId.Text.Trim();
            string passkey = txtPasskey.Text.Trim();

            if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(passkey))
            {
                ShowMessage("Please enter both Admin ID and Passkey.", "error");
                return;
            }

            string adminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
            string adminPasskey = System.Configuration.ConfigurationManager.AppSettings["AdminPasskey"];

            if (id == adminId && passkey == adminPasskey)
            {
                // Set up proper session
                SetupAdminSession();

                // Clear form fields
                txtAdminId.Text = "";
                txtPasskey.Text = "";

                // Redirect to dashboard
                Response.Redirect("~/Pages/Admin/Dashboard/AdminInfo.aspx");
            }
            else
            {
                // Clear form fields for security
                txtAdminId.Text = "";
                txtPasskey.Text = "";
                ShowMessage("Invalid Admin ID or Passkey.", "error");
            }
        }

        private void SetupAdminSession()
        {
            // Set essential session variables
            Session["IsAdminAuthenticated"] = true;
            Session["AdminId"] = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
            Session["LoginTime"] = DateTime.Now;

            // Set session timeout
            string timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            Session.Timeout = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            // Try to get additional info from database
            try
            {
                UpdateDatabaseAndGetInfo();
            }
            catch
            {
                // If database operations fail, continue with defaults
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
            }
        }

        private void UpdateDatabaseAndGetInfo()
        {
            string connectionString = System.Configuration.ConfigurationManager
                .ConnectionStrings["DefaultConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                // No database configured, use defaults
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get current admin data
                string selectQuery = "SELECT name, email, signed_in_count FROM [admin]";
                string adminName = "Administrator";
                string adminEmail = "";
                int currentCount = 0;

                using (SqlCommand selectCmd = new SqlCommand(selectQuery, conn))
                {
                    using (SqlDataReader reader = selectCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            adminName = reader["name"]?.ToString() ?? "Administrator";
                            adminEmail = reader["email"]?.ToString() ?? "";
                            currentCount = Convert.ToInt32(reader["signed_in_count"] ?? 0);
                        }
                    }
                }

                // Update database
                string updateQuery = "UPDATE [admin] SET is_signed_in = 1, signed_in_count = @newCount";
                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                {
                    updateCmd.Parameters.AddWithValue("@newCount", currentCount + 1);
                    updateCmd.ExecuteNonQuery();
                }

                // Set session variables
                Session["AdminName"] = adminName;
                Session["AdminEmail"] = adminEmail;
                Session["SignInCount"] = currentCount + 1;
            }
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

            DateTime loginTime = (DateTime)Session["LoginTime"];
            string timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            int timeoutMinutes = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            return DateTime.Now.Subtract(loginTime).TotalMinutes > timeoutMinutes;
        }

        // Static methods for use in other pages
        public static bool RequireAuthentication()
        {
            var context = System.Web.HttpContext.Current;
            var page = (Page)context.Handler;

            if (page.Session["IsAdminAuthenticated"] == null ||
                !(bool)page.Session["IsAdminAuthenticated"])
            {
                context.Response.Redirect("~/Pages/Admin/Login.aspx?msg=access");
                return false;
            }

            // Check session expiration
            if (page.Session["LoginTime"] != null)
            {
                DateTime loginTime = (DateTime)page.Session["LoginTime"];
                string timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
                int timeoutMinutes = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

                if (DateTime.Now.Subtract(loginTime).TotalMinutes > timeoutMinutes)
                {
                    page.Session.Clear();
                    context.Response.Redirect("~/Pages/Admin/Login.aspx?msg=expired");
                    return false;
                }
            }

            return true;
        }

        public static void Logout()
        {
            var context = System.Web.HttpContext.Current;

            // Update database
            try
            {
                string connectionString = System.Configuration.ConfigurationManager
                    .ConnectionStrings["DefaultConnection"]?.ConnectionString;

                if (!string.IsNullOrEmpty(connectionString))
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string query = "UPDATE [admin] SET is_signed_in = 0";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch
            {
                // Ignore database errors during logout
            }

            // Clear session and redirect
            context.Session.Clear();
            context.Session.Abandon();
            context.Response.Redirect("~/Pages/Admin/Login.aspx?msg=signout");
        }

        // Helper properties
        public static string CurrentAdminId
        {
            get { return System.Web.HttpContext.Current?.Session["AdminId"]?.ToString() ?? ""; }
        }

        public static string CurrentAdminName
        {
            get { return System.Web.HttpContext.Current?.Session["AdminName"]?.ToString() ?? "Administrator"; }
        }

        public static string CurrentAdminEmail
        {
            get { return System.Web.HttpContext.Current?.Session["AdminEmail"]?.ToString() ?? ""; }
        }

        public static int SignInCount
        {
            get { return Convert.ToInt32(System.Web.HttpContext.Current?.Session["SignInCount"] ?? 0); }
        }

        public static string GetSessionInfo()
        {
            var context = System.Web.HttpContext.Current;

            if (context?.Session["IsAdminAuthenticated"] == null ||
                !(bool)context.Session["IsAdminAuthenticated"])
                return "Not authenticated";

            if (context.Session["LoginTime"] != null)
            {
                DateTime loginTime = (DateTime)context.Session["LoginTime"];
                TimeSpan duration = DateTime.Now - loginTime;
                return
                    $"Logged in as: {CurrentAdminName} | Session: {duration.Hours:00}:{duration.Minutes:00}:{duration.Seconds:00}";
            }

            return $"Logged in as: {CurrentAdminName}";
        }

        private void ShowMessage(string message, string type)
        {
            MessageLabel.Text = message;
            MessagePanel.Visible = true;

            alertDiv.Attributes["class"] = type == "success" ? "alert alert-success" : "alert alert-error";
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Clean up any loading classes
            btnSignIn.CssClass = btnSignIn.CssClass.Replace("loading", "").Trim();
        }
    }
}