<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
    CodeBehind="Home.aspx.cs" Inherits="shifat_hasan.Pages.Home" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shifat | Portfolio</title>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/Home.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/Home.js") %>'></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="hero-section fade-in">
        <div class="hero-container">
            <div class="hero-image slide-in">
                <img src='<%= ResolveUrl("~/Static/shifat-hasan.jpeg") %>' alt="Shifat Hasan" class="profile-image" 
                     onerror="this.style.display='none'; this.parentElement.innerHTML='<div style=&quot;width:300px;height:300px;border-radius:50%;background:linear-gradient(45deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;color:white;font-size:2rem;font-weight:bold;&quot;>SH</div>';" />
                <div class="social-links">
                    <a href="https://github.com/ShifatHasanGNS" class="social-link pulse-on-hover" title="GitHub" target="_blank" rel="noopener noreferrer">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                        </svg>
                    </a>
                  <a href="https://www.facebook.com/ShifatHasanGNS" class="social-link pulse-on-hover" title="Facebook" target="_blank" rel="noopener noreferrer">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                    </svg>
                  </a>
                  <a href="https://www.instagram.com/ShifatHasanGNS" class="social-link pulse-on-hover" title="Instagram" target="_blank" rel="noopener noreferrer">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                    </svg>
                  </a>
                    <a href="mailto:shifathasan.pro@gmail.com" class="social-link pulse-on-hover" title="Email">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M24 5.457v13.909c0 .904-.732 1.636-1.636 1.636h-3.819V11.73L12 16.64l-6.545-4.91v9.273H1.636A1.636 1.636 0 0 1 0 19.366V5.457c0-.904.732-1.636 1.636-1.636h1.034l9.33 7.87 9.33-7.87h1.034c.904 0 1.636.732 1.636 1.636z"/>
                        </svg>
                    </a>
                </div>
            </div>
            <div class="hero-content">
                <div class="welcome-message fade-in">👋 Welcome to my Portfolio</div>
                <h1 class="hero-title fade-in">Hi, I'm <span class="name-highlight">Shifat</span></h1>
                <div class="typewriter-container fade-in">
                    <div class="typewriter" id="typewriter">
                        <span id="typewriter-text"></span>
                        <span class="cursor"></span>
                    </div>
                </div>
                <p class="hero-description fade-in">
                    Computer Science Engineering student at KUET with a passion for crafting innovative software solutions. 
                    I blend academic knowledge with hands-on development experience to build applications that make a difference. 
                    Currently exploring the intersections of web development, algorithms, and emerging technologies.
                </p>
                <a href="#about-section" class="cta-button pulse-on-hover">About Me</a>
            </div>
        </div>
    </section>
  
    <hr class="section-separator"/>
  
    <section class="about-section fade-in" id="about-section">
        <div class="about-container">
            <h2 class="section-title slide-in"><span class="text-gradient">About Me</span></h2>
            <p class="section-subtitle fade-in">Passionate Computer Science student building tomorrow's solutions today</p>
            
            <div class="about-content">
                <div class="about-card fade-in">
                    <h3><span class="emoji">🎓</span>Education & Background</h3>
                    <p>Currently pursuing <strong>Computer Science & Engineering</strong> at <strong>Khulna University of Engineering & Technology (KUET)</strong>, one of Bangladesh's premier engineering institutions. My academic journey combines theoretical computer science foundations with practical programming expertise.</p>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">💻</span>Technical Skills</h3>
                    
                    <div class="skills-grid">
                        <div class="skill-category">
                            <h5>Programming Languages:</h5>
                            <p><strong>Primary:</strong> JavaScript, Python, Java<br/>
                            <strong>Learning:</strong> C++, TypeScript, Go</p>
                        </div>
                        
                        <div class="skill-category">
                            <h5>Web Development:</h5>
                            <p><strong>Frontend:</strong> React.js, HTML5, CSS3, Tailwind CSS<br/>
                            <strong>Backend:</strong> Node.js, Express.js, REST APIs<br/>
                            <strong>Database:</strong> MongoDB, MySQL, PostgreSQL</p>
                        </div>
                        
                        <div class="skill-category">
                            <h5>Tools & Technologies:</h5>
                            <p><strong>Version Control:</strong> Git, GitHub<br/>
                            <strong>Development:</strong> VS Code, Postman, Chrome DevTools<br/>
                            <strong>Deployment:</strong> Vercel, Netlify, Heroku</p>
                        </div>
                    </div>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">🚀</span>Project Experience</h3>
                    <p><strong>Web Applications:</strong> Built full-stack applications focusing on user experience and performance optimization</p>
                    <p><strong>Algorithm Implementation:</strong> Developed solutions for competitive programming problems and data structure challenges</p>
                    <p><strong>Academic Projects:</strong> Created software systems as part of coursework, emphasizing clean code and documentation</p>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">🎯</span>Interests & Preferences</h3>
                    
                    <h4>Favorite Project Types:</h4>
                    <ul>
                        <li>Interactive web applications</li>
                        <li>Educational technology tools</li>
                        <li>Data visualization projects</li>
                        <li>Problem-solving utilities</li>
                    </ul>
                    
                    <h4>Development Philosophy:</h4>
                    <ul>
                        <li>Clean, readable code</li>
                        <li>User-centered design</li>
                        <li>Continuous learning</li>
                        <li>Open source contribution</li>
                    </ul>
                    
                    <h4>Currently Exploring:</h4>
                    <ul>
                        <li>Machine Learning integration in web apps</li>
                        <li>Mobile app development</li>
                        <li>Cloud computing platforms</li>
                        <li>DevOps practices</li>
                    </ul>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">🌟</span>Goals & Vision</h3>
                    <p>Aspiring to become a versatile software engineer who can bridge the gap between complex technical solutions and real-world user needs. I'm particularly interested in projects that combine technology with education, sustainability, or community impact.</p>
                    
                    <h4>Looking forward to:</h4>
                    <ul>
                        <li>Contributing to open source projects</li>
                        <li>Internship opportunities in tech companies</li>
                        <li>Collaborative projects with fellow developers</li>
                        <li>Building solutions that positively impact society</li>
                    </ul>
                </div>
            </div>

            <div class="quote fade-in">
                <em>"Code is poetry written in logic, and every program tells a story of problem-solving and creativity."</em>
            </div>
        </div>
    </section>
  
    <hr class="section-separator"/>

    <section class="highlight-projects fade-in" id="projects">
        <div class="projects-container">
            <h2 class="section-title slide-in">Featured <span class="text-gradient">Projects</span></h2>
            <p class="section-subtitle fade-in">Here are some of my recent works that showcase my skills and creativity</p>
            
            <div class="projects-grid">
                <asp:Repeater ID="FeatureProjectsRepeater" runat="server">
                    <ItemTemplate>
                        <div class="project-card" data-project-id='<%# Eval("id") %>'>
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
    </section>
    
    <asp:HiddenField ID="FeatureProjectsJsonData" runat="server" />
    
    <script type="text/javascript">
        // Load feature projects data from hidden field - needs server control access
        var projectsData = [];

        function initializeProjectsData() {
            var hiddenField = document.getElementById('<%= FeatureProjectsJsonData.ClientID %>');
            if (hiddenField && hiddenField.value) {
                try {
                    projectsData = JSON.parse(hiddenField.value);
                } catch (e) {
                    console.error('Error parsing projects data:', e);
                    projectsData = [];
                }
            }
        }

        // Initialize data when page loads
        window.addEventListener('load', function() {
            initializeProjectsData();
        });
    </script>
</asp:Content>
