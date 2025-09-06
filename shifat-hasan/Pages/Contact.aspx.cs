using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace shifat_hasan.Pages
{
    public partial class Contact : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize any default values if needed
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateForm())
            {
                try
                {
                    // First, ensure user exists in user table
                    EnsureUserExists();

                    // Then save the contact message
                    SaveContactMessage();

                    // Send notification email to admin (optional)
                    SendNotificationEmail();

                    // Clear the form and show success message
                    ClearForm();
                    ShowSuccessMessage();
                }
                catch (Exception ex)
                {
                    ShowErrorMessage("An error occurred while processing your message: " + ex.Message);
                    System.Diagnostics.Debug.WriteLine($"Contact form error: {ex.Message}");
                }
            }
        }

        private bool ValidateForm()
        {
            bool isValid = true;
            string errorMessage = "";

            // Server-side validation as backup to client-side validation
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                errorMessage += "Name is required. ";
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                errorMessage += "Email is required. ";
                isValid = false;
            }
            else if (!IsValidEmail(txtEmail.Text.Trim()))
            {
                errorMessage += "Please enter a valid email address. ";
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(txtSubject.Text))
            {
                errorMessage += "Subject is required. ";
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(txtMessage.Text))
            {
                errorMessage += "Message is required. ";
                isValid = false;
            }

            // Check message length limits
            if (txtSubject.Text.Trim().Length > 500)
            {
                errorMessage += "Subject must be less than 500 characters. ";
                isValid = false;
            }

            if (txtMessage.Text.Trim().Length > 4000) // NTEXT can handle more, but let's set a reasonable limit
            {
                errorMessage += "Message must be less than 4000 characters. ";
                isValid = false;
            }

            if (!isValid)
            {
                ShowErrorMessage(errorMessage);
            }

            return isValid;
        }

        private bool IsValidEmail(string email)
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

        private void EnsureUserExists()
        {
            string userEmail = txtEmail.Text.Trim();
            string userName = txtName.Text.Trim();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Check if user already exists
                    string checkQuery = "SELECT COUNT(*) FROM [user] WHERE user_email = @email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@email", userEmail);
                        int userExists = (int)checkCmd.ExecuteScalar();

                        if (userExists == 0)
                        {
                            // User doesn't exist, create new user
                            string insertUserQuery =
                                "INSERT INTO [user] (user_email, user_name) VALUES (@email, @name)";
                            using (SqlCommand insertCmd = new SqlCommand(insertUserQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@email", userEmail);
                                insertCmd.Parameters.AddWithValue("@name", userName);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            // User exists, update name if it's different
                            string updateUserQuery = "UPDATE [user] SET user_name = @name WHERE user_email = @email";
                            using (SqlCommand updateCmd = new SqlCommand(updateUserQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("@email", userEmail);
                                updateCmd.Parameters.AddWithValue("@name", userName);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Number == 2627) // Unique constraint violation
                {
                    // This should be rare since we check first, but handle gracefully
                    System.Diagnostics.Debug.WriteLine($"User already exists: {userEmail}");
                }
                else
                {
                    throw; // Re-throw other SQL exceptions
                }
            }
        }

        private void SaveContactMessage()
        {
            string userEmail = txtEmail.Text.Trim();
            string userName = txtName.Text.Trim();
            string messageTitle = txtSubject.Text.Trim();
            string messageBody = txtMessage.Text.Trim();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check if a contact record already exists for this email
                    string checkContactQuery = "SELECT COUNT(*) FROM [contact] WHERE user_email = @email";
                    using (SqlCommand checkCmd = new SqlCommand(checkContactQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@email", userEmail);
                        conn.Open();
                        int contactExists = (int)checkCmd.ExecuteScalar();

                        if (contactExists > 0)
                        {
                            // Update existing contact record
                            string updateQuery = @"UPDATE [contact] SET 
                                                 user_name = @name,
                                                 user_message_title = @title,
                                                 user_message_body = @body,
                                                 datetime_user_feedback = @datetime,
                                                 admin_message_title = NULL,
                                                 admin_message_body = NULL,
                                                 datetime_admin_reply = NULL
                                                 WHERE user_email = @email";

                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("@email", userEmail);
                                updateCmd.Parameters.AddWithValue("@name", userName);
                                updateCmd.Parameters.AddWithValue("@title", messageTitle);
                                updateCmd.Parameters.AddWithValue("@body", messageBody);
                                updateCmd.Parameters.AddWithValue("@datetime", DateTime.Now);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            // Insert new contact record
                            string insertQuery = @"INSERT INTO [contact] 
                                                 (user_email, user_name, user_message_title, user_message_body, datetime_user_feedback)
                                                 VALUES (@email, @name, @title, @body, @datetime)";

                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@email", userEmail);
                                insertCmd.Parameters.AddWithValue("@name", userName);
                                insertCmd.Parameters.AddWithValue("@title", messageTitle);
                                insertCmd.Parameters.AddWithValue("@body", messageBody);
                                insertCmd.Parameters.AddWithValue("@datetime", DateTime.Now);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Number == 2627) // Unique constraint violation
                {
                    throw new Exception(
                        "A message from this email address already exists. Please wait for a response before sending another message.");
                }
                else
                {
                    throw new Exception("Database error occurred while saving your message. Please try again later.");
                }
            }
        }

        private void SendNotificationEmail()
        {
            // This method sends a notification to admin about new contact message
            try
            {
                var fromEmail = ConfigurationManager.AppSettings["EmailFromAddress"];
                var fromPassword = ConfigurationManager.AppSettings["SmtpPassword"];
                var adminEmail = ConfigurationManager.AppSettings["AdminNotificationEmail"];

                // If admin email is not configured, skip email notification
                if (string.IsNullOrEmpty(adminEmail))
                {
                    System.Diagnostics.Debug.WriteLine(
                        "Admin notification email not configured. Skipping email notification.");
                    return;
                }

                if (string.IsNullOrEmpty(fromEmail) || string.IsNullOrEmpty(fromPassword))
                {
                    System.Diagnostics.Debug.WriteLine("Email configuration missing. Skipping email notification.");
                    return;
                }

                using (var message = new MailMessage())
                {
                    message.From = new MailAddress(fromEmail, "Portfolio Website");
                    message.Subject = $"New Contact Message: {txtSubject.Text.Trim()}";
                    message.To.Add(new MailAddress(adminEmail));

                    var htmlBody = $@"
                        <!DOCTYPE html>
                        <html>
                        <body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>
                            <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                                <h2 style='color: #2c5aa0; border-bottom: 2px solid #2c5aa0; padding-bottom: 10px;'>New Contact Message</h2>
                                
                                <div style='background-color: #f9f9f9; padding: 20px; border-radius: 5px; margin: 20px 0;'>
                                    <p><strong>From:</strong> {txtName.Text.Trim()}</p>
                                    <p><strong>Email:</strong> {txtEmail.Text.Trim()}</p>
                                    <p><strong>Subject:</strong> {txtSubject.Text.Trim()}</p>
                                    <p><strong>Date:</strong> {DateTime.Now:MMM dd, yyyy HH:mm}</p>
                                </div>
                                
                                <div style='background-color: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 5px;'>
                                    <h3 style='margin-top: 0;'>Message:</h3>
                                    <p>{txtMessage.Text.Trim().Replace("\n", "<br/>")}</p>
                                </div>
                                
                                <div style='margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 11px; color: #888;'>
                                    <p>This notification was sent automatically from your portfolio website contact form.</p>
                                </div>
                            </div>
                        </body>
                        </html>";

                    message.Body = htmlBody;
                    message.IsBodyHtml = true;
                    message.Priority = MailPriority.Normal;

                    using (var smtpClient = new SmtpClient("smtp.gmail.com"))
                    {
                        smtpClient.Port = 587;
                        smtpClient.Credentials = new NetworkCredential(fromEmail, fromPassword);
                        smtpClient.EnableSsl = true;
                        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                        smtpClient.Timeout = 20000; // 20 seconds timeout

                        smtpClient.Send(message);
                        System.Diagnostics.Debug.WriteLine("Admin notification email sent successfully.");
                    }
                }
            }
            catch (Exception ex)
            {
                // Don't throw exception for notification email failure - it's not critical
                System.Diagnostics.Debug.WriteLine($"Admin notification email failed: {ex.Message}");
            }
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtSubject.Text = "";
            txtMessage.Text = "";
        }

        private void ShowSuccessMessage()
        {
            string script = @"
                alert('Thank you for your message! We have received your feedback and will get back to you soon.');
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
        }

        private void ShowErrorMessage(string message)
        {
            string script = $@"
                alert('Error: {message.Replace("'", "\\'")}');
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", script, true);
        }
    }
}