using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

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
            try
            {
                if (ValidateForm())
                {
                    // Create models from form data
                    UserModel user = new UserModel
                    {
                        Email = txtEmail.Text.Trim(),
                        Name = txtName.Text.Trim()
                    };

                    ContactModel contact = new ContactModel
                    {
                        UserEmail = txtEmail.Text.Trim(),
                        UserName = txtName.Text.Trim(),
                        MessageTitle = txtSubject.Text.Trim(),
                        MessageBody = txtMessage.Text.Trim(),
                        DateTimeUserFeedback = DateTime.Now
                    };

                    // First, ensure user exists in user table
                    EnsureUserExists(user);

                    // Then save the contact message
                    SaveContactMessage(contact);

                    // Send notification email to admin (optional)
                    SendNotificationEmail(contact);

                    // Clear the form and show success message
                    ClearForm();
                    ShowSuccessMessage();
                }
            }
            catch (Exception ex)
            {
                // Reset button state on error
                ResetButtonState();
                ShowErrorMessage("An error occurred while processing your message: " + ex.Message);
                System.Diagnostics.Debug.WriteLine($"Contact form error: {ex.Message}");
            }
        }

        private void ResetButtonState()
        {
            // This will be called from JavaScript after page loads
            string script = @"
                setTimeout(function() {
                    var submitButton = document.getElementById('" + btnSubmit.ClientID + @"');
                    if (submitButton) {
                        submitButton.classList.remove('loading');
                        submitButton.disabled = false;
                        submitButton.innerHTML = 'Send Message';
                    }
                }, 100);
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ResetButton", script, true);
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

            if (txtMessage.Text.Trim().Length > 4000)
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

        private void EnsureUserExists(UserModel user)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Check if user already exists
                    string checkQuery = "SELECT COUNT(*) FROM [user] WHERE user_email = @email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@email", user.Email);
                        int userExists = (int)checkCmd.ExecuteScalar();

                        if (userExists == 0)
                        {
                            // User doesn't exist, create new user
                            string insertUserQuery =
                                "INSERT INTO [user] (user_email, user_name) VALUES (@email, @name)";
                            using (SqlCommand insertCmd = new SqlCommand(insertUserQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@email", user.Email);
                                insertCmd.Parameters.AddWithValue("@name", user.Name);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            // User exists, update name if it's different
                            string updateUserQuery = "UPDATE [user] SET user_name = @name WHERE user_email = @email";
                            using (SqlCommand updateCmd = new SqlCommand(updateUserQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("@email", user.Email);
                                updateCmd.Parameters.AddWithValue("@name", user.Name);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error ensuring user exists: {ex.Message}");
                throw;
            }
        }

        private void SaveContactMessage(ContactModel contact)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    
                    // Insert new contact record
                    string insertQuery = @"INSERT INTO [contact] 
                                         (user_email, user_name, user_message_title, user_message_body, datetime_user_feedback)
                                         VALUES (@email, @name, @title, @body, @datetime)";

                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@email", contact.UserEmail);
                        insertCmd.Parameters.AddWithValue("@name", contact.UserName);
                        insertCmd.Parameters.AddWithValue("@title", contact.MessageTitle);
                        insertCmd.Parameters.AddWithValue("@body", contact.MessageBody);
                        insertCmd.Parameters.AddWithValue("@datetime", contact.DateTimeUserFeedback);
                        insertCmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error saving contact message: {ex.Message}");
                throw;
            }
        }

        private void SendNotificationEmail(ContactModel contact)
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
                    message.Subject = $"New Contact Message: {contact.MessageTitle}";
                    message.To.Add(new MailAddress(adminEmail));

                    var htmlBody = $@"
                        <!DOCTYPE html>
                        <html>
                        <body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>
                            <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                                <h2 style='color: #2c5aa0; border-bottom: 2px solid #2c5aa0; padding-bottom: 10px;'>New Contact Message</h2>
                                
                                <div style='background-color: #f9f9f9; padding: 20px; border-radius: 5px; margin: 20px 0;'>
                                    <p><strong>From:</strong> {contact.UserName}</p>
                                    <p><strong>Email:</strong> {contact.UserEmail}</p>
                                    <p><strong>Subject:</strong> {contact.MessageTitle}</p>
                                    <p><strong>Date:</strong> {contact.DateTimeUserFeedback:MMM dd, yyyy HH:mm}</p>
                                </div>
                                
                                <div style='background-color: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 5px;'>
                                    <h3 style='margin-top: 0;'>Message:</h3>
                                    <p>{contact.MessageBody.Replace("\n", "<br/>")}</p>
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
                // Reset button state
                var submitButton = document.getElementById('" + btnSubmit.ClientID + @"');
                if (submitButton) {
                    submitButton.classList.remove('loading');
                    submitButton.disabled = false;
                    submitButton.innerHTML = 'Send Message';
                }
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
        }

        private void ShowErrorMessage(string message)
        {
            string script = $@"
                alert('Error: {message.Replace("'", "\\'")}');
                // Reset button state
                var submitButton = document.getElementById('" + btnSubmit.ClientID + @"');
                if (submitButton) {
                    submitButton.classList.remove('loading');
                    submitButton.disabled = false;
                    submitButton.innerHTML = 'Send Message';
                }
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "ErrorMessage", script, true);
        }
    }

    // User model class
    public class UserModel
    {
        public string Email { get; set; }
        public string Name { get; set; }
        
        public string user_email => Email;
        public string user_name => Name;
    }

    // Contact model class
    public class ContactModel
    {
        public string UserEmail { get; set; }
        public string UserName { get; set; }
        public string MessageTitle { get; set; }
        public string MessageBody { get; set; }
        public DateTime DateTimeUserFeedback { get; set; }
        
        public string user_email => UserEmail;
        public string user_name => UserName;
        public string user_message_title => MessageTitle;
        public string user_message_body => MessageBody;
        public DateTime datetime_user_feedback => DateTimeUserFeedback;
    }
}