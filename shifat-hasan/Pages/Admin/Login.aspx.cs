using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web;
using System.Web.Security;

namespace shifat_hasan.Pages.Admin
{
    public partial class Login : Page
    {
        private const string AuthCookieName = "AdminAuth";
        private const string RememberMeCookieName = "RememberAdmin";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            // Check if admin is already authenticated via cookie or session
            if (IsAuthenticated())
            {
                Response.Redirect("~/Pages/Admin/Dashboard/AdminInfo.aspx");
            }

            // Handle query string messages
            var msg = Request.QueryString["msg"];
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

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            var id = txtAdminId.Text.Trim();
            var passkey = txtPasskey.Text.Trim();

            if (string.IsNullOrEmpty(id) || string.IsNullOrEmpty(passkey))
            {
                ShowMessage("Please enter both Admin ID and Passkey.", "error");
                return;
            }

            var adminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
            var adminPasskey = System.Configuration.ConfigurationManager.AppSettings["AdminPasskey"];

            if (id == adminId && passkey == adminPasskey)
            {
                // Set up authentication with both session and persistent cookie
                SetupAdminAuthentication();

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

        private void SetupAdminAuthentication()
        {
            var adminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];

            // Set up session variables
            Session["IsAdminAuthenticated"] = true;
            Session["AdminId"] = adminId;
            Session["LoginTime"] = DateTime.Now;

            // Set session timeout
            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            Session.Timeout = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            // Create persistent authentication cookie
            CreateAuthenticationCookie(adminId);

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

        private void CreateAuthenticationCookie(string adminId)
        {
            // Create authentication ticket
            var authTicket = new FormsAuthenticationTicket(
                1, // version
                adminId, // username
                DateTime.Now, // issue time
                DateTime.Now.AddDays(30), // expiration (30 days)
                true, // persistent
                "Admin", // user data
                FormsAuthentication.FormsCookiePath
            );

            // Encrypt the ticket
            var encryptedTicket = FormsAuthentication.Encrypt(authTicket);

            // Create the cookie
            var authCookie = new HttpCookie(AuthCookieName, encryptedTicket)
            {
                Expires = DateTime.Now.AddDays(30), // Cookie expires in 30 days
                HttpOnly = true, // Prevent XSS attacks
                Secure = Request.IsSecureConnection, // Use HTTPS if available
                SameSite = SameSiteMode.Lax // CSRF protection
            };

            // Add the cookie to response
            Response.Cookies.Add(authCookie);
        }

        private void UpdateDatabaseAndGetInfo()
        {
            var connectionString = System.Configuration.ConfigurationManager
                .ConnectionStrings["DefaultConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                // No database configured, use defaults
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
                return;
            }

            using var conn = new SqlConnection(connectionString);
            conn.Open();

            // Get current admin data
            const string selectQuery = "SELECT name, email, signed_in_count FROM [admin]";
            var adminName = "Administrator";
            var adminEmail = "";
            var currentCount = 0;

            using (var selectCmd = new SqlCommand(selectQuery, conn))
            {
                using (var reader = selectCmd.ExecuteReader())
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
            const string updateQuery =
                "UPDATE [admin] SET is_signed_in = 1, signed_in_count = @newCount, last_login = @loginTime";
            using (var updateCmd = new SqlCommand(updateQuery, conn))
            {
                updateCmd.Parameters.AddWithValue("@newCount", currentCount + 1);
                updateCmd.Parameters.AddWithValue("@loginTime", DateTime.Now);
                updateCmd.ExecuteNonQuery();
            }

            // Set session variables
            Session["AdminName"] = adminName;
            Session["AdminEmail"] = adminEmail;
            Session["SignInCount"] = currentCount + 1;
        }

        private bool IsAuthenticated()
        {
            // First check session (for current browser session)
            if (Session["IsAdminAuthenticated"] != null &&
                (bool)Session["IsAdminAuthenticated"] &&
                !IsSessionExpired())
            {
                return true;
            }

            // If session is not valid, check authentication cookie
            return ValidateAuthenticationCookie();
        }

        private bool ValidateAuthenticationCookie()
        {
            var authCookie = Request.Cookies[AuthCookieName];
            if (authCookie == null || string.IsNullOrEmpty(authCookie.Value))
                return false;

            try
            {
                // Decrypt the authentication ticket
                var authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket == null || authTicket.Expired)
                {
                    // Cookie is invalid or expired, remove it
                    RemoveAuthenticationCookie();
                    return false;
                }

                // Validate the admin ID
                var configAdminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
                if (authTicket.Name != configAdminId)
                {
                    RemoveAuthenticationCookie();
                    return false;
                }

                // Cookie is valid, restore session data
                RestoreSessionFromCookie(authTicket);
                return true;
            }
            catch
            {
                // Cookie is corrupted, remove it
                RemoveAuthenticationCookie();
                return false;
            }
        }

        private void RestoreSessionFromCookie(FormsAuthenticationTicket authTicket)
        {
            // Restore session variables from cookie authentication
            Session["IsAdminAuthenticated"] = true;
            Session["AdminId"] = authTicket.Name;
            Session["LoginTime"] = DateTime.Now; // Reset login time for session timeout

            // Set session timeout
            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            Session.Timeout = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            // Try to get additional info from database
            try
            {
                RestoreAdditionalSessionData();
            }
            catch
            {
                // If database operations fail, use defaults
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
            }
        }

        private void RestoreAdditionalSessionData()
        {
            var connectionString = System.Configuration.ConfigurationManager
                .ConnectionStrings["DefaultConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
                return;
            }

            using var conn = new SqlConnection(connectionString);
            conn.Open();

            const string selectQuery = "SELECT name, email, signed_in_count FROM [admin]";
            using var cmd = new SqlCommand(selectQuery, conn);
            using var reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Session["AdminName"] = reader["name"]?.ToString() ?? "Administrator";
                Session["AdminEmail"] = reader["email"]?.ToString() ?? "";
                Session["SignInCount"] = Convert.ToInt32(reader["signed_in_count"] ?? 0);
            }
            else
            {
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
            }
        }

        private void RemoveAuthenticationCookie()
        {
            var expiredCookie = new HttpCookie(AuthCookieName, "")
            {
                Expires = DateTime.Now.AddDays(-1), // Set to past date to delete
                HttpOnly = true,
                Secure = Request.IsSecureConnection,
                SameSite = SameSiteMode.Lax
            };
            Response.Cookies.Add(expiredCookie);
        }

        private bool IsSessionExpired()
        {
            if (Session["LoginTime"] == null) return true;

            var loginTime = (DateTime)Session["LoginTime"];
            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            var timeoutMinutes = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            return DateTime.Now.Subtract(loginTime).TotalMinutes > timeoutMinutes;
        }

        // Static methods for use in other pages
        public static bool RequireAuthentication()
        {
            var context = System.Web.HttpContext.Current;
            var page = (Page)context.Handler;

            // Check session first
            if (page.Session["IsAdminAuthenticated"] != null &&
                (bool)page.Session["IsAdminAuthenticated"] &&
                !IsSessionExpiredStatic())
            {
                return true;
            }

            // Check authentication cookie
            if (ValidateAuthenticationCookieStatic())
            {
                return true;
            }

            // Not authenticated
            context.Response.Redirect("~/Pages/Admin/Login.aspx?msg=access");
            return false;
        }

        private static bool IsSessionExpiredStatic()
        {
            var context = System.Web.HttpContext.Current;
            if (context.Session["LoginTime"] == null) return true;

            var loginTime = (DateTime)context.Session["LoginTime"];
            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            var timeoutMinutes = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            return DateTime.Now.Subtract(loginTime).TotalMinutes > timeoutMinutes;
        }

        private static bool ValidateAuthenticationCookieStatic()
        {
            var context = System.Web.HttpContext.Current;
            var authCookie = context.Request.Cookies[AuthCookieName];

            if (authCookie == null || string.IsNullOrEmpty(authCookie.Value))
                return false;

            try
            {
                var authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket == null || authTicket.Expired)
                {
                    RemoveAuthenticationCookieStatic();
                    return false;
                }

                var configAdminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
                if (authTicket.Name != configAdminId)
                {
                    RemoveAuthenticationCookieStatic();
                    return false;
                }

                // Restore session from cookie
                RestoreSessionFromCookieStatic(authTicket);
                return true;
            }
            catch
            {
                RemoveAuthenticationCookieStatic();
                return false;
            }
        }

        private static void RestoreSessionFromCookieStatic(FormsAuthenticationTicket authTicket)
        {
            var context = System.Web.HttpContext.Current;

            context.Session["IsAdminAuthenticated"] = true;
            context.Session["AdminId"] = authTicket.Name;
            context.Session["LoginTime"] = DateTime.Now;

            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            context.Session.Timeout = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            try
            {
                RestoreAdditionalSessionDataStatic();
            }
            catch
            {
                context.Session["AdminName"] = "Administrator";
                context.Session["AdminEmail"] = "";
                context.Session["SignInCount"] = 1;
            }
        }

        private static void RestoreAdditionalSessionDataStatic()
        {
            var context = System.Web.HttpContext.Current;
            var connectionString = System.Configuration.ConfigurationManager
                .ConnectionStrings["DefaultConnection"]?.ConnectionString;

            if (string.IsNullOrEmpty(connectionString))
            {
                context.Session["AdminName"] = "Administrator";
                context.Session["AdminEmail"] = "";
                context.Session["SignInCount"] = 1;
                return;
            }

            using var conn = new SqlConnection(connectionString);
            conn.Open();

            const string selectQuery = "SELECT name, email, signed_in_count FROM [admin]";
            using var cmd = new SqlCommand(selectQuery, conn);
            using var reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                context.Session["AdminName"] = reader["name"]?.ToString() ?? "Administrator";
                context.Session["AdminEmail"] = reader["email"]?.ToString() ?? "";
                context.Session["SignInCount"] = Convert.ToInt32(reader["signed_in_count"] ?? 0);
            }
            else
            {
                context.Session["AdminName"] = "Administrator";
                context.Session["AdminEmail"] = "";
                context.Session["SignInCount"] = 1;
            }
        }

        private static void RemoveAuthenticationCookieStatic()
        {
            var context = System.Web.HttpContext.Current;
            var expiredCookie = new HttpCookie(AuthCookieName, "")
            {
                Expires = DateTime.Now.AddDays(-1),
                HttpOnly = true,
                Secure = context.Request.IsSecureConnection,
                SameSite = SameSiteMode.Lax
            };
            context.Response.Cookies.Add(expiredCookie);
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
                    using var conn = new SqlConnection(connectionString);
                    conn.Open();
                    const string query = "UPDATE [admin] SET is_signed_in = 0";
                    using var cmd = new SqlCommand(query, conn);
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                // Ignore database errors during logout
            }

            // Remove authentication cookie
            RemoveAuthenticationCookieStatic();

            // Clear session and redirect
            context.Session.Clear();
            context.Session.Abandon();
            context.Response.Redirect("~/Pages/Admin/Login.aspx?msg=signout");
        }

        // Helper properties
        public static string CurrentAdminId => System.Web.HttpContext.Current?.Session["AdminId"]?.ToString() ?? "";

        private static string CurrentAdminName =>
            System.Web.HttpContext.Current?.Session["AdminName"]?.ToString() ?? "Administrator";

        public static string CurrentAdminEmail =>
            System.Web.HttpContext.Current?.Session["AdminEmail"]?.ToString() ?? "";

        public static int SignInCount => Convert.ToInt32(System.Web.HttpContext.Current?.Session["SignInCount"] ?? 0);

        public static string GetSessionInfo()
        {
            var context = System.Web.HttpContext.Current;

            if (context?.Session["IsAdminAuthenticated"] == null ||
                !(bool)context.Session["IsAdminAuthenticated"])
                return "Not authenticated";

            if (context.Session["LoginTime"] == null) return $"Logged in as: {CurrentAdminName}";
            var loginTime = (DateTime)context.Session["LoginTime"];
            var duration = DateTime.Now - loginTime;
            return
                $"Logged in as: {CurrentAdminName} | Session: {duration.Hours:00}:{duration.Minutes:00}:{duration.Seconds:00}";
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