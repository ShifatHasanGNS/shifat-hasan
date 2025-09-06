<%@ Page Language="C#" CodeBehind="~/Pages/Admin/Dashboard/UserFeedbacks.aspx.cs" Inherits="shifat_hasan.Pages.Admin.Dashboard.UserFeedbacks" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>User Feedback Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .search-section {
            padding: 20px 30px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }

        .search-container {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-input {
            flex: 1;
            min-width: 300px;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5a67d8;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: #718096;
            color: white;
        }

        .btn-secondary:hover {
            background: #4a5568;
            transform: translateY(-1px);
        }

        .btn-success {
            background: #48bb78;
            color: white;
        }

        .btn-success:hover {
            background: #38a169;
            transform: translateY(-1px);
        }

        .content-section {
            padding: 30px;
        }

        .stats-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: #f7fafc;
            border-radius: 12px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #667eea;
        }

        .stat-label {
            color: #718096;
            font-size: 0.9rem;
            margin-top: 5px;
        }

        .feedback-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .feedback-card {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            background: white;
        }

        .feedback-card:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-color: #667eea;
        }

        .feedback-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            cursor: pointer;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }

        .feedback-header:hover {
            background: #edf2f7;
        }

        .user-info {
            flex: 1;
        }

        .user-name {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .user-email {
            color: #718096;
            font-size: 0.9rem;
        }

        .message-title {
            font-weight: 500;
            color: #4a5568;
            margin: 10px 0 5px 0;
        }

        .feedback-meta {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .feedback-date {
            color: #718096;
            font-size: 0.9rem;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-replied {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-pending {
            background: #fed7d7;
            color: #742a2a;
        }

        .expand-icon {
            width: 20px;
            height: 20px;
            color: #718096;
            transition: transform 0.3s ease;
        }

        .feedback-card.expanded .expand-icon {
            transform: rotate(180deg);
        }

        .feedback-details {
            display: none;
            padding: 0 20px 20px 20px;
        }

        .feedback-card.expanded .feedback-details {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message-content {
            background: #f7fafc;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #667eea;
        }

        .existing-reply {
            background: #e6fffa;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            border-left: 4px solid #48bb78;
        }

        .reply-section {
            margin-top: 20px;
            padding: 20px;
            background: #f8fafc;
            border-radius: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #4a5568;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-textarea {
            min-height: 100px;
            resize: vertical;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid transparent;
        }

        .alert-success {
            background: #c6f6d5;
            border-color: #9ae6b4;
            color: #22543d;
        }

        .alert-error {
            background: #fed7d7;
            border-color: #feb2b2;
            color: #742a2a;
        }

        .alert-warning {
            background: #fefcbf;
            border-color: #f6e05e;
            color: #744210;
        }

        .alert-info {
            background: #bee3f8;
            border-color: #90cdf4;
            color: #2c5282;
        }

        .no-feedback {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }

        .no-feedback svg {
            width: 80px;
            height: 80px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: #718096;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .search-container {
                flex-direction: column;
                align-items: stretch;
            }

            .search-input {
                min-width: auto;
            }

            .stats-bar {
                flex-direction: column;
                gap: 20px;
            }

            .feedback-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .feedback-meta {
                align-self: flex-end;
            }

            .action-buttons {
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h1>User Feedback Management</h1>
                <p>Manage and respond to user feedback efficiently</p>
            </div>

            <asp:Panel ID="MessagePanel" runat="server" Visible="false">
                <div id="alertDiv" runat="server" class="alert" style="margin: 20px 30px 0 30px; border-radius: 8px;">
                    <asp:Label ID="MessageLabel" runat="server"></asp:Label>
                </div>
            </asp:Panel>

            <div class="search-section">
                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" placeholder="Search by name, email, or message title..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click"/>
                    <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="btn btn-secondary" OnClick="btnShowAll_Click"/>
                </div>
            </div>

            <div class="content-section">
                <div class="stats-bar">
                    <div class="stat-item">
                        <div class="stat-number"><asp:Label ID="lblTotalFeedback" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Feedback</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number"><asp:Label ID="lblPendingReplies" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Pending Replies</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number"><asp:Label ID="lblRepliedFeedback" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Replied</div>
                    </div>
                </div>

                <div class="feedback-list">
                    <asp:Repeater ID="rptFeedback" runat="server" OnItemCommand="rptFeedback_ItemCommand">
                        <ItemTemplate>
                            <div class="feedback-card" data-id="<%# Eval("id") %>">
                                <div class="feedback-header" onclick="toggleFeedback(this)">
                                    <div class="user-info">
                                        <div class="user-name"><%# Eval("user_name") %></div>
                                        <div class="user-email"><%# Eval("user_email") %></div>
                                        <div class="message-title"><%# Eval("user_message_title") %></div>
                                    </div>
                                    <div class="feedback-meta">
                                        <div class="feedback-date"><%# Eval("datetime_user_feedback", "{0:MMM dd, yyyy HH:mm}") %></div>
                                        <div class="status-badge <%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) ? "status-replied" : "status-pending" %>">
                                            <%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) ? "Replied" : "Pending" %>
                                        </div>
                                        <svg class="expand-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                        </svg>
                                    </div>
                                </div>

                                <div class="feedback-details">
                                    <div class="message-content">
                                        <strong>User Message:</strong><br/>
                                        <%# Eval("user_message_body") %>
                                    </div>

                                    <%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) ?
                                            "<div class='existing-reply'><strong>Your Reply:</strong><br/>" +
                                            Eval("admin_message_body") +
                                            "<br/><small style='color: #718096;'>Replied on: " + Eval("datetime_admin_reply", "{0:MMM dd, yyyy HH:mm}") + "</small></div>" :
                                            "" %>

                                    <div class="reply-section">
                                        <h4 style="margin-bottom: 20px; color: #4a5568;">
                                            <%# !string.IsNullOrEmpty(Eval("admin_message_title")?.ToString()) ? "Update Reply" : "Send Reply" %>
                                        </h4>
                                        
                                        <div class="form-group">
                                            <label class="form-label">Subject</label>
                                            <asp:TextBox ID="txtReplySubject" runat="server" CssClass="form-input" 
                                                        Text='<%# "Re: " + Eval("user_message_title") %>'></asp:TextBox>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Reply Message</label>
                                            <asp:TextBox ID="txtReplyMessage" runat="server" CssClass="form-input form-textarea" 
                                                        TextMode="MultiLine" Rows="6"
                                                        Text='<%# !string.IsNullOrEmpty(Eval("admin_message_body")?.ToString()) ? Eval("admin_message_body") : "Dear " + Eval("user_name") + ",\n\nThank you for contacting us. We have received your message and appreciate your feedback.\n\n[Your response here]\n\nBest regards,\nAdmin Team" %>'></asp:TextBox>
                                        </div>

                                        <div class="action-buttons">
                                            <asp:Button ID="btnSendReply" runat="server" Text="Send Reply" CssClass="btn btn-success" 
                                                       CommandName="SendReply" CommandArgument='<%# Eval("id") %>' 
                                                       OnClientClick="return confirm('Are you sure you want to send this reply?');" />
                                            <asp:Button ID="btnSaveReply" runat="server" Text="Save Draft" CssClass="btn btn-primary" 
                                                       CommandName="SaveReply" CommandArgument='<%# Eval("id") %>' />
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete Feedback" CssClass="btn btn-secondary" 
                                                       CommandName="Delete" CommandArgument='<%# Eval("id") %>' 
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
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
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
        function toggleFeedback(headerElement) {
            const card = headerElement.closest('.feedback-card');
            const isExpanded = card.classList.contains('expanded');
            
            // Close all other expanded cards
            document.querySelectorAll('.feedback-card.expanded').forEach(function(expandedCard) {
                if (expandedCard !== card) {
                    expandedCard.classList.remove('expanded');
                }
            });
            
            // Toggle current card
            if (isExpanded) {
                card.classList.remove('expanded');
            } else {
                card.classList.add('expanded');
            }
        }

        // Auto-hide alert messages after 5 seconds
        window.onload = function() {
            var alertDiv = document.getElementById('<%= MessagePanel.ClientID %>');
            if (alertDiv && alertDiv.style.display !== 'none') {
                setTimeout(function() {
                    alertDiv.style.fadeOut = 'opacity 0.5s';
                    alertDiv.style.opacity = '0';
                    setTimeout(function() {
                        alertDiv.style.display = 'none';
                    }, 500);
                }, 5000);
            }
        };

        // Add loading state for buttons
        document.addEventListener('DOMContentLoaded', function() {
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    if (this.type === 'submit') {
                        this.style.opacity = '0.7';
                        this.style.pointerEvents = 'none';
                        const originalText = this.textContent;
                        this.textContent = 'Processing...';
                        
                        setTimeout(() => {
                            this.textContent = originalText;
                            this.style.opacity = '1';
                            this.style.pointerEvents = 'auto';
                        }, 3000);
                    }
                });
            });
        });
    </script>
</body>
</html>
