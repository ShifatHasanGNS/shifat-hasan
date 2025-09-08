using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace shifat_hasan.Pages.Admin.Dashboard
{
    public partial class UserFeedbacks : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllFeedback();
                LoadStatistics();
            }
        }
        
        protected string GetReplyText(object adminMessageBody, object userName)
        {
            if (!string.IsNullOrEmpty(adminMessageBody?.ToString()))
            {
                return adminMessageBody.ToString();
            }
    
            return $"Dear {userName},\n\nThank you for contacting us. We have received your message and appreciate your feedback.\n\n[Your response here]\n\nBest regards,\nAdmin Team";
        }

        #region Data Loading Methods

        private void LoadAllFeedback()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT id, datetime_user_feedback, datetime_admin_reply, user_email, user_name, 
                                    user_message_title, user_message_body, admin_message_title, admin_message_body 
                                    FROM [contact] 
                                    ORDER BY datetime_user_feedback DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                rptFeedback.DataSource = dt;
                                rptFeedback.DataBind();
                                pnlNoFeedback.Visible = false;
                            }
                            else
                            {
                                rptFeedback.DataSource = null;
                                rptFeedback.DataBind();
                                pnlNoFeedback.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage($"Database error loading feedback: {sqlEx.Message}", "alert-error");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading feedback: {ex.Message}", "alert-error");
            }
        }

        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get total feedback count
                    string totalQuery = "SELECT COUNT(*) FROM [contact]";
                    using (SqlCommand cmd = new SqlCommand(totalQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        int totalCount = result != null ? Convert.ToInt32(result) : 0;
                        lblTotalFeedback.Text = totalCount.ToString();
                    }

                    // Get pending replies count
                    string pendingQuery =
                        "SELECT COUNT(*) FROM [contact] WHERE admin_message_title IS NULL OR admin_message_title = ''";
                    using (SqlCommand cmd = new SqlCommand(pendingQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        int pendingCount = result != null ? Convert.ToInt32(result) : 0;
                        lblPendingReplies.Text = pendingCount.ToString();
                    }

                    // Get replied feedback count
                    string repliedQuery =
                        "SELECT COUNT(*) FROM [contact] WHERE admin_message_title IS NOT NULL AND admin_message_title <> ''";
                    using (SqlCommand cmd = new SqlCommand(repliedQuery, conn))
                    {
                        object result = cmd.ExecuteScalar();
                        int repliedCount = result != null ? Convert.ToInt32(result) : 0;
                        lblRepliedFeedback.Text = repliedCount.ToString();
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage($"Database error loading statistics: {sqlEx.Message}", "alert-error");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading statistics: {ex.Message}", "alert-error");
            }
        }

        #endregion

        #region Search Methods

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();

            if (string.IsNullOrEmpty(searchTerm))
            {
                LoadAllFeedback();
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT id, datetime_user_feedback, datetime_admin_reply, user_email, user_name, 
                                    user_message_title, user_message_body, admin_message_title, admin_message_body 
                                    FROM [contact] 
                                    WHERE user_name LIKE @search OR user_email LIKE @search OR user_message_title LIKE @search OR user_message_body LIKE @search
                                    ORDER BY datetime_user_feedback DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@search", "%" + searchTerm + "%");
                        conn.Open();

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                rptFeedback.DataSource = dt;
                                rptFeedback.DataBind();
                                pnlNoFeedback.Visible = false;
                                ShowMessage($"Found {dt.Rows.Count} feedback(s) matching '{searchTerm}'.",
                                    "alert-info");
                            }
                            else
                            {
                                rptFeedback.DataSource = null;
                                rptFeedback.DataBind();
                                pnlNoFeedback.Visible = true;
                                ShowMessage($"No feedback found matching '{searchTerm}'.", "alert-warning");
                            }
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage($"Database error searching feedback: {sqlEx.Message}", "alert-error");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error searching feedback: {ex.Message}", "alert-error");
            }
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadAllFeedback();
            LoadStatistics();
            ShowMessage("Showing all feedback records.", "alert-info");
        }

        #endregion

        #region Feedback Actions

        protected void rptFeedback_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!int.TryParse(e.CommandArgument.ToString(), out int contactId))
            {
                ShowMessage("Invalid contact ID.", "alert-error");
                return;
            }

            try
            {
                switch (e.CommandName)
                {
                    case "SendReply":
                        SendReply(e.Item, contactId);
                        break;
                    case "SaveReply":
                        SaveReply(e.Item, contactId);
                        break;
                    case "Delete":
                        DeleteFeedback(contactId);
                        break;
                    default:
                        ShowMessage("Unknown action requested.", "alert-warning");
                        break;
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error processing action: {ex.Message}", "alert-error");
            }
        }

        private void SendReply(RepeaterItem item, int contactId)
        {
            try
            {
                // Get the reply controls from the current item
                TextBox txtSubject = (TextBox)item.FindControl("txtReplySubject");
                TextBox txtMessage = (TextBox)item.FindControl("txtReplyMessage");

                if (txtSubject == null || txtMessage == null)
                {
                    ShowMessage("Error: Could not find reply controls.", "alert-error");
                    return;
                }

                string subject = txtSubject.Text.Trim();
                string message = txtMessage.Text.Trim();

                if (string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(message))
                {
                    ShowMessage("Please fill in both subject and message fields before sending.", "alert-warning");
                    return;
                }

                // Validate message length
                if (message.Length > 5000)
                {
                    ShowMessage("Reply message is too long. Please keep it under 5000 characters.", "alert-warning");
                    return;
                }

                // Get user details for this feedback
                var userDetails = GetUserDetails(contactId);
                if (userDetails == null)
                {
                    ShowMessage("Error: Could not retrieve user details for this feedback.", "alert-error");
                    return;
                }

                // Validate email address
                if (!IsValidEmail(userDetails.Email))
                {
                    ShowMessage($"Invalid email address: {userDetails.Email}", "alert-error");
                    return;
                }

                // Send email
                if (SendEmail(userDetails.Email, userDetails.Name, subject, message, userDetails.OriginalMessage))
                {
                    // Save to database
                    SaveReplyToDatabase(contactId, subject, message);
                    ShowMessage($"Reply sent successfully to {userDetails.Name} ({userDetails.Email})!",
                        "alert-success");

                    // Refresh data
                    LoadAllFeedback();
                    LoadStatistics();
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error sending reply: {ex.Message}", "alert-error");
            }
        }

        private void SaveReply(RepeaterItem item, int contactId)
        {
            try
            {
                // Get the reply controls from the current item
                TextBox txtSubject = (TextBox)item.FindControl("txtReplySubject");
                TextBox txtMessage = (TextBox)item.FindControl("txtReplyMessage");

                if (txtSubject == null || txtMessage == null)
                {
                    ShowMessage("Error: Could not find reply controls.", "alert-error");
                    return;
                }

                string subject = txtSubject.Text.Trim();
                string message = txtMessage.Text.Trim();

                if (string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(message))
                {
                    ShowMessage("Please fill in both subject and message fields before saving.", "alert-warning");
                    return;
                }

                // Validate message length
                if (message.Length > 5000)
                {
                    ShowMessage("Reply message is too long. Please keep it under 5000 characters.", "alert-warning");
                    return;
                }

                // Save to database without sending email
                SaveReplyToDatabase(contactId, subject, message);
                ShowMessage("Reply saved as draft successfully!", "alert-success");

                // Refresh data
                LoadAllFeedback();
                LoadStatistics();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error saving reply: {ex.Message}", "alert-error");
            }
        }

        private void DeleteFeedback(int contactId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM [contact] WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", contactId);
                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            ShowMessage("Feedback deleted successfully!", "alert-success");
                            LoadAllFeedback();
                            LoadStatistics();
                        }
                        else
                        {
                            ShowMessage("Feedback not found or already deleted.", "alert-warning");
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage($"Database error deleting feedback: {sqlEx.Message}", "alert-error");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting feedback: {ex.Message}", "alert-error");
            }
        }

        #endregion

        #region Email and Database Operations

        private UserDetails GetUserDetails(int contactId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query =
                        @"SELECT user_email, user_name, user_message_title, user_message_body, datetime_user_feedback 
                                    FROM [contact] WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", contactId);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                var feedbackDate = reader["datetime_user_feedback"] != DBNull.Value
                                    ? Convert.ToDateTime(reader["datetime_user_feedback"])
                                        .ToString("MMM dd, yyyy HH:mm")
                                    : "N/A";

                                return new UserDetails
                                {
                                    Email = reader["user_email"]?.ToString() ?? "",
                                    Name = reader["user_name"]?.ToString() ?? "",
                                    OriginalMessage =
                                        $"Original message from {reader["user_name"]} on {feedbackDate}:\n\n" +
                                        $"Title: {reader["user_message_title"]}\n" +
                                        $"Message: {reader["user_message_body"]}"
                                };
                            }
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage($"Database error retrieving user details: {sqlEx.Message}", "alert-error");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error retrieving user details: {ex.Message}", "alert-error");
            }

            return null;
        }

        private bool SendEmail(string toEmail, string toName, string subject, string message, string originalMessage)
        {
            try
            {
                var fromEmail = ConfigurationManager.AppSettings["EmailFromAddress"];
                var fromPassword = ConfigurationManager.AppSettings["SmtpPassword"];
                var smtpHost = ConfigurationManager.AppSettings["SmtpHost"] ?? "smtp.gmail.com";
                var smtpPort = int.TryParse(ConfigurationManager.AppSettings["SmtpPort"], out int port) ? port : 587;

                if (string.IsNullOrEmpty(fromEmail) || string.IsNullOrEmpty(fromPassword))
                {
                    ShowMessage("Email configuration is missing in web.config. Please contact the administrator.",
                        "alert-error");
                    return false;
                }

                using (var mailMessage = new MailMessage())
                {
                    mailMessage.From = new MailAddress(fromEmail, "Admin Team");
                    mailMessage.Subject = subject;
                    mailMessage.To.Add(new MailAddress(toEmail, toName));

                    // Create HTML body
                    var htmlBody = CreateEmailTemplate(message, originalMessage);
                    mailMessage.Body = htmlBody;
                    mailMessage.IsBodyHtml = true;
                    mailMessage.Priority = MailPriority.Normal;

                    using (var smtpClient = new SmtpClient(smtpHost))
                    {
                        smtpClient.Port = smtpPort;
                        smtpClient.Credentials = new NetworkCredential(fromEmail, fromPassword);
                        smtpClient.EnableSsl = true;
                        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                        smtpClient.Timeout = 30000; // 30 seconds timeout

                        smtpClient.Send(mailMessage);
                        return true;
                    }
                }
            }
            catch (SmtpException smtpEx)
            {
                string errorMessage = "SMTP Error: ";
                switch (smtpEx.StatusCode)
                {
                    case SmtpStatusCode.MailboxBusy:
                        errorMessage += "The recipient's mailbox is busy. Please try again later.";
                        break;
                    case SmtpStatusCode.MailboxUnavailable:
                        errorMessage += "The recipient's email address is invalid or unavailable.";
                        break;
                    case SmtpStatusCode.TransactionFailed:
                        errorMessage += "Email sending failed. Please check your email configuration.";
                        break;
                    case SmtpStatusCode.GeneralFailure:
                        errorMessage += "General SMTP failure. Please check your email settings.";
                        break;
                    default:
                        errorMessage += smtpEx.Message;
                        break;
                }

                ShowMessage(errorMessage, "alert-error");
                return false;
            }
            catch (Exception ex)
            {
                ShowMessage($"Email sending error: {ex.Message}", "alert-error");
                return false;
            }
        }

        private string CreateEmailTemplate(string message, string originalMessage)
        {
            // Escape HTML in user content
            string escapedMessage = System.Web.HttpUtility.HtmlEncode(message).Replace("\n", "<br/>");
            string escapedOriginalMessage = System.Web.HttpUtility.HtmlEncode(originalMessage).Replace("\n", "<br/>");

            return $@"
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset='utf-8'>
                    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                </head>
                <body style='font-family: -apple-system, BlinkMacSystemFont, ""Segoe UI"", Roboto, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 0; background-color: #f8fafc;'>
                    <div style='max-width: 600px; margin: 40px auto; background: white; border-radius: 12px; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1); overflow: hidden;'>
                        
                        <!-- Header -->
                        <div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center;'>
                            <h1 style='margin: 0; font-size: 24px; font-weight: 600;'>Response to Your Feedback</h1>
                        </div>
                        
                        <!-- Content -->
                        <div style='padding: 30px;'>
                            <div style='background: #f7fafc; padding: 20px; border-radius: 8px; margin-bottom: 25px; border-left: 4px solid #667eea;'>
                                {escapedMessage}
                            </div>
                            
                            <hr style='margin: 30px 0; border: none; border-top: 1px solid #e2e8f0;'/>
                            
                            <!-- Original Message -->
                            <div style='background: #f1f5f9; padding: 20px; border-radius: 8px; border-left: 4px solid #94a3b8;'>
                                <h3 style='margin: 0 0 15px 0; color: #475569; font-size: 16px;'>Your Original Message:</h3>
                                <div style='color: #64748b; font-size: 14px;'>{escapedOriginalMessage}</div>
                            </div>
                        </div>
                        
                        <!-- Footer -->
                        <div style='background: #f8fafc; padding: 20px; text-align: center; border-top: 1px solid #e2e8f0;'>
                            <p style='margin: 0; font-size: 12px; color: #64748b;'>
                                This email was sent in response to your feedback. Please do not reply directly to this email.
                            </p>
                            <p style='margin: 10px 0 0 0; font-size: 12px; color: #64748b;'>
                                &copy; {DateTime.Now.Year} Admin Team. All rights reserved.
                            </p>
                        </div>
                    </div>
                </body>
                </html>";
        }

        private void SaveReplyToDatabase(int contactId, string subject, string message)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE [contact] SET 
                                    admin_message_title = @admin_title,
                                    admin_message_body = @admin_body,
                                    datetime_admin_reply = @reply_date
                                    WHERE id = @id";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", contactId);
                        cmd.Parameters.AddWithValue("@admin_title", subject);
                        cmd.Parameters.AddWithValue("@admin_body", message);
                        cmd.Parameters.AddWithValue("@reply_date", DateTime.Now);

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result == 0)
                        {
                            ShowMessage("Warning: No feedback record was updated. The feedback may have been deleted.",
                                "alert-warning");
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                ShowMessage($"Database error saving reply: {sqlEx.Message}", "alert-error");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error saving reply to database: {ex.Message}", "alert-error");
            }
        }

        #endregion

        #region Helper Methods

        private void ShowMessage(string message, string cssClass)
        {
            if (string.IsNullOrEmpty(message))
                return;

            MessageLabel.Text = System.Web.HttpUtility.HtmlEncode(message);
            MessagePanel.Visible = true;
            alertDiv.Attributes["class"] = $"alert {cssClass}";
        }

        private bool IsValidEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
                return false;

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

        #endregion

        #region Helper Classes

        private class UserDetails
        {
            public string Email { get; set; } = "";
            public string Name { get; set; } = "";
            public string OriginalMessage { get; set; } = "";
        }

        #endregion
    }
}