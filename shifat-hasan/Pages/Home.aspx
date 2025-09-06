<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="shifat_hasan.Pages.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Md. Shifat Hasan | Portfolio</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<style>    
    * {
      box-sizing: border-box;
    }
    
    body {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      line-height: 1.6;
      color: #2d3748;
      background-color: #ffffff;
      margin: 0;
      padding: 0;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }
    
    /* Hero Section */
    .hero-section {
      min-height: 100vh;
      background: linear-gradient(135deg, #ffffff 0%, #f7fafc 100%);
      position: relative;
      overflow: hidden;
      display: flex;
      align-items: center;
      padding: 2rem 1rem;
    }
    
    .hero-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%23667eea" fill-opacity="0.03"><circle cx="30" cy="30" r="2"/></g></svg>');
      pointer-events: none;
    }
    
    .hero-container {
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 4rem;
      align-items: center;
      position: relative;
      z-index: 1;
    }
    
    .hero-image {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 2rem;
    }
    
    .profile-image {
      width: 300px;
      height: 300px;
      border-radius: 9999px;
      object-fit: cover;
      border: 4px solid #ffffff;
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
      background: linear-gradient(45deg, #667eea, #764ba2);
    }
    
    .profile-image:hover {
      transform: scale(1.05) rotate(2deg);
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    }
    
    .social-links {
      display: flex;
      gap: 1rem;
      justify-content: center;
    }
    
    .social-link {
      width: 48px;
      height: 48px;
      border-radius: 9999px;
      background: #ffffff;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #718096;
      text-decoration: none;
      transition: all 0.15s ease-in-out;
      box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
      border: 1px solid #e2e8f0;
    }
    
    .social-link:hover {
      background: linear-gradient(45deg, #667eea, #764ba2);
      color: white;
      transform: translateY(-2px);
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }
    
    .hero-content {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
    
    .welcome-message {
      display: inline-block;
      background: linear-gradient(45deg, #667eea, #764ba2);
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      font-weight: 600;
      font-size: 1.125rem;
      margin-bottom: 0.5rem;
    }
    
    .hero-title {
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: clamp(2.5rem, 5vw, 4rem);
      font-weight: 700;
      line-height: 1.2;
      margin: 0;
      color: #2d3748;
    }
    
    .name-highlight {
      background: linear-gradient(45deg, #667eea, #764ba2);
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      position: relative;
    }
    
    .typewriter-container {
      height: 60px;
      display: flex;
      align-items: center;
    }
    
    .typewriter {
      font-size: 1.5rem;
      font-weight: 600;
      color: #718096;
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }
    
    .cursor {
      display: inline-block;
      width: 3px;
      height: 1.5rem;
      background: linear-gradient(45deg, #667eea, #764ba2);
      margin-left: 2px;
      animation: blink 1s infinite;
    }
    
    @keyframes blink {
      0%, 50% { opacity: 1; }
      51%, 100% { opacity: 0; }
    }
    
    .hero-description {
      font-size: 1.125rem;
      color: #718096;
      line-height: 1.7;
      margin: 0;
      max-width: 600px;
    }
    
    .cta-button {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      padding: 1rem 2rem;
      background: linear-gradient(45deg, #667eea, #764ba2);
      color: white;
      text-decoration: none;
      border-radius: 0.75rem;
      font-weight: 600;
      font-size: 1.125rem;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      transition: all 0.3s ease-in-out;
      position: relative;
      overflow: hidden;
      width: fit-content;
    }
    
    .cta-button::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s ease-in-out;
    }
    
    .cta-button:hover::before {
      left: 100%;
    }
    
    .cta-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }
    
    /* Projects Section */
    .highlight-projects {
      padding: 4rem 1rem;
      background: #f7fafc;
      position: relative;
    }
    
    .projects-container {
      max-width: 1200px;
      margin: 0 auto;
    }
    
    .section-title {
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: clamp(2rem, 4vw, 3rem);
      font-weight: 700;
      text-align: center;
      margin: 0 0 1rem;
      color: #2d3748;
    }
    
    .text-gradient {
      background: linear-gradient(45deg, #667eea, #764ba2);
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    
    .section-subtitle {
      text-align: center;
      color: #718096;
      font-size: 1.125rem;
      margin: 0 0 4rem;
      max-width: 600px;
      margin-left: auto;
      margin-right: auto;
    }
    
    .projects-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
      gap: 2rem;
      margin-top: 4rem;
    }
    
    .project-card {
      background: #ffffff;
      border-radius: 1rem;
      overflow: hidden;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      transition: all 0.3s ease-in-out;
      border: 1px solid #e2e8f0;
      position: relative;
    }
    
    .project-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(45deg, #667eea, #764ba2);
      transform: scaleX(0);
      transform-origin: left;
      transition: transform 0.3s ease-in-out;
    }
    
    .project-card:hover::before {
      transform: scaleX(1);
    }
    
    .project-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    }
    
    .project-image {
      height: 200px;
      background: linear-gradient(135deg, #667eea, #764ba2);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1.25rem;
      font-weight: 600;
      position: relative;
      overflow: hidden;
    }
    
    .project-image::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('data:image/svg+xml,<svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg"><g fill="white" fill-opacity="0.1"><rect width="2" height="2"/></g></svg>');
      pointer-events: none;
    }
    
    .project-content {
      padding: 2rem;
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }
    
    .project-title {
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: 1.375rem;
      font-weight: 600;
      margin: 0;
      color: #2d3748;
    }
    
    .project-description {
      color: #718096;
      line-height: 1.6;
      margin: 0;
      flex-grow: 1;
    }
    
    .project-links {
      display: flex;
      gap: 1rem;
      margin-top: 1rem;
    }
    
    .project-link {
      padding: 0.5rem 1.5rem;
      border-radius: 0.5rem;
      text-decoration: none;
      font-weight: 500;
      transition: all 0.15s ease-in-out;
      border: 2px solid #e2e8f0;
      color: #718096;
      background: #ffffff;
    }
    
    .project-link.demo {
      background: linear-gradient(45deg, #667eea, #764ba2);
      color: white;
      border-color: transparent;
    }
    
    .project-link:hover {
      transform: translateY(-1px);
      box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    }
    
    .project-link.demo:hover {
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    }
    
    .project-link:not(.demo):hover {
      border-color: #667eea;
      color: #667eea;
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
      .hero-container {
        grid-template-columns: 1fr;
        text-align: center;
        gap: 2rem;
      }
      
      .hero-content {
        align-items: center;
        text-align: center;
      }
      
      .welcome-message {
        text-align: center;
      }
      
      .hero-title {
        text-align: center;
      }
      
      .typewriter-container {
        justify-content: center;
      }
      
      .hero-description {
        text-align: center;
        margin: 0 auto;
      }
      
      .cta-button {
        align-self: center;
      }
      
      .profile-image {
        width: 250px;
        height: 250px;
      }
      
      .projects-grid {
        grid-template-columns: 1fr;
      }
      
      .hero-section {
        padding: 1.5rem 1rem;
      }
      
      .highlight-projects {
        padding: 2rem 1rem;
      }
      
      .project-links {
        flex-direction: column;
      }
      
      .project-link {
        text-align: center;
      }
    }
    
    @media (max-width: 480px) {
      .profile-image {
        width: 200px;
        height: 200px;
      }
      
      .social-links {
        gap: 0.5rem;
      }
      
      .social-link {
        width: 40px;
        height: 40px;
      }
      
      .hero-title {
        font-size: 2rem;
        text-align: center;
      }
      
      .typewriter {
        font-size: 1.25rem;
      }
      
      .typewriter-container {
        justify-content: center;
      }
      
      .welcome-message {
        text-align: center;
        font-size: 1rem;
      }
      
      .hero-description {
        font-size: 1rem;
        text-align: center;
      }
      
      .projects-grid {
        grid-template-columns: 1fr;
      }
      
      .project-card {
        margin: 0 -0.5rem;
      }
    }
    
    /* Accessibility Improvements */
    @media (prefers-reduced-motion: reduce) {
      * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
      }
      
      .cursor {
        animation: none;
        opacity: 1;
      }
    }
    
    /* Focus Styles */
    .cta-button:focus,
    .project-link:focus,
    .social-link:focus {
      outline: 2px solid #667eea;
      outline-offset: 2px;
    }
    
    /* Print Styles */
    @media print {
      .hero-section {
        min-height: auto;
        padding: 1.5rem;
      }
      
      .social-links {
        display: none;
      }
      
      .cta-button {
        display: none;
      }
      
      .project-card {
        break-inside: avoid;
        box-shadow: none;
        border: 1px solid #e2e8f0;
      }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="hero-section">
        <div class="hero-container">
            <div class="hero-image">
                <img src='<%= ResolveUrl("~/Static/shifat-hasan-new.jpeg") %>' alt="Shifat Hasan" class="profile-image" 
                     onerror="this.style.display='none'; this.parentElement.innerHTML='<div style=&quot;width:300px;height:300px;border-radius:50%;background:linear-gradient(45deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;color:white;font-size:2rem;font-weight:bold;&quot;>SH</div>';" />
                <div class="social-links">
                    <a href="https://github.com/shifathasangns" class="social-link" title="GitHub" target="_blank" rel="noopener noreferrer">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                        </svg>
                    </a>
                    <a href="https://linkedin.com/in/shifathasan" class="social-link" title="LinkedIn" target="_blank" rel="noopener noreferrer">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                        </svg>
                    </a>
                    <a href="https://twitter.com/shifathasan" class="social-link" title="Twitter" target="_blank" rel="noopener noreferrer">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                        </svg>
                    </a>
                    <a href="mailto:shifat@example.com" class="social-link" title="Email">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M24 5.457v13.909c0 .904-.732 1.636-1.636 1.636h-3.819V11.73L12 16.64l-6.545-4.91v9.273H1.636A1.636 1.636 0 0 1 0 19.366V5.457c0-.904.732-1.636 1.636-1.636h1.034l9.33 7.87 9.33-7.87h1.034c.904 0 1.636.732 1.636 1.636z"/>
                        </svg>
                    </a>
                </div>
            </div>
            <div class="hero-content">
                <div class="welcome-message">👋 Welcome to my Portfolio</div>
                <h1 class="hero-title">Hi, I'm <span class="name-highlight">Shifat</span></h1>
                <div class="typewriter-container">
                    <div class="typewriter" id="typewriter">
                        <span id="typewriter-text"></span>
                        <span class="cursor"></span>
                    </div>
                </div>
                <p class="hero-description">
                    Passionate full-stack developer with expertise in modern web technologies. 
                    I create beautiful, functional, and user-friendly applications that solve real-world problems. 
                    Let's build something amazing together!
                </p>
                <a href="#projects" class="cta-button">Explore My Work</a>
            </div>
        </div>
    </section>

    <section class="highlight-projects" id="projects">
        <div class="projects-container">
            <h2 class="section-title">Featured <span class="text-gradient">Projects</span></h2>
            <p class="section-subtitle">Here are some of my recent works that showcase my skills and creativity</p>
          
            <div id="project-cards">
              <asp:Repeater ID="FeatureProjectsRepeater" runat="server">
                <ItemTemplate>
                  <div class="project-card" onclick="openProjectModal(<%# Eval("id") %>)">
                    <img src='<%# Eval("url_cover_image") %>' alt='<%# Eval("title") %>' onerror="this.src='~/images/placeholder.jpg'" />
                    <h3><%# Eval("title") %></h3>
                  </div>
                </ItemTemplate>
              </asp:Repeater>
            </div>
            
            <%-- <div class="projects-grid"> --%>
                <%-- project-cards will be populated using a for loop after getting showcases data from the database with type 'feature' --%>
                
                <%-- <div class="project-card"> --%>
                <%--     <div class="project-image">E-Commerce Platform</div> --%>
                <%--     <div class="project-content"> --%>
                <%--         <h3 class="project-title">Modern E-Commerce Solution</h3> --%>
                <%--         <p class="project-description"> --%>
                <%--             A full-stack e-commerce platform built with ASP.NET Core and React.  --%>
                <%--             Features include user authentication, payment integration, inventory management,  --%>
                <%--             and responsive design. --%>
                <%--         </p> --%>
                <%--         <div class="project-links"> --%>
                <%--             <a href="#" class="project-link demo">Live Demo</a> --%>
                <%--             <a href="#" class="project-link">Source Code</a> --%>
                <%--         </div> --%>
                <%--     </div> --%>
                <%-- </div> --%>
                <%-- --%>
                <%-- <div class="project-card"> --%>
                <%--     <div class="project-image">Task Management App</div> --%>
                <%--     <div class="project-content"> --%>
                <%--         <h3 class="project-title">Collaborative Task Manager</h3> --%>
                <%--         <p class="project-description"> --%>
                <%--             A real-time collaborative task management application with drag-and-drop functionality,  --%>
                <%--             team collaboration features, and progress tracking. Built using SignalR and Entity Framework. --%>
                <%--         </p> --%>
                <%--         <div class="project-links"> --%>
                <%--             <a href="#" class="project-link demo">Live Demo</a> --%>
                <%--             <a href="#" class="project-link">Source Code</a> --%>
                <%--         </div> --%>
                <%--     </div> --%>
                <%-- </div> --%>
            <%-- </div> --%>
        </div>
    </section>
    
    <!-- Hidden field to store project data for JavaScript -->
    <asp:HiddenField ID="FeatureProjectsJsonData" runat="server" />

    <script type="text/javascript">
        // Typewriter effect
        var texts = [
            "Full Stack Developer",
            ".NET Specialist", 
            "React Developer",
            "Problem Solver",
            "UI/UX Enthusiast",
            "Database Designer"
        ];
        var textIndex = 0;
        var charIndex = 0;
        var isDeleting = false;
        var typeSpeed = 100;

        function typeWriter() {
            var currentText = texts[textIndex];
            var typewriterElement = document.getElementById('typewriter-text');

            if (!typewriterElement) {
                return; // Element not found, exit function
            }

            if (isDeleting) {
                typewriterElement.textContent = currentText.substring(0, charIndex - 1);
                charIndex--;
                typeSpeed = 50;
            } else {
                typewriterElement.textContent = currentText.substring(0, charIndex + 1);
                charIndex++;
                typeSpeed = 100;
            }

            if (!isDeleting && charIndex === currentText.length) {
                typeSpeed = 2000; // Pause at end
                isDeleting = true;
            } else if (isDeleting && charIndex === 0) {
                isDeleting = false;
                textIndex = (textIndex + 1) % texts.length;
            }

            setTimeout(typeWriter, typeSpeed);
        }

        // Initialize page functionality
        function initializePage() {
            // Start typewriter effect
            setTimeout(typeWriter, 1000);

            // Setup smooth scrolling for CTA button
            var ctaButton = document.querySelector('.cta-button');
            if (ctaButton) {
                ctaButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    var projectsSection = document.getElementById('projects');
                    if (projectsSection) {
                        projectsSection.scrollIntoView({
                            behavior: 'smooth'
                        });
                    }
                });
            }
        }

        // Cross-browser DOM ready function
        function domReady(fn) {
            if (document.readyState === 'complete' || document.readyState === 'interactive') {
                setTimeout(fn, 1);
            } else {
                document.addEventListener('DOMContentLoaded', fn);
            }
        }

        // Initialize when DOM is ready
        domReady(initializePage);

        // Fallback initialization for older browsers
        if (window.addEventListener) {
            window.addEventListener('load', initializePage, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initializePage);
        }
        
        // Load feature projects data from hidden field

        var projectsData = [];

        function initializeProjectsData() {
            var jsonData = document.getElementById('<%= FeatureProjectsJsonData.ClientID %>').value;
            if (jsonData) {
                projectsData = JSON.parse(jsonData);
            }
        }

        function openProjectModal(projectId) {
            var project = projectsData.find(p => p.id === projectId);
            if (!project) return;

            var modalContent = document.getElementById('modalContent');
            var html = '<div class="project-detail">';
            
            // Cover image
            if (project.url_cover_image) {
                html += '<img src="' + project.url_cover_image + '" alt="' + project.title + '" class="modal-cover-image" />';
            }
            
            // Title
            html += '<h2>' + project.title + '</h2>';
            
            // Type
            html += '<p class="project-type"><strong>Type:</strong> ' + project.type + '</p>';
            
            // Description
            if (project.description) {
                html += '<div class="project-description"><strong>Description:</strong><br/>' + project.description.replace(/\n/g, '<br/>') + '</div>';
            }
            
            // Links section
            html += '<div class="project-links"><strong>Links:</strong><br/>';
            
            if (project.url_github) {
                html += '<a href="' + project.url_github + '" target="_blank" rel="noopener">GitHub Repository</a><br/>';
            }
            
            if (project.url_drive) {
                html += '<a href="' + project.url_drive + '" target="_blank" rel="noopener">Google Drive</a><br/>';
            }
            
            if (project.url_youtube) {
                html += '<a href="' + project.url_youtube + '" target="_blank" rel="noopener">YouTube Video</a><br/>';
            }
            
            if (project.url_other) {
                html += '<a href="' + project.url_other + '" target="_blank" rel="noopener">Other Link</a><br/>';
            }
            
            html += '</div>';
            html += '</div>';
            
            modalContent.innerHTML = html;
            document.getElementById('projectModal').style.display = 'block';
        }

        function closeProjectModal() {
            document.getElementById('projectModal').style.display = 'none';
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
    </script>
  
  
</asp:Content>
