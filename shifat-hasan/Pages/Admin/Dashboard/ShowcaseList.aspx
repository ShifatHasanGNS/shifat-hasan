<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowcaseList.aspx.cs" Inherits="shifat_hasan.Pages.Admin.Dashboard.ShowcaseList" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Showcase Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #1e293b;
            line-height: 1.6;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Navigation */
        .admin-nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        .admin-nav h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #1e293b;
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-links {
            display: flex;
            gap: 1rem;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            color: #1e293b;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
        }

        .nav-links a:hover {
            background: #6366f1;
            color: white;
            border-color: #6366f1;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        /* Stats Section */
        .stats-section {
            margin-bottom: 2rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            padding: 2rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            line-height: 1;
        }

        .stat-label {
            font-size: 0.875rem;
            font-weight: 500;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        /* Message Container */
        .message-container {
            margin-bottom: 1.5rem;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            border: 1px solid;
            animation: slideIn 0.3s ease;
        }

        .message-container.success {
            background: rgba(16, 185, 129, 0.1);
            border-color: #10b981;
            color: #065f46;
        }

        .message-container.error {
            background: rgba(239, 68, 68, 0.1);
            border-color: #ef4444;
            color: #991b1b;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Tabs */
        .tabs-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            padding: 0.5rem;
            margin-bottom: 2rem;
            display: flex;
            gap: 0.25rem;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        .tab-btn {
            flex: 1;
            padding: 1rem 1.5rem;
            border: none;
            background: transparent;
            color: #64748b;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .tab-btn:hover {
            background: #f1f5f9;
            color: #1e293b;
        }

        .tab-btn.active {
            background: #6366f1;
            color: white;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        /* Tab Content */
        .tab-content {
            display: none;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        .tab-content.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Search Controls */
        .search-controls {
            margin-bottom: 2rem;
        }

        .search-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-input, .filter-select {
            flex: 1;
            min-width: 200px;
            padding: 0.875rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            background: white;
        }

        .search-input:focus, .filter-select:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .search-btn, .clear-btn {
            padding: 0.875rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-btn {
            background: #6366f1;
            color: white;
        }

        .search-btn:hover {
            background: #4f46e5;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        .clear-btn {
            background: #f8fafc;
            color: #64748b;
            border: 2px solid #e2e8f0;
        }

        .clear-btn:hover {
            background: #f1f5f9;
            color: #1e293b;
            border-color: #94a3b8;
        }

        /* Projects Grid */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        .project-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 1px 2px 0 rgb(0 0 0 / 0.05);
        }

        .project-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            border-color: #6366f1;
        }

        .project-header {
            padding: 1.25rem 1.5rem 0;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .project-type {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .project-actions {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            width: 2.5rem;
            height: 2.5rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }

        .edit-btn {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .edit-btn:hover {
            background: #10b981;
            color: white;
            transform: scale(1.1);
        }

        .delete-btn {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .delete-btn:hover {
            background: #ef4444;
            color: white;
            transform: scale(1.1);
        }

        .project-image {
            margin: 1rem 1.5rem;
            height: 200px;
            border-radius: 12px;
            overflow: hidden;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .project-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .project-card:hover .project-image img {
            transform: scale(1.05);
        }

        .no-image {
            color: #94a3b8;
            font-size: 3rem;
        }

        .project-content {
            padding: 0 1.5rem 1.5rem;
        }

        .project-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.75rem;
        }

        .project-description {
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .project-links {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .project-links a {
            padding: 0.5rem 1rem;
            background: #f8fafc;
            color: #1e293b;
            text-decoration: none;
            border-radius: 8px;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.2s ease;
            border: 1px solid #e2e8f0;
        }

        .project-links a:hover {
            background: #6366f1;
            color: white;
            border-color: #6366f1;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #1e293b;
        }

        /* Form Styles */
        .manage-header, .add-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .manage-header h2, .add-header h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .manage-header p, .add-header p {
            color: #64748b;
            font-size: 1.1rem;
        }

        .load-section {
            margin-bottom: 2rem;
        }

        .load-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            align-items: center;
        }

        .load-input {
            padding: 1rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            min-width: 200px;
            transition: all 0.2s ease;
        }

        .load-input:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .load-btn {
            padding: 1rem 2rem;
            background: #6366f1;
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .load-btn:hover {
            background: #4f46e5;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        .form-container {
            background: rgba(248, 250, 252, 0.5);
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group.span-2 {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.2s ease;
            background: white;
            font-family: inherit;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 120px;
            line-height: 1.6;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-success, .btn-danger, .btn-secondary {
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .btn-success {
            background: #10b981;
            color: white;
        }

        .btn-success:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        .btn-danger {
            background: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
        }

        .btn-secondary {
            background: white;
            color: #64748b;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f1f5f9;
            color: #1e293b;
            border-color: #94a3b8;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .admin-nav {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .search-group {
                flex-direction: column;
                align-items: stretch;
            }

            .search-input, .filter-select {
                min-width: unset;
            }

            .projects-grid {
                grid-template-columns: 1fr;
            }

            .load-group {
                flex-direction: column;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .tabs-container {
                flex-direction: column;
            }
        }

        /* Loading States */
        .btn-loading {
            position: relative;
            color: transparent;
        }

        .btn-loading::after {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top-color: currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Accessibility */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* Focus visible for better keyboard navigation */
        .tab-btn:focus-visible,
        .action-btn:focus-visible,
        .search-btn:focus-visible,
        .clear-btn:focus-visible,
        .load-btn:focus-visible,
        .btn-success:focus-visible,
        .btn-danger:focus-visible,
        .btn-secondary:focus-visible {
            outline: 3px solid #6366f1;
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Navigation -->
            <nav class="admin-nav">
                <h1>Showcase Management</h1>
                <div class="nav-links">
                    <a href="~/Pages/Home.aspx" runat="server">Home</a>
                    <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server">Admin Info</a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server">User Feedbacks</a>
                </div>
            </nav>

            <!-- Stats Dashboard -->
            <section class="stats-section">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-content">
                            <div class="stat-number"><asp:Literal ID="LiteralTotalProjects" runat="server" /></div>
                            <div class="stat-label">Total Projects</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-content">
                            <div class="stat-number"><asp:Literal ID="LiteralWithLinks" runat="server" /></div>
                            <div class="stat-label">With External Links</div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Message Panel -->
            <div id="messageContainer" class="message-container" style="display: none;">
                <asp:Literal ID="LiteralMessage" runat="server" />
            </div>

            <!-- Tab Navigation -->
            <div class="tabs-container">
                <button type="button" class="tab-btn active" onclick="showTab('gallery')">Project Gallery</button>
                <%-- <button type="button" class="tab-btn" onclick="showTab('manage')">Manage Projects</button> --%>
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
                                        <button type="button" onclick="editProject(<%# Eval("id") %>)" class="action-btn edit-btn" title="Edit Project">✏️</button>
                                        <button type="button" class="action-btn delete-btn" data-project-id='<%# Eval("id") %>' data-project-title='<%# Eval("title") %>' onclick="deleteProjectSafe(this)" title="Delete Project">🗑️</button>
                                    </div>
                                </div>
                                
                                <div class="project-image">
                                    <%# !string.IsNullOrEmpty(Eval("url_cover_image")?.ToString()) ?
                                            "<img src='" + Eval("url_cover_image") + "' alt='" + Eval("title") + "' onerror=\"this.parentElement.innerHTML='<div class=\\'no-image\\'>📷 No Image</div>';\" />" :
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

            <!-- Manage/Edit Tab -->
            <div id="manageTab" class="tab-content">
                <div class="manage-header">
                    <h2>Edit Existing Project</h2>
                    <p>Enter a Project ID to load and edit an existing project</p>
                </div>
                
                <div class="load-section">
                    <div class="load-group">
                        <asp:TextBox ID="txtLoadProjectId" runat="server" CssClass="load-input" placeholder="Enter Project ID" />
                        <asp:Button ID="btnLoadProject" runat="server" Text="Load Project" CssClass="load-btn" OnClick="btnLoadProject_Click" />
                    </div>
                </div>

                <div id="editForm" class="form-container" style="display: none;">
                    <asp:HiddenField ID="hfEditProjectId" runat="server" />
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Project Type *</label>
                            <asp:DropDownList ID="ddlEditType" runat="server" CssClass="form-select">
                                <asp:ListItem Value="" Text="Select Project Type"></asp:ListItem>
                                <asp:ListItem Value="Web Development" Text="Web Development"></asp:ListItem>
                                <asp:ListItem Value="Mobile App" Text="Mobile App"></asp:ListItem>
                                <asp:ListItem Value="Desktop Application" Text="Desktop Application"></asp:ListItem>
                                <asp:ListItem Value="Game Development" Text="Game Development"></asp:ListItem>
                                <asp:ListItem Value="AI/ML" Text="AI/ML"></asp:ListItem>
                                <asp:ListItem Value="Data Science" Text="Data Science"></asp:ListItem>
                                <asp:ListItem Value="Other" Text="Other"></asp:ListItem>
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
                        <button type="button" onclick="cancelEdit()" class="btn-secondary">❌ Cancel</button>
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
        function showTab(tabName) {
            // Hide all tabs
            let tabs = document.querySelectorAll('.tab-content');
            tabs.forEach(function(tab) {
                tab.classList.remove('active');
            });

            // Remove active from all buttons
            let buttons = document.querySelectorAll('.tab-btn');
            buttons.forEach(function(btn) {
                btn.classList.remove('active');
            });

            // Show selected tab
            document.getElementById(tabName + 'Tab').classList.add('active');
            event.target.classList.add('active');

            // Hide message when switching tabs
            hideMessage();
        }

        function editProject(projectId) {
            // Set the project ID and switch to manage tab
            document.getElementById('<%= txtLoadProjectId.ClientID %>').value = projectId;
            
            // Trigger load project
            document.getElementById('<%= btnLoadProject.ClientID %>').click();
            
            // Switch to manage tab
            // showTab('manage');
        }

        function deleteProject(projectId, projectTitle) {
            if (confirm('Are you sure you want to delete "' + projectTitle + '"?\n\nThis action cannot be undone.')) {
                // Set the project ID and trigger delete
                document.getElementById('<%= txtLoadProjectId.ClientID %>').value = projectId;
                document.getElementById('<%= hfEditProjectId.ClientID %>').value = projectId;
                document.getElementById('<%= btnDeleteProject.ClientID %>').click();
            }
        }
        
        function deleteProjectSafe(button) {
            var projectId = button.getAttribute('data-project-id');
            var projectTitle = button.getAttribute('data-project-title');
            deleteProject(projectId, projectTitle);
        }

        function confirmDelete() {
            let title = document.getElementById('<%= txtEditTitle.ClientID %>').value;
            return confirm('Are you sure you want to delete "' + title + '"?\n\nThis action cannot be undone.');
        }

        function cancelEdit() {
            // Clear the edit form
            document.getElementById('<%= txtLoadProjectId.ClientID %>').value = '';
            document.getElementById('<%= hfEditProjectId.ClientID %>').value = '';
            document.getElementById('editForm').style.display = 'none';
            hideMessage();
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

        function showMessage(message, isSuccess) {
            let container = document.getElementById('messageContainer');
            container.innerHTML = message;
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
            document.getElementById('messageContainer').style.display = 'none';
        }

        function updateNoProjectsVisibility() {
            let projectCards = document.querySelectorAll('.project-card');
            let noProjectsMessage = document.getElementById('noProjectsMessage');
            
            if (projectCards.length === 0) {
                noProjectsMessage.style.display = 'block';
            } else {
                noProjectsMessage.style.display = 'none';
            }
        }

        // Handle server messages
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

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+N for new project
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                showTab('add');
            }
            // Escape to cancel edit
            if (e.key === 'Escape') {
                let editForm = document.getElementById('editForm');
                if (editForm.style.display !== 'none') {
                    cancelEdit();
                }
            }
        });
    </script>
</body>
</html>