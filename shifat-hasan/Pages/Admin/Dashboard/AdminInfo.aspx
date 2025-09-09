<%@ Page Language="C#" CodeBehind="AdminInfo.aspx.cs" 
    Inherits="shifat_hasan.Pages.Admin.Dashboard.AdminInfo" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Shifat | Admin-Info</title>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/AdminInfo.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/AdminInfo.js") %>'></script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Modern Admin Navigation -->
            <nav class="admin-nav">
                <div class="admin-nav-container">
                    <a class="header-title" href='<%= ResolveUrl("~/Pages/Admin/Dashboard/AdminInfo.aspx") %>'>
                        <span class="header-title-main">Admin Dashboard</span>
                        <span class="header-title-sub">Md. Shifat Hasan</span>
                    </a>
                    
                    <div class="admin-nav-links">
                        <a href="~/Pages/Home.aspx" runat="server" class="admin-nav-link">
                            <span>Home</span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-nav-link active">
                            <span>Admin Info</span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-nav-link">
                            <span>Showcase List</span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-nav-link">
                            <span>User Feedbacks</span>
                        </a>
                        <asp:Button ID="btnSignOut" runat="server" Text="Sign Out" CssClass="admin-signout-btn" OnClick="btnSignOut_Click" OnClientClick="return confirmSignOut()" />
                    </div>
                    
                    <button class="admin-mobile-menu-toggle" onclick="toggleAdminMobileMenu(event)">
                        <div class="admin-hamburger-line"></div>
                        <div class="admin-hamburger-line"></div>
                        <div class="admin-hamburger-line"></div>
                    </button>
                </div>
                
                <!-- Mobile Navigation -->
                <div class="admin-mobile-nav" id="adminMobileNav">
                    <a href="~/Pages/Home.aspx" runat="server" class="admin-mobile-link">Home</a>
                    <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-mobile-link active">Admin Info</a>
                    <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-mobile-link">Showcase List</a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-mobile-link">User Feedbacks</a>
                </div>
            </nav>

            <!-- Admin Info Section -->
            <section class="admin-info-section">
                <header class="section-header">
                    <h2>Administrator Information</h2>
                    <div class="header-actions">
                        <!-- Changed to server control instead of client-side button -->
                        <asp:Button ID="btnToggleEdit" runat="server" Text="Edit" CssClass="edit-btn" OnClick="btnToggleEdit_Click" />
                        <span class="status-indicator" id="statusIndicator">
                            <asp:Literal ID="LiteralStatus" runat="server" />
                        </span>
                    </div>
                </header>

                <!-- Status Message -->
                <div id="messageContainer" class="message-container" style="display: none;">
                    <asp:Literal ID="LiteralMessage" runat="server" />
                </div>

                <!-- Session Info -->
                <div class="session-info">
                    <small>
                        <asp:Literal ID="LiteralSessionInfo" runat="server" />
                    </small>
                </div>

                <!-- Display Mode -->
                <div id="displayMode" class="info-display" runat="server">
                    <div class="info-grid">
                        <!-- Personal Information -->
                        <div class="info-section">
                            <h3>Personal Information</h3>
                            <div class="info-item">
                                <label>Full Name</label>
                                <span><asp:Literal ID="DisplayName" runat="server" /></span>
                            </div>
                            <div class="info-item">
                                <label>Country</label>
                                <span><asp:Literal ID="DisplayCountry" runat="server" /></span>
                            </div>
                            <div class="info-item">
                                <label>Email</label>
                                <span><asp:Literal ID="DisplayEmail" runat="server" /></span>
                            </div>
                        </div>

                        <!-- Academic Information -->
                        <div class="info-section">
                            <h3>Academic Information</h3>
                            <div class="info-item">
                                <label>University</label>
                                <span><asp:Literal ID="DisplayUniversity" runat="server" /></span>
                            </div>
                            <div class="info-item">
                                <label>Current Institution</label>
                                <span><asp:Literal ID="DisplayCurrentInstitution" runat="server" /></span>
                            </div>
                        </div>

                        <!-- Social Media Links -->
                        <div class="info-section">
                            <h3>Social Media</h3>
                            <div class="social-links">
                                <div class="social-item">
                                    <label>GitHub</label>
                                    <asp:Literal ID="DisplayGithub" runat="server" />
                                </div>
                                <div class="social-item">
                                    <label>LinkedIn</label>
                                    <asp:Literal ID="DisplayLinkedIn" runat="server" />
                                </div>
                                <div class="social-item">
                                    <label>Facebook</label>
                                    <asp:Literal ID="DisplayFacebook" runat="server" />
                                </div>
                                <div class="social-item">
                                    <label>Instagram</label>
                                    <asp:Literal ID="DisplayInstagram" runat="server" />
                                </div>
                                <div class="social-item">
                                    <label>YouTube</label>
                                    <asp:Literal ID="DisplayYoutube" runat="server" />
                                </div>
                            </div>
                        </div>

                        <!-- System Information -->
                        <div class="info-section">
                            <h3>System Information</h3>
                            <div class="info-item">
                                <label>Sign-in Status</label>
                                <span><asp:Literal ID="DisplaySignInStatus" runat="server" /></span>
                            </div>
                            <div class="info-item">
                                <label>Total Sign-ins</label>
                                <span><asp:Literal ID="DisplaySignInCount" runat="server" /></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Edit Mode -->
                <div id="editMode" class="info-edit" runat="server" style="display: none;">
                    <div class="edit-grid">
                        <!-- Personal Information Edit -->
                        <div class="edit-section">
                            <h3>Personal Information</h3>
                            <div class="form-group">
                                <label for="txtName">Full Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="Enter full name" />
                            </div>
                            <div class="form-group">
                                <label for="txtCountry">Country</label>
                                <asp:TextBox ID="txtCountry" runat="server" CssClass="form-input" placeholder="Enter country" />
                            </div>
                            <div class="form-group">
                                <label for="txtEmail">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="Enter email address" TextMode="SingleLine" />
                            </div>
                        </div>

                        <!-- Academic Information Edit -->
                        <div class="edit-section">
                            <h3>Academic Information</h3>
                            <div class="form-group">
                                <label for="txtUniversity">University</label>
                                <asp:TextBox ID="txtUniversity" runat="server" CssClass="form-input" placeholder="Enter university name" />
                            </div>
                            <div class="form-group">
                                <label for="txtCurrentInstitution">Current Institution</label>
                                <asp:TextBox ID="txtCurrentInstitution" runat="server" CssClass="form-input" placeholder="Enter current institution" />
                            </div>
                        </div>

                        <!-- Social Media Edit -->
                        <div class="edit-section">
                            <h3>Social Media</h3>
                            <div class="form-group">
                                <label for="txtGitHub">GitHub Profile</label>
                                <asp:TextBox ID="txtGitHub" runat="server" CssClass="form-input" placeholder="https://github.com/username" TextMode="SingleLine" />
                            </div>
                            <div class="form-group">
                                <label for="txtLinkedIn">LinkedIn Profile</label>
                                <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-input" placeholder="https://linkedin.com/in/username" TextMode="SingleLine" />
                            </div>
                            <div class="form-group">
                                <label for="txtFacebook">Facebook Profile</label>
                                <asp:TextBox ID="txtFacebook" runat="server" CssClass="form-input" placeholder="https://facebook.com/username" TextMode="SingleLine" />
                            </div>
                            <div class="form-group">
                                <label for="txtInstagram">Instagram Profile</label>
                                <asp:TextBox ID="txtInstagram" runat="server" CssClass="form-input" placeholder="https://instagram.com/username" TextMode="SingleLine" />
                            </div>
                            <div class="form-group">
                                <label for="txtYoutube">YouTube Channel</label>
                                <asp:TextBox ID="txtYoutube" runat="server" CssClass="form-input" placeholder="https://youtube.com/@username" TextMode="SingleLine" />
                            </div>
                        </div>
                    </div>

                    <!-- Edit Actions -->
                    <div class="edit-actions">
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="save-btn" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click" />
                    </div>
                </div>
            </section>
        </div>

        <!-- Hidden field to track edit mode -->
        <asp:HiddenField ID="hiddenEditMode" runat="server" Value="false" />
    </form>

    <script type="text/javascript">
        // Handle server-side messages
        window.addEventListener('load', function() {
            let messageText = '<%= LiteralMessage.Text %>';
            if (messageText && messageText.trim() !== '') {
                let isSuccess = !messageText.toLowerCase().includes('error') && !messageText.toLowerCase().includes('failed');
                showMessage(messageText, isSuccess);
            }
        });

        // Keyboard shortcuts that need server controls
        document.addEventListener('keydown', function(e) {
            // Escape to cancel edit
            if (e.key === 'Escape') {
                let editMode = document.getElementById('<%= editMode.ClientID %>');
                if (editMode && editMode.style.display !== 'none') {
                    document.getElementById('<%= btnCancel.ClientID %>').click();
                }
            }

            // Ctrl+S to save (prevent default browser save)
            if (e.ctrlKey && e.key === 's') {
                e.preventDefault();
                let editMode = document.getElementById('<%= editMode.ClientID %>');
                if (editMode && editMode.style.display !== 'none') {
                    document.getElementById('<%= btnSave.ClientID %>').click();
                }
            }
        });
    </script>
</body>

</html>