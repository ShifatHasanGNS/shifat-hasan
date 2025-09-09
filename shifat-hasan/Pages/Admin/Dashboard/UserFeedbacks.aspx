<%@ Page Language="C#" CodeBehind="~/Pages/Admin/Dashboard/UserFeedbacks.aspx.cs"
    Inherits="shifat_hasan.Pages.Admin.Dashboard.UserFeedbacks" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html>

<head runat="server">
    <title>Shifat | User-Feedbacks</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href='<%= ResolveUrl("~/Styles/UserFeedbacks.css") %>' />
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/UserFeedbacks.js") %>'></script>
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
                            <span class="admin-link-text">Home</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/AdminInfo.aspx" runat="server" class="admin-nav-link">
                            <span class="admin-link-text">Admin Info</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-nav-link">
                            <span class="admin-link-text">Showcase List</span>
                            <span class="admin-link-underline"></span>
                        </a>
                        <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server"
                            class="admin-nav-link active">
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
                    <a href="~/Pages/Admin/Dashboard/ShowcaseList.aspx" runat="server" class="admin-mobile-link">Showcase List</a>
                    <a href="~/Pages/Admin/Dashboard/UserFeedbacks.aspx" runat="server" class="admin-mobile-link active">User Feedbacks</a>
                </div>
            </nav>

            <div class="header">
                <h1>User Feedback Management</h1>
                <p>Manage and respond to user feedback efficiently</p>
            </div>

            <asp:Panel ID="MessagePanel" runat="server" Visible="false">
                <div id="alertDiv" runat="server" class="alert"
                    style="margin: 20px 30px 0 30px; border-radius: 8px;">
                    <asp:Label ID="MessageLabel" runat="server"></asp:Label>
                </div>
            </asp:Panel>

            <div class="search-section">
                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input"
                        placeholder="Search by name, email, or message title..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                        OnClick="btnSearch_Click" />
                    <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="btn btn-secondary"
                        OnClick="btnShowAll_Click" />
                </div>
            </div>

            <div class="content-section">
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalFeedback" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Total Feedback</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">
                            <asp:Label ID="lblPendingReplies" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Pending Replies</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">
                            <asp:Label ID="lblRepliedFeedback" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="stat-label">Replied</div>
                    </div>
                </div>

                <div class="feedback-list">
                    <asp:Repeater ID="rptFeedback" runat="server" OnItemCommand="rptFeedback_ItemCommand">
                        <ItemTemplate>
                            <div class="feedback-card" data-id="<%# Eval("id") %>">
                                <div class="feedback-header" onclick="toggleFeedback(this)">
                                    <div class="user-info">
                                        <div class="user-name">
                                            <%# Eval("user_name") %>
                                        </div>
                                        <div class="user-email">
                                            <%# Eval("user_email") %>
                                        </div>
                                        <div class="message-title">
                                            <%# Eval("user_message_title") %>
                                        </div>
                                    </div>
                                    <div class="feedback-meta">
                                        <div class="feedback-date">
                                            <%# Eval("datetime_user_feedback", "{0:MMM dd, yyyy HH:mm}") %>
                                        </div>
                                        <div class="status-badge <%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) ? "status-replied" : "status-pending" %>">
                                            <%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString())
                                                    ? "Replied" : "Pending" %>
                                        </div>
                                        <svg class="expand-icon" fill="none" stroke="currentColor"
                                             viewBox="0 0 24 24" width="24" height="24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M19 9l-7 7-7-7"></path>
                                        </svg>
                                    </div>
                                </div>

                                <div class="feedback-details">
                                    <div class="message-content">
                                        <strong>User Message:</strong><br />
                                        <%# Eval("user_message_body") %>
                                    </div>

                                    <asp:Panel ID="pnlExistingReply" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) %>'>
                                        <div class="existing-reply">
                                            <strong>Your Reply:</strong><br/>
                                            <%# Eval("admin_message_body") %>
                                            <br/>
                                            <small style='color: var(--slate-400);'>Replied on: <%# Eval("datetime_admin_reply", "{0:MMM dd, yyyy HH:mm}") %></small>
                                        </div>
                                    </asp:Panel>

                                        <div class="reply-section">
                                            <h4 style="margin-bottom: 20px; color: var(--slate-300);">
                                                <asp:Label ID="lblReplyHeader" runat="server" 
                                                           Text='<%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) ? "Update Reply" : "Send Reply" %>'></asp:Label>
                                            </h4>

                                            <div class="form-group">
                                                <label class="form-label">Subject</label>
                                                <asp:TextBox ID="txtReplySubject" runat="server"
                                                    CssClass="form-input"
                                                    Text='<%# "Re: " + Eval("user_message_title") %>'></asp:TextBox>
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">Reply Message</label>
                                                <asp:TextBox ID="txtReplyMessage" runat="server"
                                                    CssClass="form-input form-textarea" TextMode="MultiLine"
                                                    Rows="6"
                                                             Text='<%# GetReplyText(Eval("admin_message_body"), Eval("user_name")) %>'>
                                                </asp:TextBox>
                                            </div>

                                            <div class="action-buttons">
                                                <asp:Button ID="btnSendReply" runat="server" Text="Send Reply"
                                                    CssClass="btn btn-success" CommandName="SendReply"
                                                    CommandArgument='<%# Eval("id") %>'
                                                    OnClientClick="return confirm('Are you sure you want to send this reply?');" />
                                                <asp:Button ID="btnSaveReply" runat="server" Text="Save Draft"
                                                    CssClass="btn btn-primary" CommandName="SaveReply"
                                                    CommandArgument='<%# Eval("id") %>' />
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete Feedback"
                                                    CssClass="btn btn-secondary" CommandName="Delete"
                                                    CommandArgument='<%# Eval("id") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this feedback? This action cannot be undone.');" />
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Panel ID="pnlNoFeedback" runat="server" Visible="false">
                        <div class="no-feedback">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4">
                                </path>
                            </svg>
                            <h3>No feedback found</h3>
                            <p>No feedback records match your current search criteria.</p>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        // Auto-hide alert messages after 5 seconds - needs server control access
        window.onload = function () {
            var alertDiv = document.getElementById('<%= MessagePanel.ClientID %>');
            if (alertDiv && alertDiv.style.display !== 'none') {
                setTimeout(function () {
                    alertDiv.style.transition = 'opacity 0.5s';
                    alertDiv.style.opacity = '0';
                    setTimeout(function () {
                        alertDiv.style.display = 'none';
                    }, 500);
                }, 5000);
            }
        };
    </script>
</body>

</html>