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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (IsAuthenticated())
            {
                Response.Redirect("~/Pages/Admin/Dashboard/AdminInfo.aspx");
            }

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
                SetupAdminAuthentication();
                txtAdminId.Text = "";
                txtPasskey.Text = "";
                Response.Redirect("~/Pages/Admin/Dashboard/AdminInfo.aspx");
            }
            else
            {
                txtAdminId.Text = "";
                txtPasskey.Text = "";
                ShowMessage("Invalid Admin ID or Passkey.", "error");
            }
        }

        private void SetupAdminAuthentication()
        {
            var adminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
            Session["IsAdminAuthenticated"] = true;
            Session["AdminId"] = adminId;
            Session["LoginTime"] = DateTime.Now;
            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            Session.Timeout = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);
            CreateAuthenticationCookie(adminId);
            try
            {
                UpdateDatabaseAndGetInfo();
            }
            catch
            {
                Session["AdminName"] = "Administrator";
                Session["AdminEmail"] = "";
                Session["SignInCount"] = 1;
            }
        }

        private void CreateAuthenticationCookie(string adminId)
        {
            var authTicket = new FormsAuthenticationTicket(
                1,
                adminId,
                DateTime.Now, // issue time
                DateTime.Now.AddDays(30), // expiration (30 days)
                true,
                "Admin",
                FormsAuthentication.FormsCookiePath
            );

            var encryptedTicket = FormsAuthentication.Encrypt(authTicket);

            var authCookie = new HttpCookie(AuthCookieName, encryptedTicket)
            {
                Expires = DateTime.Now.AddDays(30), // Cookie expires in 30 days
                HttpOnly = true, // Prevent XSS attacks
                Secure = Request.IsSecureConnection // Use HTTPS if available
            };

            Response.Cookies.Add(authCookie);
        }

        private void UpdateDatabaseAndGetInfo()
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

            // Get current admin info - use same query pattern as AdminInfo.aspx.cs
            const string selectQuery =
                "SELECT TOP 1 name, email, signed_in_count FROM [admin] ORDER BY CASE WHEN is_signed_in = 1 THEN 0 ELSE 1 END";
            var adminName = "Administrator";
            var adminEmail = "";
            var currentCount = 0;

            using (var selectCmd = new SqlCommand(selectQuery, conn))
            {
                using (var reader = selectCmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        adminName = reader["name"] == DBNull.Value
                            ? "Administrator"
                            : reader["name"]?.ToString() ?? "Administrator";
                        adminEmail = reader["email"] == DBNull.Value ? "" : reader["email"]?.ToString() ?? "";
                        currentCount = reader["signed_in_count"] == DBNull.Value
                            ? 0
                            : Convert.ToInt32(reader["signed_in_count"]);
                    }
                }
            }

            // Update admin record - only update the fields that definitely exist
            const string updateQuery = @"UPDATE [admin] SET 
                               is_signed_in = 1, 
                               signed_in_count = @newCount";
            using (var updateCmd = new SqlCommand(updateQuery, conn))
            {
                updateCmd.Parameters.AddWithValue("@newCount", currentCount + 1);
                var rowsAffected = updateCmd.ExecuteNonQuery();

                System.Diagnostics.Debug.WriteLine($"Admin login update: {rowsAffected} rows affected");

                if (rowsAffected == 0)
                {
                    throw new Exception("Failed to update admin login status - no rows affected");
                }
            }

            Session["AdminName"] = adminName;
            Session["AdminEmail"] = adminEmail;
            Session["SignInCount"] = currentCount + 1;
        }

        private bool IsAuthenticated()
        {
            if (Session["IsAdminAuthenticated"] != null &&
                (bool)Session["IsAdminAuthenticated"] &&
                !IsSessionExpired())
            {
                return true;
            }

            return ValidateAuthenticationCookie();
        }

        private bool ValidateAuthenticationCookie()
        {
            var authCookie = Request.Cookies[AuthCookieName];
            if (authCookie == null || string.IsNullOrEmpty(authCookie.Value))
                return false;

            try
            {
                var authTicket = FormsAuthentication.Decrypt(authCookie.Value);
                if (authTicket == null || authTicket.Expired)
                {
                    RemoveAuthenticationCookie();
                    return false;
                }

                var configAdminId = System.Configuration.ConfigurationManager.AppSettings["AdminId"];
                if (authTicket.Name != configAdminId)
                {
                    RemoveAuthenticationCookie();
                    return false;
                }

                RestoreSessionFromCookie(authTicket);
                return true;
            }
            catch
            {
                RemoveAuthenticationCookie();
                return false;
            }
        }

        private void RestoreSessionFromCookie(FormsAuthenticationTicket authTicket)
        {
            Session["IsAdminAuthenticated"] = true;
            Session["AdminId"] = authTicket.Name;
            Session["LoginTime"] = DateTime.Now; // Reset login time for session timeout

            var timeoutStr = System.Configuration.ConfigurationManager.AppSettings["SessionTimeoutMinutes"];
            Session.Timeout = string.IsNullOrEmpty(timeoutStr) ? 30 : int.Parse(timeoutStr);

            try
            {
                RestoreAdditionalSessionData();
            }
            catch
            {
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
                Secure = Request.IsSecureConnection
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
                Secure = context.Request.IsSecureConnection
            };
            context.Response.Cookies.Add(expiredCookie);
        }

        public static void Logout()
        {
            var context = System.Web.HttpContext.Current;
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
                    var rowsAffected = cmd.ExecuteNonQuery();

                    System.Diagnostics.Debug.WriteLine($"Admin logout update: {rowsAffected} rows affected");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Database error during logout: {ex.Message}");
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