<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="shifat_hasan.Pages.Contact" ResponseEncoding="utf-8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        :root {
            /* Dark Theme Slate Color Palette */
            --slate-50: #f8fafc;
            --slate-100: #f1f5f9;
            --slate-200: #e2e8f0;
            --slate-300: #cbd5e1;
            --slate-400: #94a3b8;
            --slate-500: #64748b;
            --slate-600: #475569;
            --slate-700: #334155;
            --slate-800: #1e293b;
            --slate-900: #0f172a;
            --slate-950: #020617;
            
            /* Accent Colors */
            --accent-primary: #3b82f6;
            --accent-secondary: #8b5cf6;
            --accent-success: #10b981;
            --accent-warning: #f59e0b;
            --accent-error: #ef4444;
            
            /* Gradients */
            --gradient-primary: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            --gradient-dark: linear-gradient(135deg, var(--slate-800), var(--slate-900));
            --gradient-card: linear-gradient(135deg, var(--slate-800), var(--slate-700));
            
            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            
            /* Transitions */
            --transition-fast: 0.15s ease-in-out;
            --transition-normal: 0.3s ease-in-out;
            --transition-slow: 0.5s ease-in-out;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--gradient-dark);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .contact-page {
            min-height: 100vh;
            position: relative;
            overflow: hidden;
            padding: 4rem 1rem;
        }

        .contact-page::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%233b82f6" fill-opacity="0.02"><circle cx="30" cy="30" r="2"/></g></svg>');
            pointer-events: none;
        }

        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: start;
            position: relative;
            z-index: 1;
        }

        .contact-info {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .contact-header {
            text-align: left;
        }

        .contact-header h1 {
            font-size: clamp(2.5rem, 4vw, 4rem);
            font-weight: 700;
            margin: 0 0 1rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1.1;
        }

        .contact-header p {
            font-size: 1.25rem;
            color: var(--slate-400);
            line-height: 1.6;
            margin: 0;
            max-width: 500px;
        }

        .contact-methods {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .contact-method {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.5rem;
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            border: 1px solid rgba(59, 130, 246, 0.2);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
        }

        .contact-method:hover {
            transform: translateY(-2px);
            border-color: rgba(59, 130, 246, 0.4);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }

        .contact-method-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            flex-shrink: 0;
        }

        .contact-method-content h3 {
            margin: 0 0 0.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--slate-100);
        }

        .contact-method-content p {
            margin: 0;
            color: var(--slate-400);
            font-size: 0.95rem;
        }

        .contact-form-section {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 
                0 8px 32px rgba(0, 0, 0, 0.3),
                0 2px 8px rgba(0, 0, 0, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.2);
            position: relative;
            overflow: hidden;
        }

        .contact-form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient-primary);
            border-radius: 24px 24px 0 0;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .form-header h2 {
            font-size: 2rem;
            font-weight: 700;
            margin: 0 0 0.5rem;
            color: var(--slate-100);
        }

        .form-header p {
            color: var(--slate-400);
            margin: 0;
        }

        .contact-form {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            position: relative;
        }

        .form-group.half-width {
            display: contents;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .contact-form label {
            font-weight: 600;
            color: var(--slate-300);
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .required-asterisk {
            color: var(--accent-error);
            font-size: 1rem;
        }

        .contact-form input,
        .contact-form textarea {
            padding: 1rem 1.25rem !important;
            border: 2px solid var(--slate-700) !important;
            border-radius: 12px !important;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(15, 23, 42, 0.8) !important;
            backdrop-filter: blur(10px);
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.2) !important;
            appearance: none !important;
            -webkit-appearance: none !important;
            outline: none;
            width: 100%;
            box-sizing: border-box;
            color: var(--slate-100) !important;
            position: relative;
            z-index: 2;
        }

        .contact-form input::placeholder,
        .contact-form textarea::placeholder {
            color: var(--slate-500);
            opacity: 1;
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            border-color: var(--accent-primary) !important;
            box-shadow: 
                0 0 0 3px rgba(59, 130, 246, 0.1),
                inset 0 1px 3px rgba(0, 0, 0, 0.2),
                0 4px 12px rgba(59, 130, 246, 0.15) !important;
            transform: translateY(-1px);
            background: rgba(15, 23, 42, 0.95) !important;
        }

        .contact-form textarea {
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
            line-height: 1.6;
        }
        
        .submit-button {
            background: var(--gradient-primary) !important;
            color: white !important;
            padding: 1.25rem 2rem !important;
            border: none !important;
            border-radius: 12px !important;
            font-size: 1.1rem !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3) !important;
            text-transform: none !important;
            letter-spacing: 0 !important;
            width: 100% !important;
            box-sizing: border-box !important;
            -webkit-appearance: none !important;
            appearance: none !important;
            position: relative;
            overflow: hidden;
            margin-top: 1rem;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .submit-button:hover::before {
            left: 100%;
        }
        
        .submit-button:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4) !important;
        }
        
        .submit-button:active {
            transform: translateY(0) !important;
        }

        .submit-button:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none !important;
        }

        /* Loading state */
        .submit-button.loading {
            pointer-events: none;
        }

        .submit-button.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Animation classes */
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        .slide-in {
            animation: slideIn 0.5s ease-out;
        }

        .pulse-on-hover:hover {
            animation: pulse 0.3s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-30px); }
            to { opacity: 1; transform: translateX(0); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        /* Success/Error Messages */
        .message {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-weight: 500;
            border: 1px solid;
        }

        .message.success {
            background: rgba(16, 185, 129, 0.1);
            border-color: var(--accent-success);
            color: var(--accent-success);
        }

        .message.error {
            background: rgba(239, 68, 68, 0.1);
            border-color: var(--accent-error);
            color: var(--accent-error);
        }

        /* Responsive Design */
        @media (max-width: 968px) {
            .contact-container {
                grid-template-columns: 1fr;
                gap: 3rem;
            }

            .contact-info {
                order: 2;
            }

            .contact-form-section {
                order: 1;
            }

            .contact-header {
                text-align: center;
            }

            .contact-header p {
                margin: 0 auto;
            }
        }

        @media (max-width: 768px) {
            .contact-page {
                padding: 2rem 1rem;
            }

            .contact-container {
                gap: 2rem;
            }

            .contact-form-section {
                padding: 2rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .contact-header h1 {
                font-size: 2.5rem;
            }

            .contact-header p {
                font-size: 1.1rem;
            }

            .form-header h2 {
                font-size: 1.75rem;
            }
        }

        @media (max-width: 480px) {
            .contact-page {
                padding: 1.5rem 1rem;
            }

            .contact-form-section {
                padding: 1.5rem;
                border-radius: 20px;
            }

            .contact-header h1 {
                font-size: 2rem;
            }

            .contact-method {
                padding: 1rem;
            }

            .contact-method-icon {
                width: 40px;
                height: 40px;
            }

            .submit-button {
                padding: 1rem 1.5rem !important;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }

            .submit-button::before {
                display: none !important;
            }
        }

        @media (prefers-contrast: more) {
            .contact-form-section {
                background: #ffffff;
                border: 2px solid #000000;
            }

            .contact-form input,
            .contact-form textarea {
                background: #ffffff !important;
                border: 2px solid #000000 !important;
                color: #000000 !important;
            }

            .submit-button {
                background: #000000 !important;
                border: 2px solid #000000 !important;
            }
        }

        /* Focus styles */
        .contact-method:focus,
        .submit-button:focus {
            outline: 2px solid var(--accent-primary);
            outline-offset: 2px;
        }

        /* High contrast mode support */
        @media (forced-colors: active) {
            .contact-form-section {
                border: 1px solid;
            }
            
            .submit-button {
                border: 1px solid !important;
            }
        }
    </style>
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
        
        function showFieldError(fieldId, message) {
            var field = document.getElementById(fieldId);
            if (field) {
                field.style.borderColor = 'var(--accent-error) !important';
                field.style.boxShadow = '0 0 0 3px rgba(239, 68, 68, 0.1) !important';
                
                // Show error message
                var errorDiv = document.createElement('div');
                errorDiv.className = 'field-error';
                errorDiv.textContent = message;
                errorDiv.style.color = 'var(--accent-error)';
                errorDiv.style.fontSize = '0.875rem';
                errorDiv.style.marginTop = '0.5rem';
                
                // Remove existing error message
                var existingError = field.parentNode.querySelector('.field-error');
                if (existingError) {
                    existingError.remove();
                }
                
                field.parentNode.appendChild(errorDiv);
            }
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