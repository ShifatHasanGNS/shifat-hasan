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
            background: var(--gradient-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--slate-700);
            border-radius: 16px;
            padding: 2rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            box-shadow: var(--shadow-lg);
            transition: var(--transition-fast);
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--slate-100);
            line-height: 1;
        }

        .stat-label {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--slate-400);
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
            background: var(--accent-success);
            border-color: var(--accent-success);
            color: var(--slate-100);
        }

        .message-container.error {
            background: var(--accent-error);
            border-color: var(--accent-error);
            color: var(--slate-100);
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
            background: var(--gradient-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--slate-700);
            border-radius: 16px;
            padding: 0.5rem;
            margin-bottom: 2rem;
            display: flex;
            gap: 0.25rem;
            box-shadow: var(--shadow-lg);
        }

        .tab-btn {
            flex: 1;
            padding: 1rem 1.5rem;
            border: none;
            background: transparent;
            color: var(--slate-400);
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-fast);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .tab-btn:hover {
            background: var(--slate-700);
            color: var(--slate-100);
        }

        .tab-btn.active {
            background: var(--accent-primary);
            color: var(--slate-100);
            box-shadow: var(--shadow-md);
        }

        /* Tab Content */
        .tab-content {
            display: none;
            background: var(--gradient-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--slate-700);
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
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
            align-items: flex-start;
            position: relative;
            z-index: 3;
        }
        
        .project-type {
            color: var(--slate-500);
            padding: 0.625rem 1.25rem;
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
            border: 2px solid var(--slate-600);
            border-radius: 12px;
            font-size: 1rem;
            min-width: 200px;
            background: var(--slate-800);
            color: var(--slate-100);
            transition: all 0.2s ease;
        }

        .load-input:focus {
            outline: none;
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .load-btn {
            padding: 1rem 2rem;
            background: var(--accent-primary);
            color: var(--slate-100);
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-fast);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .load-btn:hover {
            background: var(--accent-secondary);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .form-container {
            background: var(--slate-800);
            border: 1px solid var(--slate-700);
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
            color: var(--slate-100);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-input, .form-select, .form-textarea {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid var(--slate-600);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition-fast);
            background: var(--slate-800);
            color: var(--slate-100);
            font-family: inherit;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
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
            .header-title-main {
                font-size: 1.1rem;
            }
            
            .header-title-sub {
                font-size: 0.7rem;
            }
            
            .container {
                padding: 5rem 1rem 1rem;
            }

            .admin-nav-links {
                display: none;
            }

            .admin-mobile-menu-toggle {
                display: flex;
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
                flex-direction: row;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 5rem 0.75rem 0.75rem;
            }

            .admin-nav-container {
                padding: 0.75rem 1rem;
                height: 60px;
            }

            .admin-mobile-nav {
                top: 60px;
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

            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-actions {
                gap: 0.75rem;
            }

            .btn {
                padding: 0.75rem 1.5rem;
                font-size: 0.9rem;
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
            outline: 3px solid var(--accent-primary);
            outline-offset: 2px;
        }
        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 3000;
            color: var(--slate-100);
            font-size: 1.2rem;
        }
    </style>
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
                            <span>🏠</span>
                            <span class="admin-link-text">Home</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-nav-link">
                            <span>👤</span>
                            <span class="admin-link-text">Admin Info</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-nav-link active">
                            <span>📁</span>
                            <span class="admin-link-text">Showcase List</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-nav-link">
                            <span>💬</span>
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
                    <a href="~/Pages/Home.aspx" runat="server" class="admin-mobile-link">
                        <span>🏠</span> Home
                    </a>
                    <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-mobile-link">
                        <span>👤</span> Admin Info
                    </a>
                    <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-mobile-link active">
                        <span>📁</span> Showcase List
                    </a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-mobile-link">
                        <span>💬</span> User Feedbacks
                    </a>
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
        
        function showLoadingOverlay(message) {
            const overlay = document.createElement('div');
            overlay.className = 'loading-overlay';
            overlay.id = 'loadingOverlay';
            overlay.innerHTML = message;
            document.body.appendChild(overlay);
        }
        
        function hideLoadingOverlay() {
            const overlay = document.getElementById('loadingOverlay');
            if (overlay) {
                overlay.remove();
            }
        }
        
        function showEditModal() {
            document.getElementById('editFormModal').style.display = 'block';
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
        
        function deleteProjectSafe(button) {
            var projectId = button.getAttribute('data-project-id');
            var projectTitle = button.getAttribute('data-project-title');
            deleteProject(projectId, projectTitle);
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
        // Handle image loading errors
        function handleImageError(img) {
            img.parentElement.innerHTML = '<div class="no-image">📷 No Image</div>';
        }

        // Add event delegation for edit buttons
        document.addEventListener('click', function(event) {
            if (event.target.classList.contains('edit-btn') && event.target.dataset.projectId) {
                editProject(event.target.dataset.projectId);
            }
        });

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