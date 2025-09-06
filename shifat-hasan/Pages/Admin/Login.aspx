<%@ Page Title="Login" Language="C#" CodeBehind="Login.aspx.cs" Inherits="shifat_hasan.Pages.Admin.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Sign-In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .background-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 20% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            z-index: 1;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(1deg); }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 
                0 25px 50px -12px rgba(0, 0, 0, 0.25),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            position: relative;
            z-index: 2;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .admin-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .admin-icon svg {
            width: 40px;
            height: 40px;
            fill: white;
        }

        .login-title {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .login-subtitle {
            color: #718096;
            font-size: 16px;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group-icon {
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #4a5568;
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.025em;
        }

        .form-input {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            background: #f8fafc;
            transition: all 0.3s ease;
            outline: none;
            color: #2d3748;
        }

        .form-input:focus {
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        .form-input::placeholder {
            color: #a0aec0;
            font-weight: 400;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            fill: #a0aec0;
            transition: all 0.3s ease;
            pointer-events: none;
            margin-top: 16px;
        }

        .form-group-icon:focus-within .input-icon {
            fill: #667eea;
            transform: translateY(-50%) scale(1.1);
        }

        .btn-signin {
            width: 100%;
            padding: 16px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .btn-signin:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(102, 126, 234, 0.4);
        }

        .btn-signin:active {
            transform: translateY(0);
        }

        .btn-signin.loading {
            opacity: 0.8;
            cursor: not-allowed;
        }

        .btn-signin.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top-color: white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .btn-home {
            display: block;
            width: 100%;
            text-align: center;
            padding: 12px 24px;
            color: #667eea;
            text-decoration: none;
            border: 2px solid #667eea;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            background: transparent;
        }

        .btn-home:hover {
            background: #667eea;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }

        /* Alert Styles */
        .alert {
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            animation: slideDown 0.5s ease-out;
            transition: opacity 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #48bb78, #38a169);
            color: white;
            border: none;
        }

        .alert-error {
            background: linear-gradient(135deg, #f56565, #e53e3e);
            color: white;
            border: none;
        }

        .alert::before {
            content: '';
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-right: 12px;
            flex-shrink: 0;
        }

        .alert-success::before {
            background: rgba(255, 255, 255, 0.3);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 24 24'%3E%3Cpath d='M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z'/%3E%3C/svg%3E");
        }

        .alert-error::before {
            background: rgba(255, 255, 255, 0.3);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 24 24'%3E%3Cpath d='M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z'/%3E%3C/svg%3E");
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .login-container {
                margin: 20px;
                padding: 30px 25px;
            }

            .login-title {
                font-size: 24px;
            }

            .admin-icon {
                width: 70px;
                height: 70px;
            }

            .admin-icon svg {
                width: 35px;
                height: 35px;
            }

            .form-input {
                padding: 14px 18px 14px 45px;
            }

            .input-icon {
                left: 14px;
                width: 18px;
                height: 18px;
            }
        }

        /* Dark theme support */
        @media (prefers-color-scheme: dark) {
            body {
                background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
            }

            .login-container {
                background: rgba(26, 32, 44, 0.95);
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .login-title {
                color: #f7fafc;
            }

            .login-subtitle {
                color: #a0aec0;
            }

            .form-label {
                color: #e2e8f0;
            }

            .form-input {
                background: #2d3748;
                border-color: #4a5568;
                color: #f7fafc;
            }

            .form-input:focus {
                background: #374151;
                border-color: #667eea;
            }
        }

        /* Loading animation for better UX */
        .form-loading {
            position: relative;
        }

        .form-loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 20px;
            z-index: 10;
        }

        /* Accessibility improvements */
        .form-input:focus,
        .btn-signin:focus,
        .btn-home:focus {
            outline: 2px solid #667eea;
            outline-offset: 2px;
        }

        /* High contrast mode support */
        @media (prefers-contrast: more) {
            .form-input {
                border-width: 3px;
            }
            
            .btn-signin,
            .btn-home {
                border-width: 3px;
            }
        }

        /* Reduced motion support */
        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    </style>
</head>
<body>
    <div class="background-pattern"></div>
    
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <div class="admin-icon">
                    <svg viewBox="0 0 24 24">
                        <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                    </svg>
                </div>
                <h1 class="login-title">Admin Portal</h1>
                <p class="login-subtitle">Secure access to dashboard</p>
            </div>
            <asp:Panel ID="MessagePanel" runat="server" Visible="false">
                <div id="alertDiv" runat="server" class="alert">
                    <asp:Label ID="MessageLabel" runat="server"></asp:Label>
                </div>
            </asp:Panel>
            <div class="form-group form-group-icon">
                <label class="form-label">Admin ID</label>
                <asp:TextBox ID="txtAdminId" runat="server" CssClass="form-input" placeholder="Enter your admin ID" MaxLength="50"></asp:TextBox>
                <svg class="input-icon" viewBox="0 0 24 24">
                    <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                </svg>
            </div>
            <div class="form-group form-group-icon">
                <label class="form-label">Passkey</label>
                <asp:TextBox ID="txtPasskey" runat="server" TextMode="Password" CssClass="form-input" placeholder="Enter your passkey" MaxLength="100"></asp:TextBox>
                <svg class="input-icon" viewBox="0 0 24 24">
                    <path d="M18,8H17V6A5,5 0 0,0 12,1A5,5 0 0,0 7,6V8H6A2,2 0 0,0 4,10V20A2,2 0 0,0 6,22H18A2,2 0 0,0 20,20V10A2,2 0 0,0 18,8M12,3A3,3 0 0,1 15,6V8H9V6A3,3 0 0,1 12,3Z"/>
                </svg>
            </div>
            <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="btn-signin" OnClick="btnSignIn_Click" />
            
            <a href='<%= ResolveUrl("~/Pages/Home.aspx") %>' class="btn-home">Back to Home</a>
        </div>
    </form>
    <script type="text/javascript">
        // Auto-focus on first input when page loads
        window.onload = function() {
            var adminIdInput = document.getElementById('<%= txtAdminId.ClientID %>');
            if (adminIdInput) {
                adminIdInput.focus();
            }
        };
        // Handle Enter key press
        document.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                var button = document.getElementById('<%= btnSignIn.ClientID %>');
                if (button && !button.disabled) {
                    button.click();
                }
            }
        });
        // Auto-hide alert messages after 5 seconds
        setTimeout(function() {
            var messagePanel = document.getElementById('<%= MessagePanel.ClientID %>');
            if (messagePanel && messagePanel.style.display !== 'none' && messagePanel.offsetParent !== null) {
                messagePanel.style.opacity = '0';
                setTimeout(function() {
                    messagePanel.style.display = 'none';
                }, 300);
            }
        }, 5000);
    </script>
</body>
</html>