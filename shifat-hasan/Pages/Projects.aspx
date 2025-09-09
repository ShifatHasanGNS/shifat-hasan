<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
    CodeBehind="Projects.aspx.cs" Inherits="shifat_hasan.Pages.Projects" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shifat | Projects</title>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/Projects.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/Projects.js") %>'></script>
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
</asp:Content>
