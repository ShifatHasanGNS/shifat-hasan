<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="shifat_hasan.Pages.Projects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .projects-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            margin-top: 20px;
            margin-bottom: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .projects-section h2 {
            text-align: center;
            font-size: 3rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 50px;
            position: relative;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .projects-section h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        #project-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            padding: 20px 0;
        }

        .project-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            transform: translateY(0);
        }

        .project-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .project-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.8) 0%, rgba(118, 75, 162, 0.8) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
            border-radius: 20px;
            z-index: 1;
        }

        .project-card:hover::before {
            opacity: 1;
        }

        .project-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: transform 0.4s ease;
            position: relative;
            z-index: 2;
        }

        .project-card:hover img {
            transform: scale(1.1);
            filter: brightness(1.2);
        }

        .project-card h3 {
            padding: 25px;
            margin: 0;
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
            color: #2c3e50;
            transition: all 0.3s ease;
            position: relative;
            z-index: 3;
            text-transform: capitalize;
            letter-spacing: 1px;
        }

        .project-card:hover h3 {
            color: white;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        /* Modal Styles */
        .modal {
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .modal[style*="block"] {
            opacity: 1;
            visibility: visible;
        }

        .modal-content {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            margin: 2% auto;
            padding: 0;
            border-radius: 25px;
            width: 90%;
            max-width: 800px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            position: relative;
            transform: translateY(-50px);
            transition: transform 0.3s ease;
        }

        .modal[style*="block"] .modal-content {
            transform: translateY(0);
        }

        .close {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 2rem;
            font-weight: bold;
            color: #fff;
            background: linear-gradient(135deg, #667eea, #764ba2);
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .close:hover {
            background: linear-gradient(135deg, #764ba2, #667eea);
            transform: rotate(90deg) scale(1.1);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        #modalContent {
            padding: 40px;
        }

        .project-detail {
            text-align: center;
        }

        .modal-cover-image {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .project-detail h2 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 20px;
            font-weight: 700;
            text-transform: capitalize;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .project-type {
            font-size: 1.2rem;
            color: #7f8c8d;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 600;
        }

        .project-description {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #34495e;
            margin-bottom: 30px;
            text-align: left;
            background: rgba(102, 126, 234, 0.05);
            padding: 25px;
            border-radius: 15px;
            border-left: 5px solid #667eea;
        }

        .project-description strong {
            display: block;
            margin-bottom: 15px;
            color: #2c3e50;
            font-size: 1.3rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .project-links {
            margin-top: 30px;
            text-align: left;
            background: rgba(118, 75, 162, 0.05);
            padding: 25px;
            border-radius: 15px;
            border-left: 5px solid #764ba2;
        }

        .project-links strong {
            display: block;
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 1.3rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .project-links a {
            display: inline-block;
            margin: 8px 15px 8px 0;
            padding: 12px 25px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            transition: all 0.3s ease;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .project-links a:hover {
            background: linear-gradient(135deg, #764ba2, #667eea);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        /* Loading Animation */
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 200px;
            font-size: 1.2rem;
            color: #667eea;
        }

        .loading::after {
            content: '';
            width: 30px;
            height: 30px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #667eea;
            border-radius: 50%;
            margin-left: 15px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .projects-section {
                margin: 10px;
                padding: 20px 15px;
                border-radius: 15px;
            }

            .projects-section h2 {
                font-size: 2.2rem;
                margin-bottom: 30px;
            }

            #project-cards {
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
            }

            .project-card {
                border-radius: 15px;
            }

            .project-card h3 {
                font-size: 1.3rem;
                padding: 20px;
            }

            .modal-content {
                width: 95%;
                margin: 5% auto;
                border-radius: 20px;
            }

            #modalContent {
                padding: 20px;
            }

            .project-detail h2 {
                font-size: 2rem;
            }

            .project-links a {
                display: block;
                margin: 10px 0;
                text-align: center;
            }
        }

        @media (max-width: 480px) {
            .projects-section h2 {
                font-size: 1.8rem;
            }

            #project-cards {
                grid-template-columns: 1fr;
            }

            .project-card img {
                height: 200px;
            }
        }

        /* Smooth scroll behavior */
        html {
            scroll-behavior: smooth;
        }

        /* Focus styles for accessibility */
        .project-card:focus {
            outline: 3px solid #667eea;
            outline-offset: 5px;
        }

        .close:focus {
            outline: 3px solid #fff;
            outline-offset: 2px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="projects-section">
        <h2>My Projects</h2>
        <div id="project-cards">
            <asp:Repeater ID="ProjectsRepeater" runat="server">
                <ItemTemplate>
                    <div class="project-card" onclick="openProjectModal(<%# Eval("id") %>)" tabindex="0" onkeypress="handleCardKeyPress(event, <%# Eval("id") %>)">
                        <img src='<%# Eval("url_cover_image") %>' alt='<%# Eval("title") %>' onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjBmMGYwIi8+CiAgPHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPk5vIEltYWdlPC90ZXh0Pgo8L3N2Zz4='" />
                        <h3><%# Eval("title") %></h3>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

    <!-- Modal for project details -->
    <div id="projectModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeProjectModal()" tabindex="0" onkeypress="handleCloseKeyPress(event)">&times;</span>
            <div id="modalContent">
                <!-- Content will be populated by JavaScript -->
            </div>
        </div>
    </div>

    <!-- Hidden field to store project data for JavaScript -->
    <asp:HiddenField ID="ProjectsJsonData" runat="server" />

    <script type="text/javascript">
        var projectsData = [];

        function initializeProjectsData() {
            var jsonData = document.getElementById('<%= ProjectsJsonData.ClientID %>').value;
            if (jsonData) {
                try {
                    projectsData = JSON.parse(jsonData);
                } catch (e) {
                    console.error('Error parsing projects data:', e);
                }
            }
        }

        function openProjectModal(projectId) {
            var project = projectsData.find(p => p.id === projectId);
            if (!project) return;

            var modalContent = document.getElementById('modalContent');
            var html = '<div class="project-detail">';
            
            // Cover image
            if (project.url_cover_image) {
                html += '<img src="' + escapeHtml(project.url_cover_image) + '" alt="' + escapeHtml(project.title) + '" class="modal-cover-image" />';
            }
            
            // Title
            html += '<h2>' + escapeHtml(project.title) + '</h2>';
            
            // Type
            if (project.type) {
                html += '<p class="project-type"><strong>Type:</strong> ' + escapeHtml(project.type) + '</p>';
            }
            
            // Description
            if (project.description && project.description.trim()) {
                html += '<div class="project-description"><strong>Description:</strong><br/>' + 
                        escapeHtml(project.description).replace(/\n/g, '<br/>') + '</div>';
            }
            
            // Links section
            var hasLinks = project.url_github || project.url_drive || project.url_youtube || project.url_other;
            if (hasLinks) {
                html += '<div class="project-links"><strong>Available Links:</strong><br/>';
                
                if (project.url_github) {
                    html += '<a href="' + escapeHtml(project.url_github) + '" target="_blank" rel="noopener">🔗 GitHub Repository</a>';
                }
                
                if (project.url_drive) {
                    html += '<a href="' + escapeHtml(project.url_drive) + '" target="_blank" rel="noopener">📁 Google Drive</a>';
                }
                
                if (project.url_youtube) {
                    html += '<a href="' + escapeHtml(project.url_youtube) + '" target="_blank" rel="noopener">📺 YouTube Video</a>';
                }
                
                if (project.url_other) {
                    html += '<a href="' + escapeHtml(project.url_other) + '" target="_blank" rel="noopener">🔗 Other Link</a>';
                }
                
                html += '</div>';
            }
            
            html += '</div>';
            
            modalContent.innerHTML = html;
            document.getElementById('projectModal').style.display = 'block';
            document.body.style.overflow = 'hidden'; // Prevent background scrolling
        }

        function closeProjectModal() {
            document.getElementById('projectModal').style.display = 'none';
            document.body.style.overflow = 'auto'; // Restore scrolling
        }

        function escapeHtml(text) {
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        // Keyboard accessibility
        function handleCardKeyPress(event, projectId) {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                openProjectModal(projectId);
            }
        }

        function handleCloseKeyPress(event) {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                closeProjectModal();
            }
        }

        // Close modal when clicking outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('projectModal');
            if (event.target === modal) {
                closeProjectModal();
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeProjectModal();
            }
        });

        // Initialize data when page loads
        window.addEventListener('load', function() {
            initializeProjectsData();
        });

        // Add loading state
        document.addEventListener('DOMContentLoaded', function() {
            var projectCards = document.getElementById('project-cards');
            if (!projectCards.children.length) {
                projectCards.innerHTML = '<div class="loading">Loading projects...</div>';
            }
        });
    </script>
</asp:Content>
