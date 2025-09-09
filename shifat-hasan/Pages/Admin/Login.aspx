<%@ Page Title="Login" Language="C#" CodeBehind="Login.aspx.cs" 
    Inherits="shifat_hasan.Pages.Admin.Login" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html>

<head runat="server">
    <title>Shifat | Log-In</title>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/Login.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/Login.js") %>'></script>
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
                messagePanel.style.transition = 'opacity 0.3s';
                messagePanel.style.opacity = '0';
                setTimeout(function() {
                    messagePanel.style.display = 'none';
                }, 300);
            }
        }, 5000);
    </script>
</body>

</html>