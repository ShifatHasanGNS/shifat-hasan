<%@ Page Language="C#" CodeBehind="AdminInfo.aspx.cs" Inherits="shifat_hasan.Pages.Admin.Dashboard.AdminInfo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Information</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Navigation Styling */
        .admin-nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .admin-nav h1 {
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 2rem;
            font-weight: 700;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #374151;
            text-decoration: none;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(255, 255, 255, 0.7);
            border: 1px solid rgba(102, 126, 234, 0.2);
        }

        .nav-links a:hover {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .signout-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626) !important;
            color: white !important;
            border: none !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.4) !important;
        }

        .signout-btn:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.6) !important;
        }

        /* Main Section */
        .admin-info-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
        }

        .section-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .edit-btn {
            background: rgba(255, 255, 255, 0.2) !important;
            color: white !important;
            border: 2px solid rgba(255, 255, 255, 0.3) !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            backdrop-filter: blur(10px) !important;
        }

        .edit-btn:hover {
            background: rgba(255, 255, 255, 0.3) !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.2) !important;
        }

        .status-indicator {
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Message Container */
        .message-container {
            margin: 2rem;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            border-left: 4px solid;
        }

        .message-container.success {
            background: rgba(34, 197, 94, 0.1);
            color: #059669;
            border-left-color: #10b981;
        }

        .message-container.error {
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            border-left-color: #ef4444;
        }

        .session-info {
            padding: 1rem 2rem;
            background: rgba(102, 126, 234, 0.1);
            color: #4f46e5;
            font-weight: 500;
        }

        /* Info Display Grid */
        .info-display, .info-edit {
            padding: 2rem;
        }

        .info-grid, .edit-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
        }

        .info-section, .edit-section {
            background: rgba(248, 250, 252, 0.8);
            padding: 2rem;
            border-radius: 16px;
            border: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
        }

        .info-section:hover, .edit-section:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .info-section h3, .edit-section h3 {
            color: #374151;
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid;
            border-image: linear-gradient(135deg, #667eea, #764ba2) 1;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            margin-bottom: 1rem;
        }

        .info-item label {
            font-weight: 600;
            color: #6b7280;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .info-item span {
            color: #374151;
            font-weight: 500;
            padding: 0.5rem 0;
        }

        /* Social Links */
        .social-links {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .social-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .social-item label {
            font-weight: 600;
            color: #6b7280;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .social-item a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem;
            border-radius: 8px;
            background: rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
            word-break: break-all;
            font-size: 0.9rem;
        }

        .social-item a:hover {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            transform: translateX(5px);
        }

        .social-item span {
            color: #667eea;
            font-weight: 500;
            padding: 0.5rem;
            border-radius: 8px;
            background: rgba(102, 126, 234, 0.1);
            word-break: break-all;
            font-size: 0.9rem;
        }

        /* Form Styling */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-input {
            width: 100% !important;
            padding: 1rem !important;
            border: 2px solid #e5e7eb !important;
            border-radius: 12px !important;
            font-size: 1rem !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            background: #ffffff !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
            font-family: inherit !important;
        }

        .form-input:focus {
            outline: none !important;
            border-color: #667eea !important;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), 0 4px 12px rgba(0, 0, 0, 0.15) !important;
            transform: translateY(-1px) !important;
        }

        /* Edit Actions */
        .edit-actions {
            padding: 2rem;
            background: rgba(248, 250, 252, 0.5);
            border-top: 1px solid rgba(102, 126, 234, 0.1);
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .save-btn {
            background: linear-gradient(135deg, #10b981, #059669) !important;
            color: white !important;
            border: none !important;
            padding: 1rem 2rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4) !important;
            font-size: 1rem !important;
        }

        .save-btn:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.6) !important;
        }

        .cancel-btn {
            background: rgba(107, 114, 128, 0.1) !important;
            color: #6b7280 !important;
            border: 2px solid #e5e7eb !important;
            padding: 1rem 2rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            font-size: 1rem !important;
        }

        .cancel-btn:hover {
            background: #f3f4f6 !important;
            border-color: #d1d5db !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1) !important;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .admin-nav {
                flex-direction: column;
                text-align: center;
                padding: 1.5rem;
            }

            .admin-nav h1 {
                font-size: 1.5rem;
            }

            .nav-links {
                justify-content: center;
            }

            .section-header {
                flex-direction: column;
                text-align: center;
                padding: 1.5rem;
            }

            .info-grid, .edit-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .info-section, .edit-section {
                padding: 1.5rem;
            }

            .edit-actions {
                flex-direction: column;
                align-items: stretch;
                padding: 1.5rem;
            }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                transition: none !important;
                animation: none !important;
                transform: none !important;
            }
        }

        @media (prefers-contrast: more) {
            body {
                background: #ffffff;
            }

            .admin-nav,
            .admin-info-section {
                background: #ffffff;
                border: 2px solid #000000;
            }

            .section-header {
                background: #000000;
                color: #ffffff;
            }

            .nav-links a,
            .edit-btn,
            .save-btn,
            .cancel-btn,
            .signout-btn {
                border: 2px solid #000000 !important;
            }
        }

        /* Focus Styles for Keyboard Navigation */
        button:focus-visible,
        input:focus-visible,
        a:focus-visible {
            outline: 3px solid #667eea !important;
            outline-offset: 2px !important;
        }

        /* Loading Animation */
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        .loading {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Navigation Links -->
            <nav class="admin-nav">
                <h1>Admin Dashboard</h1>
                <div class="nav-links">
                    <a href="~/Pages/Home.aspx" runat="server">Home</a>
                    <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server">Showcase List</a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server">User Feedbacks</a>
                    <asp:Button ID="btnSignOut" runat="server" Text="Sign Out" CssClass="signout-btn" OnClick="btnSignOut_Click" OnClientClick="return confirmSignOut()" />
                </div>
            </nav>

            <!-- Admin Info Section -->
            <section class="admin-info-section">
                <header class="section-header">
                    <h2>Administrator Information</h2>
                    <div class="header-actions">
                        <button type="button" id="editToggleBtn" onclick="toggleEditMode()" class="edit-btn">Edit</button>
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
                <div id="displayMode" class="info-display">
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
                <div id="editMode" class="info-edit" style="display: none;">
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
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="Enter email address" TextMode="Email" />
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
                                <asp:TextBox ID="txtGitHub" runat="server" CssClass="form-input" placeholder="https://github.com/username" TextMode="Url" />
                            </div>
                            <div class="form-group">
                                <label for="txtLinkedIn">LinkedIn Profile</label>
                                <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-input" placeholder="https://linkedin.com/in/username" TextMode="Url" />
                            </div>
                            <div class="form-group">
                                <label for="txtFacebook">Facebook Profile</label>
                                <asp:TextBox ID="txtFacebook" runat="server" CssClass="form-input" placeholder="https://facebook.com/username" TextMode="Url" />
                            </div>
                            <div class="form-group">
                                <label for="txtInstagram">Instagram Profile</label>
                                <asp:TextBox ID="txtInstagram" runat="server" CssClass="form-input" placeholder="https://instagram.com/username" TextMode="Url" />
                            </div>
                            <div class="form-group">
                                <label for="txtYoutube">YouTube Channel</label>
                                <asp:TextBox ID="txtYoutube" runat="server" CssClass="form-input" placeholder="https://youtube.com/@username" TextMode="Url" />
                            </div>
                        </div>
                    </div>

                    <!-- Edit Actions -->
                    <div class="edit-actions">
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="save-btn" OnClick="btnSave_Click" />
                        <button type="button" onclick="cancelEdit()" class="cancel-btn">Cancel</button>
                    </div>
                </div>
            </section>
        </div>
    </form>

    <script type="text/javascript">
        // Store original values for cancel functionality
        let originalValues = {};

        function confirmSignOut() {
            return confirm('Are you sure you want to sign out? This will end your current session.');
        }

        function toggleEditMode() {
            let displayMode = document.getElementById('displayMode');
            let editMode = document.getElementById('editMode');
            let editBtn = document.getElementById('editToggleBtn');
            
            if (displayMode.style.display === 'none') {
                // Switch back to display mode
                displayMode.style.display = 'block';
                editMode.style.display = 'none';
                editBtn.innerHTML = 'Edit';
                hideMessage();
            } else {
                // Switch to edit mode
                storeOriginalValues();
                displayMode.style.display = 'none';
                editMode.style.display = 'block';
                editBtn.innerHTML = 'View';
                hideMessage();
            }
        }

        function cancelEdit() {
            // Restore original values
            restoreOriginalValues();
            
            // Switch back to display mode
            let displayMode = document.getElementById('displayMode');
            let editMode = document.getElementById('editMode');
            let editBtn = document.getElementById('editToggleBtn');
            
            displayMode.style.display = 'block';
            editMode.style.display = 'none';
            editBtn.innerHTML = 'Edit';
            hideMessage();
        }

        function storeOriginalValues() {
            let inputs = document.querySelectorAll('#editMode input[type="text"], #editMode input[type="email"], #editMode input[type="url"]');
            inputs.forEach(function(input) {
                originalValues[input.id] = input.value;
            });
        }

        function restoreOriginalValues() {
            for (let id in originalValues) {
                let input = document.getElementById(id);
                if (input) {
                    input.value = originalValues[id];
                }
            }
        }

        function showMessage(message, isSuccess) {
            let container = document.getElementById('messageContainer');
            let messageElement = container.querySelector('span') || container;
            
            messageElement.textContent = message;
            container.className = 'message-container ' + (isSuccess ? 'success' : 'error');
            container.style.display = 'block';
            
            // Auto-hide success messages
            if (isSuccess) {
                setTimeout(function() {
                    hideMessage();
                }, 3000);
            }
        }

        function hideMessage() {
            let container = document.getElementById('messageContainer');
            container.style.display = 'none';
        }

        // Handle server-side messages
        window.addEventListener('load', function() {
            let messageText = '<%= LiteralMessage.Text %>';
            if (messageText && messageText.trim() !== '') {
                let isSuccess = !messageText.toLowerCase().includes('error') && !messageText.toLowerCase().includes('failed');
                showMessage(messageText, isSuccess);
                
                // If save was successful, switch back to display mode
                if (isSuccess && messageText.toLowerCase().includes('saved')) {
                    setTimeout(function() {
                        let displayMode = document.getElementById('displayMode');
                        let editMode = document.getElementById('editMode');
                        let editBtn = document.getElementById('editToggleBtn');
                        
                        if (displayMode.style.display === 'none') {
                            displayMode.style.display = 'block';
                            editMode.style.display = 'none';
                            editBtn.innerHTML = 'Edit';
                        }
                    }, 100);
                }
            }
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Escape to cancel edit
            let editMode = document.getElementById('editMode');
            
            if (e.key === 'Escape') {
                editMode = document.getElementById('editMode');
                if (editMode.style.display !== 'none') {
                    cancelEdit();
                }
            }
            
            // Ctrl+S to save (prevent default browser save)
            if (e.ctrlKey && e.key === 's') {
                e.preventDefault();
                editMode = document.getElementById('editMode');
                if (editMode.style.display !== 'none') {
                    document.getElementById('<%= btnSave.ClientID %>').click();
                }
            }
        });
    </script>
</body>
</html>
