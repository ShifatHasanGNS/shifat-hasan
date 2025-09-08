<%@ Page Language="C#" CodeBehind="AdminInfo.aspx.cs" Inherits="shifat_hasan.Pages.Admin.Dashboard.AdminInfo" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Information</title>
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
        
        .header-title {
            text-decoration: none;
            display: flex;
            flex-direction: column;
            line-height: 1.2;
        }
        
        .header-title-main {
            font-family: 'Poppins', sans-serif;
            font-size: 1.25rem;
            font-weight: 600;
            background: var(--gradient-primary);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .header-title-sub {
            font-size: 0.75rem;
            color: var(--slate-400);
            font-weight: 400;
            margin-top: -2px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            padding-top: 6rem; /* Account for fixed navigation */
        }

        /* Modern Admin Navigation - Matching Home Page Style */
        .admin-nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(59, 130, 246, 0.2);
            z-index: 1000;
            transition: var(--transition-normal);
            box-shadow: var(--shadow-lg);
            padding: 0;
        }

        .admin-nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 1.5rem;
            height: 70px;
            width: 100%;
        }

        .admin-nav-title {
            text-decoration: none;
            display: flex;
            flex-direction: column;
            line-height: 1.2;
        }

        .admin-nav-title-main {
            font-family: 'Poppins', sans-serif;
            font-size: 1.25rem;
            font-weight: 600;
            background: var(--gradient-primary);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .admin-nav-title-main::before {
            content: '⚡';
            font-size: 1.1rem;
            filter: drop-shadow(0 0 8px rgba(59, 130, 246, 0.5));
        }

        .admin-nav-title-sub {
            font-size: 0.75rem;
            color: var(--slate-400);
            font-weight: 400;
            margin-top: -2px;
        }

        .admin-nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
            flex-shrink: 0;
        }

        .admin-nav-link {
            text-decoration: none;
            color: var(--slate-300);
            font-weight: 500;
            font-size: 0.95rem;
            position: relative;
            padding: 0.5rem 0;
            transition: var(--transition-normal);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .admin-link-text {
            position: relative;
            z-index: 1;
        }

        .admin-link-underline {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transform-origin: left;
            transition: var(--transition-normal);
        }

        .admin-nav-link:hover {
            color: var(--accent-primary);
        }

        .admin-nav-link:hover .admin-link-underline {
            transform: scaleX(1);
        }

        .admin-nav-link.active {
            color: var(--accent-primary);
        }

        .admin-nav-link.active .admin-link-underline {
            transform: scaleX(1);
        }

        .admin-nav-link span {
            font-size: 1rem;
            filter: drop-shadow(0 0 4px rgba(59, 130, 246, 0.3));
        }

        /* Mobile Menu Toggle */
        .admin-mobile-menu-toggle {
            display: none;
            flex-direction: column;
            gap: 4px;
            background: none;
            border: none;
            padding: 0.5rem;
            cursor: pointer;
            border-radius: 0.375rem;
            transition: all 0.3s ease-in-out;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .admin-hamburger-line {
            width: 24px;
            height: 2px;
            background: var(--slate-300);
            transition: var(--transition-normal);
            transform-origin: center;
        }

        .admin-mobile-menu-toggle:hover {
            background: rgba(59, 130, 246, 0.1);
        }

        .admin-mobile-menu-toggle.active .admin-hamburger-line:first-child {
            transform: rotate(45deg) translate(5px, 5px);
        }

        .admin-mobile-menu-toggle.active .admin-hamburger-line:nth-child(2) {
            opacity: 0;
        }

        .admin-mobile-menu-toggle.active .admin-hamburger-line:last-child {
            transform: rotate(-45deg) translate(5px, -5px);
        }

        /* Mobile Navigation */
        .admin-mobile-nav {
            position: fixed;
            top: 70px;
            left: 0;
            right: 0;
            background: rgba(15, 23, 42, 0.98);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(59, 130, 246, 0.2);
            display: flex;
            flex-direction: column;
            gap: 0;
            z-index: 1001;
            transform: translateY(-100%);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-lg);
            max-height: calc(100vh - 70px);
            overflow-y: auto;
        }

        .admin-mobile-nav.active {
            transform: translateY(0);
            opacity: 1;
            visibility: visible;
        }

        .admin-mobile-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 1.5rem;
            color: var(--slate-300);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            border-bottom: 1px solid rgba(59, 130, 246, 0.1);
            transition: var(--transition-normal);
        }

        .admin-mobile-link:hover {
            background: rgba(59, 130, 246, 0.1);
            color: var(--accent-primary);
        }

        .admin-mobile-link.active {
            background: rgba(59, 130, 246, 0.2);
            color: var(--accent-primary);
        }

        .admin-mobile-link span {
            font-size: 1.1rem;
        }

        /* Sign Out Button */
        .admin-signout-btn {
            background: linear-gradient(135deg, var(--accent-error) 0%, #dc2626 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .admin-signout-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }


        /* Main Section */
        .admin-info-section {
            background: var(--gradient-card);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--slate-700);
            overflow: hidden;
        }

        .section-header {
            background: var(--gradient-primary);
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
            color: var(--slate-100);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .edit-btn {
            background: rgba(255, 255, 255, 0.2) !important;
            color: var(--slate-100) !important;
            border: 2px solid var(--slate-300) !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: var(--transition-fast) !important;
            backdrop-filter: blur(10px) !important;
        }

        .edit-btn:hover {
            background: var(--accent-primary) !important;
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-lg) !important;
        }

        .status-indicator {
            padding: 0.5rem 1rem;
            background: var(--accent-primary);
            border-radius: 20px;
            color: var(--slate-100);
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
            background: var(--accent-success);
            color: var(--slate-100);
            border-left-color: var(--accent-success);
        }

        .message-container.error {
            background: var(--accent-error);
            color: var(--slate-100);
            border-left-color: var(--accent-error);
        }

        .session-info {
            padding: 1rem 2rem;
            background: var(--slate-800);
            color: var(--accent-primary);
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
            background: var(--slate-800);
            padding: 2rem;
            border-radius: 12px;
            border: 1px solid var(--slate-700);
        }

        .info-section, .edit-section {
            background: var(--slate-700);
            padding: 2rem;
            border-radius: 16px;
            border: 1px solid var(--slate-600);
            box-shadow: var(--shadow-md);
            transition: var(--transition-fast);
        }

        .info-section:hover, .edit-section:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .info-section h3, .edit-section h3 {
            color: var(--slate-100);
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid;
            border-image: var(--gradient-primary) 1;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            margin-bottom: 1rem;
        }

        .info-item label {
            font-weight: 600;
            color: var(--slate-300);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .info-item span {
            color: var(--slate-100);
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
            color: var(--slate-300);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .social-item a {
            color: var(--accent-primary);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem;
            border-radius: 8px;
            background: var(--slate-800);
            transition: var(--transition-fast);
            word-break: break-all;
            font-size: 0.9rem;
        }

        .social-item a:hover {
            background: var(--gradient-primary);
            color: var(--slate-100);
            transform: translateX(5px);
        }

        .social-item span {
            color: var(--accent-primary);
            font-weight: 500;
            padding: 0.5rem;
            border-radius: 8px;
            background: var(--slate-800);
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
            color: var(--slate-300);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-input {
            width: 100% !important;
            padding: 1rem !important;
            border: 2px solid var(--slate-600) !important;
            border-radius: 12px !important;
            font-size: 1rem !important;
            transition: var(--transition-fast) !important;
            background: var(--slate-800) !important;
            background-image: none !important; /* prevent injected icons/backgrounds */
            box-shadow: var(--shadow-sm) !important;
            font-family: inherit !important;
            color: var(--slate-100) !important;
        }

        .form-input:focus {
            outline: none !important;
            border-color: var(--accent-primary) !important;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1), var(--shadow-md) !important;
            transform: translateY(-1px) !important;
        }

        /* Edit Actions */
        .edit-actions {
            padding: 2rem;
            background: var(--slate-800);
            border-top: 1px solid var(--slate-700);
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .save-btn {
            background: var(--gradient-primary) !important;
            color: var(--slate-100) !important;
            border: none !important;
            padding: 1rem 2rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: var(--transition-fast) !important;
            box-shadow: var(--shadow-md) !important;
            font-size: 1rem !important;
        }

        .save-btn:hover {
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-lg) !important;
        }

        .cancel-btn {
            background: var(--slate-800) !important;
            color: var(--slate-300) !important;
            border: 2px solid var(--slate-600) !important;
            padding: 1rem 2rem !important;
            border-radius: 12px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: var(--transition-fast) !important;
            font-size: 1rem !important;
        }

        .cancel-btn:hover {
            background: var(--slate-700) !important;
            border-color: var(--slate-500) !important;
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-md) !important;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-title-main {
                font-size: 1.1rem;
            }
            
            .header-title-sub {
                font-size: 0.7rem;
            }
                            
            .container {
                padding: 1rem;
                padding-top: 5rem; /* Account for fixed navigation */
            }

            .admin-nav-links {
                display: none;
            }

            .admin-mobile-menu-toggle {
                display: flex;
            }

            .admin-nav-title-main {
                font-size: 1.1rem;
            }

            .admin-nav-title-sub {
                font-size: 0.7rem;
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

        @media (max-width: 480px) {
            .container {
                padding: 0.75rem;
                padding-top: 5rem;
            }

            .admin-nav-container {
                padding: 0.75rem 1rem;
                height: 60px;
            }

            .admin-nav-title-main {
                font-size: 1rem;
            }

            .admin-nav-title-sub {
                font-size: 0.65rem;
            }

            .admin-mobile-nav {
                top: 60px;
            }

            .section-header {
                padding: 1rem;
            }

            .info-section, .edit-section {
                padding: 1rem;
            }

            .edit-actions {
                padding: 1rem;
                gap: 0.75rem;
            }

            .save-btn, .cancel-btn {
                padding: 0.875rem 1.5rem !important;
                font-size: 0.9rem !important;
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
                background: var(--slate-900);
            }

            .admin-nav,
            .admin-info-section {
                background: var(--slate-800);
                border: 2px solid var(--slate-100);
            }

            .section-header {
                background: var(--slate-900);
                color: var(--slate-100);
            }

            .nav-links a,
            .edit-btn,
            .save-btn,
            .cancel-btn,
            .signout-btn {
                border: 2px solid var(--slate-100) !important;
            }
        }

        /* Focus Styles for Keyboard Navigation */
        button:focus-visible,
        input:focus-visible,
        a:focus-visible {
            outline: 3px solid var(--accent-primary) !important;
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
            <!-- Modern Admin Navigation -->
            <nav class="admin-nav">
                <div class="admin-nav-container">
                    <a class="header-title" href='<%= ResolveUrl("~/Pages/Admin/Dashboard/AdminInfo.aspx") %>'>
                        <span class="header-title-main">Admin Dashboard</span>
                        <span class="header-title-sub">Md. Shifat Hasan</span>
                    </a>
                    
                    <div class="admin-nav-links">
                        <a href="~/Pages/Home.aspx" runat="server" class="admin-nav-link">
                            <span>🏠</span>
                            <span class="admin-link-text">Home</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-nav-link active">
                            <span>👤</span>
                            <span class="admin-link-text">Admin Info</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-nav-link">
                            <span>📁</span>
                            <span class="admin-link-text">Showcase List</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-nav-link">
                            <span>💬</span>
                            <span class="admin-link-text">User Feedbacks</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <asp:Button ID="btnSignOut" runat="server" Text="🚪 Sign Out" CssClass="admin-signout-btn" OnClick="btnSignOut_Click" OnClientClick="return confirmSignOut()" />
                    </div>
                    
                    <button class="admin-mobile-menu-toggle" onclick="toggleAdminMobileMenu(event)">
                        <div class="admin-hamburger-line"></div>
                        <div class="admin-hamburger-line"></div>
                        <div class="admin-hamburger-line"></div>
                    </button>
                </div>
                
                <!-- Mobile Navigation -->
                <div class="admin-mobile-nav" id="adminMobileNav">
                    <a href="~/Pages/Home.aspx" runat="server" class="admin-mobile-link">
                        <span>🏠</span> Home
                    </a>
                    <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-mobile-link active">
                        <span>👤</span> Admin Info
                    </a>
                    <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-mobile-link">
                        <span>📁</span> Showcase List
                    </a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-mobile-link">
                        <span>💬</span> User Feedbacks
                    </a>
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
        function toggleAdminMobileMenu(event) {
            event.preventDefault();
            event.stopPropagation();
            
            const mobileNav = document.getElementById('adminMobileNav');
            const toggle = document.querySelector('.admin-mobile-menu-toggle');
            
            if (!mobileNav || !toggle) {
                console.error('Mobile navigation elements not found');
                return;
            }
            
            if (mobileNav.classList.contains('active')) {
                mobileNav.classList.remove('active');
                toggle.classList.remove('active');
            } else {
                mobileNav.classList.add('active');
                toggle.classList.add('active');
            }
        }

        // Close mobile menu when clicking outside
        document.addEventListener('click', function(event) {
            const mobileNav = document.getElementById('adminMobileNav');
            const toggle = document.querySelector('.admin-mobile-menu-toggle');
            
            if (mobileNav && mobileNav.classList.contains('active') && 
                !mobileNav.contains(event.target) && 
                !toggle.contains(event.target)) {
                mobileNav.classList.remove('active');
                toggle.classList.remove('active');
            }
        });

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

        function confirmSignOut() {
            return confirm('Are you sure you want to sign out? This will end your current session.');
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
            }
        });

        // Keyboard shortcuts
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