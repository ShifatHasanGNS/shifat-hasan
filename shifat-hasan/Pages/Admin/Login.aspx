<%@ Page Title="Login" Language="C#" CodeBehind="Login.aspx.cs" Inherits="shifat_hasan.Pages.Admin.Login" ResponseEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Sign-In</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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
            background: var(--gradient-card);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: var(--shadow-2xl);
            border: 1px solid var(--slate-700);
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
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: var(--shadow-lg);
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
            color: var(--slate-100);
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .login-subtitle {
            color: var(--slate-400);
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
            color: var(--slate-300);
            font-weight: 600;
            font-size: 14px;
            letter-spacing: 0.025em;
        }

        .form-input {
            width: 100%;
            padding: 16px 20px 16px 50px;
            border: 2px solid var(--slate-700);
            border-radius: 12px;
            font-size: 16px;
            background: var(--slate-800);
            transition: var(--transition-normal);
            outline: none;
            color: var(--slate-100);
        }

        .form-input:focus {
            border-color: var(--accent-primary);
            background: var(--slate-900);
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
            transform: translateY(-1px);
        }

        .form-input::placeholder {
            color: var(--slate-500);
            font-weight: 400;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            fill: var(--slate-500);
            transition: var(--transition-normal);
            pointer-events: none;
            margin-top: 16px;
        }

        .form-group-icon:focus-within .input-icon {
            fill: var(--accent-primary);
            transform: translateY(-50%) scale(1.1);
        }

        .btn-signin {
            width: 100%;
            padding: 16px 24px;
            background: var(--gradient-primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-normal);
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .btn-signin:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
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
            color: var(--accent-primary);
            text-decoration: none;
            border: 2px solid var(--accent-primary);
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition-normal);
            background: transparent;
        }

        .btn-home:hover {
            background: var(--accent-primary);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
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
            background: var(--accent-success);
            color: white;
            border: none;
        }

        .alert-error {
            background: var(--accent-error);
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

        /* Focus Styles */
        .form-input:focus,
        .btn-signin:focus,
        .btn-home:focus {
            outline: 2px solid var(--accent-primary);
            outline-offset: 2px;
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