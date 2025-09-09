<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowcaseList.aspx.cs" 
    Inherits="shifat_hasan.Pages.Admin.Dashboard.ShowcaseList" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Shifat | Showcase-List</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/ShowcaseList.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/ShowcaseList.js") %>'></script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:HiddenField ID="hfEditProjectId" runat="server" />
        <asp:Button ID="btnLoadProjectForEdit" runat="server" style="display:none;" OnClick="btnLoadProjectForEdit_Click" />
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
                            <span class="admin-link-text">Home</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-nav-link">
                            <span class="admin-link-text">Admin Info</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-nav-link active">
                            <span class="admin-link-text">Showcase List</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-nav-link">
                            <span class="admin-link-text">User Feedbacks</span>
                            <span class="admin-link-underline"></span>
                        </a>
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
                    <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-mobile-link">Admin Info</a>
                    <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-mobile-link active">Showcase List</a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-mobile-link">User Feedbacks</a>
                </div>
            </nav>

            <!-- Message Panel -->
            <div id="messageContainer" class="message-container" style="display: none;">
                <asp:Literal ID="LiteralMessage" runat="server" />
            </div>

            <!-- Tab Navigation -->
            <div class="tabs-container">
                <button type="button" class="tab-btn active" onclick="showTab('gallery')">Project Gallery</button>
                <button type="button" class="tab-btn" onclick="showTab('add')">Add New Project</button>
            </div>

            <!-- Gallery Tab -->
            <div id="galleryTab" class="tab-content active">
                <div class="search-controls">
                    <div class="search-group">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search projects by title or description..." />
                        <asp:DropDownList ID="ddlTypeFilter" runat="server" CssClass="filter-select">
                            <asp:ListItem Value="" Text="Types"></asp:ListItem>
                            <asp:ListItem Value="feature" Text="Feature"></asp:ListItem>
                            <asp:ListItem Value="general" Text="General"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-btn" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="clear-btn" OnClick="btnClearSearch_Click" />
                    </div>
                </div>

                <div class="projects-grid">
                    <asp:Repeater ID="ProjectsRepeater" runat="server">
                        <ItemTemplate>
                            <div class="project-card" data-project-id='<%# Eval("id") %>'>
                                <div class="project-header">
                                    <span class="project-type"><%# Eval("type") %></span>
                                    <div class="project-actions">
                                        <button type="button" class="action-btn edit-btn" title="Edit Project" data-project-id='<%# Eval("id") %>' data-project-title='<%# Eval("title") %>'>✏️</button>
                                        <button type="button" class="action-btn delete-btn" title="Delete Project" data-project-id='<%# Eval("id") %>' data-project-title='<%# Eval("title") %>' onclick="deleteProjectSafe(this)">🗑️</button>
                                    </div>
                                </div>
                                
                                <div class="project-image">
                                    <%# !string.IsNullOrEmpty(Eval("url_cover_image")?.ToString()) ?
                                            "<img src='" + Eval("url_cover_image") + "' alt='" + Eval("title") + "' onerror=\"handleImageError(this)\" />" :
                                            "<div class='no-image'>📷 No Image</div>" %>
                                </div>
                                
                                <div class="project-content">
                                    <h3 class="project-title"><%# Eval("title") %></h3>
                                    <p class="project-description">
                                        <%# TruncateText(Eval("description")?.ToString(), 100) %>
                                    </p>
                                    
                                    <div class="project-links">
                                        <%# FormatProjectLinks(Eval("url_github")?.ToString(), Eval("url_drive")?.ToString(),
                                                Eval("url_youtube")?.ToString(), Eval("url_other")?.ToString()) %>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div id="noProjectsMessage" class="empty-state" style="display: none;">
                    <h3>No Projects Found</h3>
                    <p>No projects match your search criteria. Try adjusting your filters or add a new project.</p>
                </div>
            </div>
            
            <!-- Hidden Edit Form Modal -->
            <div id="editFormModal" class="tab-content" style="display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0, 0, 0, 0.8); z-index: 2000; padding: 2rem; overflow-y: auto;">
                <div style="max-width: 800px; margin: 0 auto; background: var(--slate-800); border-radius: 16px; border: 1px solid var(--slate-700); padding: 2rem;">
                    <div class="manage-header">
                        <h2>Edit Project</h2>
                        <p>Update the project details below</p>
                    </div>
                    
                    <div class="form-container">
                        
                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label">Project Type *</label>
                                <asp:DropDownList ID="ddlEditType" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="" Text="Select Project Type"></asp:ListItem>
                                    <asp:ListItem Value="feature" Text="Feature"></asp:ListItem>
                                    <asp:ListItem Value="general" Text="General"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Project Title *</label>
                                <asp:TextBox ID="txtEditTitle" runat="server" CssClass="form-input" placeholder="Enter project title" />
                            </div>

                            <div class="form-group span-2">
                                <label class="form-label">Project Description</label>
                                <asp:TextBox ID="txtEditDescription" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="4" placeholder="Enter detailed project description..." />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Cover Image URL</label>
                                <asp:TextBox ID="txtEditCoverImage" runat="server" CssClass="form-input" placeholder="https://example.com/image.jpg" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">GitHub Repository</label>
                                <asp:TextBox ID="txtEditGithub" runat="server" CssClass="form-input" placeholder="https://github.com/username/repo" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Google Drive Link</label>
                                <asp:TextBox ID="txtEditDrive" runat="server" CssClass="form-input" placeholder="https://drive.google.com/..." />
                            </div>

                            <div class="form-group">
                                <label class="form-label">YouTube Video</label>
                                <asp:TextBox ID="txtEditYoutube" runat="server" CssClass="form-input" placeholder="https://youtube.com/watch?v=..." />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Other Link</label>
                                <asp:TextBox ID="txtEditOther" runat="server" CssClass="form-input" placeholder="Any other relevant link" />
                            </div>
                        </div>

                        <div class="form-actions">
                            <asp:Button ID="btnUpdateProject" runat="server" Text="💾 Update Project" CssClass="btn-success" OnClick="btnUpdateProject_Click" />
                            <asp:Button ID="btnDeleteProject" runat="server" Text="🗑️ Delete Project" CssClass="btn-danger" OnClick="btnDeleteProject_Click" OnClientClick="return confirmDelete();" />
                            <button type="button" onclick="closeEditModal()" class="btn-secondary">❌ Cancel</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Add New Tab -->
            <div id="addTab" class="tab-content">
                <div class="add-header">
                    <h2>Add New Project</h2>
                    <p>Fill in the details to add a new project to your showcase</p>
                </div>

                <div class="form-container">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Project Type *</label>
                            <asp:DropDownList ID="ddlAddType" runat="server" CssClass="form-select">
                                <asp:ListItem Value="" Text="Select Project Type"></asp:ListItem>
                                <asp:ListItem Value="feature" Text="Feature"></asp:ListItem>
                                <asp:ListItem Value="General" Text="General"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Project Title *</label>
                            <asp:TextBox ID="txtAddTitle" runat="server" CssClass="form-input" placeholder="Enter project title" />
                        </div>

                        <div class="form-group span-2">
                            <label class="form-label">Project Description</label>
                            <asp:TextBox ID="txtAddDescription" runat="server" CssClass="form-textarea" TextMode="MultiLine" Rows="4" placeholder="Enter detailed project description..." />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Cover Image URL</label>
                            <asp:TextBox ID="txtAddCoverImage" runat="server" CssClass="form-input" placeholder="https://example.com/image.jpg" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">GitHub Repository</label>
                            <asp:TextBox ID="txtAddGithub" runat="server" CssClass="form-input" placeholder="https://github.com/username/repo" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Google Drive Link</label>
                            <asp:TextBox ID="txtAddDrive" runat="server" CssClass="form-input" placeholder="https://drive.google.com/..." />
                        </div>

                        <div class="form-group">
                            <label class="form-label">YouTube Video</label>
                            <asp:TextBox ID="txtAddYoutube" runat="server" CssClass="form-input" placeholder="https://youtube.com/watch?v=..." />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Other Link</label>
                            <asp:TextBox ID="txtAddOther" runat="server" CssClass="form-input" placeholder="Any other relevant link" />
                        </div>
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnAddProject" runat="server" Text="Add Project" CssClass="btn-success" OnClick="btnAddProject_Click" />
                        <button type="button" onclick="clearAddForm()" class="btn-secondary">Clear Form</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        // Functions that need server control access
        function editProject(projectId) {
            try {
                console.log('Edit project called with ID:', projectId);

                // Set the project ID
                var hiddenField = document.getElementById('<%= hfEditProjectId.ClientID %>');
                if (!hiddenField) {
                    console.error('Hidden field not found');
                    return;
                }
                hiddenField.value = projectId;

                // Trigger postback using the hidden button
                var loadButton = document.getElementById('<%= btnLoadProjectForEdit.ClientID %>');
                if (!loadButton) {
                    console.error('Load button not found');
                    return;
                }

                console.log('Triggering postback...');
                loadButton.click();

            } catch (error) {
                console.error('Error in editProject:', error);
                alert('Error loading project: ' + error.message);
            }
        }

        function closeEditModal() {
            document.getElementById('editFormModal').style.display = 'none';
            document.getElementById('<%= hfEditProjectId.ClientID %>').value = '';
        }

        function deleteProject(projectId, projectTitle) {
            if (confirm('Are you sure you want to delete "' + projectTitle + '"?\n\nThis action cannot be undone.')) {
                // Set the project ID in the hidden field and trigger delete
                document.getElementById('<%= hfEditProjectId.ClientID %>').value = projectId;
                document.getElementById('<%= btnDeleteProject.ClientID %>').click();
            }
        }

        function confirmDelete() {
            let title = document.getElementById('<%= txtEditTitle.ClientID %>').value;
            return confirm('Are you sure you want to delete "' + title + '"?\n\nThis action cannot be undone.');
        }

        function clearAddForm() {
            // Clear all add form fields
            let addForm = document.getElementById('addTab');
            let inputs = addForm.querySelectorAll('input[type="text"], textarea, select');
            inputs.forEach(function(input) {
                if (input.tagName === 'SELECT') {
                    input.selectedIndex = 0;
                } else {
                    input.value = '';
                }
            });
        }

        // Handle server messages on page load
        window.addEventListener('load', function() {
            let messageText = '<%= LiteralMessage.Text %>';
            if (messageText && messageText.trim() !== '') {
                let isSuccess = messageText.toLowerCase().includes('success') ||
                    messageText.toLowerCase().includes('added') ||
                    messageText.toLowerCase().includes('updated');
                showMessage(messageText, isSuccess);
            }

            // Check if edit form should be shown
            let editProjectId = '<%= hfEditProjectId.Value %>';
            if (editProjectId && editProjectId !== '') {
                document.getElementById('editForm').style.display = 'block';
            }

            // Update no projects visibility
            updateNoProjectsVisibility();
        });
    </script>
</body>

</html>