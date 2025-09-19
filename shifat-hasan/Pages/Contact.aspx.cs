using System;
using System.Configuration;
using System.Data.SqlClient;

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

                    // Check if user already exists and get current name
                    string checkQuery = "SELECT user_name FROM [user] WHERE user_email = @email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@email", userEmail);
                        object result = checkCmd.ExecuteScalar();

                        if (result == null)
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
                            // User exists, check if name needs updating
                            string existingName = result.ToString();
                            if (existingName != userName)
                            {
                                // Update name to stay synced with latest info
                                string updateUserQuery =
                                    "UPDATE [user] SET user_name = @name WHERE user_email = @email";
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
                    conn.Open();

                    // Always insert new contact record (no update operation)
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
            catch
            {
                throw new Exception("Database error occurred while saving your message. Please try again later.");
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