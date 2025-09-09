<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Contact.aspx.cs" Inherits="shifat_hasan.Pages.Contact" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shifat | Contact</title>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/Contact.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/Contact.js") %>'></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contact-page">
        <div class="contact-container">
            
            <div class="contact-info">
                
                <div class="contact-header fade-in">
                    <h1>Let's Connect</h1>
                    <p>I'm always interested in new opportunities, collaborations, and conversations about technology. Whether you have a project in mind or just want to say hello, I'd love to hear from you.</p>
                </div>
                
                <div class="contact-methods">
                    <a href="mailto:shifathasan.pro@gmail.com" class="contact-method slide-in">
                        <div class="contact-method-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M24 5.457v13.909c0 .904-.732 1.636-1.636 1.636h-3.819V11.73L12 16.64l-6.545-4.91v9.273H1.636A1.636 1.636 0 0 1 0 19.366V5.457c0-.904.732-1.636 1.636-1.636h1.034l9.33 7.87 9.33-7.87h1.034c.904 0 1.636.732 1.636 1.636z"/>
                            </svg>
                        </div>
                        <div class="contact-method-content">
                            <h3>Email</h3>
                            <p>shifathasan.pro@gmail.com</p>
                        </div>
                    </a>
                    
                    <a href="https://github.com/ShifatHasanGNS" target="_blank" rel="noopener noreferrer" class="contact-method slide-in">
                        <div class="contact-method-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                            </svg>
                        </div>
                        <div class="contact-method-content">
                            <h3>GitHub</h3>
                            <p>Check out my Projects and Contributions</p>
                        </div>
                    </a>
                    
                    <a href="https://www.linkedin.com/in/shifat-hasan" target="_blank" rel="noopener noreferrer" class="contact-method slide-in">
                        <div class="contact-method-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                            </svg>
                        </div>
                        <div class="contact-method-content">
                            <h3>LinkedIn</h3>
                            <p>Connect with me Professionally</p>
                        </div>
                    </a>
                    
                    <a href="https://www.facebook.com/ShifatHasanGNS" target="_blank" rel="noopener noreferrer" class="contact-method slide-in">
                        <div class="contact-method-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                            </svg>
                        </div>
                        <div class="contact-method-content">
                            <h3>Facebook</h3>
                            <p>Connect with me Casually</p>
                        </div>
                    </a>
                </div>
            </div>
            
            <div class="contact-form-section fade-in">
               
                <div class="form-header">
                    <h2>Send a Message</h2>
                    <p>Fill out the form below and I'll get back to you as soon as possible.</p>
                </div>
                
                <div class="contact-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="<%= txtName.ClientID %>">
                                Full Name <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtName" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="<%= txtEmail.ClientID %>">
                                Email Address <span class="required-asterisk">*</span>
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="<%= txtSubject.ClientID %>">
                            Subject <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtSubject" runat="server" />
                    </div>
                    
                    <div class="form-group">
                        <label for="<%= txtMessage.ClientID %>">
                            Message <span class="required-asterisk">*</span>
                        </label>
                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="6" />
                    </div>
                    
                    <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="submit-button pulse-on-hover" OnClientClick="return validateForm();" OnClick="btnSubmit_Click" />
                </div>
                
            </div>
            
        </div>
    </div>
    
    <script type="text/javascript">
        function validateForm() {
            // Get the actual client IDs of the controls
            var name = document.getElementById('<%= txtName.ClientID %>').value.trim();
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var subject = document.getElementById('<%= txtSubject.ClientID %>').value.trim();
            var message = document.getElementById('<%= txtMessage.ClientID %>').value.trim();

            // Clear previous error styles
            clearErrorStyles();

            var hasError = false;

            if (!name) {
                showFieldError('<%= txtName.ClientID %>', 'Name is required');
                hasError = true;
            }

            if (!email) {
                showFieldError('<%= txtEmail.ClientID %>', 'Email is required');
                hasError = true;
            } else {
                // Basic email validation
                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email)) {
                    showFieldError('<%= txtEmail.ClientID %>', 'Please enter a valid email address');
                    hasError = true;
                }
            }

            if (!subject) {
                showFieldError('<%= txtSubject.ClientID %>', 'Subject is required');
                hasError = true;
            }

            if (!message) {
                showFieldError('<%= txtMessage.ClientID %>', 'Message is required');
                hasError = true;
            }

            if (hasError) {
                return false;
            }

            // Show loading state
            var submitButton = document.getElementById('<%= btnSubmit.ClientID %>');
            if (submitButton) {
                submitButton.classList.add('loading');
                submitButton.disabled = true;
                submitButton.innerHTML = 'Sending...';
            }

            return true;
        }

        function clearErrorStyles() {
            // Remove all error messages
            var errorMessages = document.querySelectorAll('.field-error');
            errorMessages.forEach(function(error) {
                error.remove();
            });

            // Reset field styles
            var fields = [
                document.getElementById('<%= txtName.ClientID %>'),
                document.getElementById('<%= txtEmail.ClientID %>'),
                document.getElementById('<%= txtSubject.ClientID %>'),
                document.getElementById('<%= txtMessage.ClientID %>')
            ];

            fields.forEach(function(field) {
                if (field) {
                    field.style.borderColor = '';
                    field.style.boxShadow = '';
                }
            });
        }

        // Initialize form enhancements
        document.addEventListener('DOMContentLoaded', function() {
            // Add placeholders
            var nameField = document.getElementById('<%= txtName.ClientID %>');
            var emailField = document.getElementById('<%= txtEmail.ClientID %>');
            var subjectField = document.getElementById('<%= txtSubject.ClientID %>');
            var messageField = document.getElementById('<%= txtMessage.ClientID %>');

            if (nameField) nameField.placeholder = 'Enter your full name';
            if (emailField) emailField.placeholder = 'your.email@example.com';
            if (subjectField) subjectField.placeholder = 'What is this about?';
            if (messageField) messageField.placeholder = 'Tell me about your project, question, or how I can help you...';

            // Clear loading state on page load (in case of postback)
            var submitButton = document.getElementById('<%= btnSubmit.ClientID %>');
            if (submitButton) {
                submitButton.classList.remove('loading');
                submitButton.disabled = false;
                submitButton.innerHTML = 'Send Message';
            }
        });
    </script>
</asp:Content>