<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="shifat_hasan.Pages.Projects" ResponseEncoding="utf-8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            color: var(--slate-100);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 6rem 2rem 2rem;
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
            border: 2px solid var(--slate-600);
            border-radius: 12px;
            font-size: 0.95rem;
            transition: var(--transition-fast);
            background: var(--slate-800);
            color: var(--slate-100);
        }

        .search-input:focus, .filter-select:focus {
            outline: none;
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .search-btn, .clear-btn {
            padding: 0.875rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-fast);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-btn {
            background: var(--accent-primary);
            color: var(--slate-100);
        }

        .search-btn:hover {
            background: var(--accent-secondary);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .clear-btn {
            background: var(--slate-800);
            color: var(--slate-300);
            border: 2px solid var(--slate-600);
        }

        .clear-btn:hover {
            background: var(--slate-700);
            color: var(--slate-100);
            border-color: var(--slate-500);
        }

        /* Projects Grid */
        .projects-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr)); /* two per row on non-mobile */
            gap: 1.5rem;
        }

        .project-card {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(59, 130, 246, 0.2);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 
                0 8px 32px rgba(0, 0, 0, 0.3),
                0 2px 8px rgba(0, 0, 0, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            position: relative;
        }

        .project-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, 
                rgba(59, 130, 246, 0.1) 0%, 
                rgba(139, 92, 246, 0.1) 50%, 
                rgba(236, 72, 153, 0.1) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: 1;
        }

        .project-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, 
                var(--accent-primary) 0%, 
                var(--accent-secondary) 50%, 
                #ec4899 100%);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 2;
        }

        .project-card:hover::before {
            opacity: 1;
        }

        .project-card:hover::after {
            transform: scaleX(1);
        }

        .project-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 
                0 20px 60px rgba(0, 0, 0, 0.4),
                0 8px 24px rgba(59, 130, 246, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            border-color: rgba(59, 130, 246, 0.4);
        }

        .project-header {
            padding: 1.5rem 1.5rem 0;
            display: flex;
            justify-content: space-between;
            align-content: center;
            position: relative;
            z-index: 3;
        }

        .project-type {
            color: var(--slate-500);
            border-radius: 16px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }

        .project-actions {
            display: flex;
            gap: 0.75rem;
        }

        .action-btn {
            width: 2.75rem;
            height: 2.75rem;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .action-btn:hover::before {
            left: 100%;
        }

        .edit-btn {
            background: linear-gradient(135deg, var(--accent-success) 0%, #059669 100%);
            color: var(--slate-100);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .edit-btn:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
        }

        .delete-btn {
            background: linear-gradient(135deg, var(--accent-error) 0%, #dc2626 100%);
            color: var(--slate-100);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .delete-btn:hover {
            transform: translateY(-2px) scale(1.1);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        .project-image {
            margin: 1.5rem 1.5rem 1rem;
            height: auto;
            aspect-ratio: 1.618 / 1; /* Golden ratio width:height */
            border-radius: 16px;
            overflow: hidden;
            background: linear-gradient(135deg, var(--slate-700) 0%, var(--slate-800) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            z-index: 3;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .project-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .project-card:hover .project-image img {
            transform: scale(1.05);
        }

        .no-image {
            color: var(--slate-400);
            font-size: 2.5rem;
            font-weight: 500;
        }

        .project-content {
            padding: 0 1.5rem 2rem;
            position: relative;
            z-index: 3;
        }

        .project-title {
            font-size: 1.375rem;
            font-weight: 700;
            color: var(--slate-100);
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--slate-100) 0%, var(--slate-300) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1.3;
        }

        .project-description {
            color: var(--slate-400);
            line-height: 1.7;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
        }

        .project-links {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .project-links a {
            padding: 0.625rem 1.25rem;
            background: rgba(30, 41, 59, 0.6);
            backdrop-filter: blur(10px);
            color: var(--slate-100);
            text-decoration: none;
            border-radius: 12px;
            border: 1px solid rgba(59, 130, 246, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            font-size: 0.875rem;
        }

        .project-links a:hover {
            background: linear-gradient(135deg, var(--accent-primary) 0%, var(--accent-secondary) 100%);
            color: var(--slate-100);
            border-color: var(--accent-primary);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--slate-400);
        }

        .empty-state h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--slate-100);
        }

        /* Form Styles */
        .manage-header, .add-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid var(--slate-700);
        }

        .manage-header h2, .add-header h2 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--slate-100);
            margin-bottom: 0.5rem;
        }

        .manage-header p, .add-header p {
            color: var(--slate-400);
            font-size: 1.1rem;
        }

        .btn-success, .btn-danger, .btn-secondary {
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-fast);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .btn-success {
            background: var(--accent-success);
            color: var(--slate-100);
        }

        .btn-success:hover {
            background: var(--accent-success);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-danger {
            background: var(--accent-error);
            color: var(--slate-100);
        }

        .btn-danger:hover {
            background: var(--accent-error);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary {
            background: var(--slate-800);
            color: var(--slate-300);
            border: 2px solid var(--slate-600);
        }

        .btn-secondary:hover {
            background: var(--slate-700);
            color: var(--slate-100);
            border-color: var(--slate-500);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
                padding-top: 5rem; /* Account for fixed navigation */
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
        }

        @media (max-width: 480px) {
            .container {
                padding: 0.75rem;
                padding-top: 5rem;
            }
            
            .search-group {
                gap: 0.75rem;
            }

            .projects-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .project-card {
                margin-bottom: 1rem;
            }

            .btn {
                padding: 0.75rem 1.5rem;
                font-size: 0.9rem;
            }
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
            outline: 3px solid var(--accent-primary);
            outline-offset: 2px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
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
    </div>
    
    <script type="text/javascript">
        // Close mobile menu when window is resized to desktop
        window.addEventListener('resize', function() {
            if (window.innerWidth > 768) {
                const mobileNav = document.getElementById('adminMobileNav');
                const toggle = document.querySelector('.admin-mobile-menu-toggle');
                
                if (mobileNav && toggle) {
                    mobileNav.classList.remove('active');
                    toggle.classList.remove('active');
                }
            }
        });

        // Handle image loading errors
        function handleImageError(img) {
            img.parentElement.innerHTML = '<div class="no-image">📷 No Image</div>';
        }
    </script>
</asp:Content>
