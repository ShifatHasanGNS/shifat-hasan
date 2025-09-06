<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="shifat_hasan.Pages.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .contact-section {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .contact-section h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            background: linear-gradient(45deg, #fff, #e0e7ff);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .contact-form {
            display: grid;
            gap: 1.5rem;
            background: rgba(255,255,255,0.95);
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        }

        .contact-form > div {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .contact-form label {
            font-weight: 600;
            color: #374151;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .contact-form input,
        .contact-form textarea {
            padding: 1rem !important;
            border: 2px solid #e5e7eb !important;
            border-radius: 12px !important;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: #ffffff !important;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1) !important;
            appearance: none !important;
            -webkit-appearance: none !important;
            outline: none;
            width: 100%;
            box-sizing: border-box;
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            border-color: #667eea !important;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1), 0 4px 12px rgba(0,0,0,0.15) !important;
            transform: translateY(-1px);
        }

        .contact-form textarea {
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
        }
        
        input[type="submit"] {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            color: white !important;
            padding: 1rem 2rem !important;
            border: none !important;
            border-radius: 12px !important;
            font-size: 1.1rem !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4) !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
            width: 100% !important;
            box-sizing: border-box !important;
            -webkit-appearance: none !important;
            appearance: none !important;
        }
        
        input[type="submit"]:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6) !important;
        }
        
        input[type="submit"]:active {
            transform: translateY(0) !important;
        }

        @media (max-width: 768px) {
            .contact-section {
                margin: 1rem;
                padding: 1.5rem;
            }

            .contact-section h2 {
                font-size: 2rem;
            }

            .contact-form {
                padding: 1.5rem;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            .contact-form input,
            .contact-form textarea,
            input[type="submit"],
            input[value="Send"],
            #ContentPlaceHolder1_btnSubmit,
            .btn {
                transition: none !important;
            }

            input[type="submit"]::before,
            input[value="Send"]::before,
            #ContentPlaceHolder1_btnSubmit::before,
            .btn::before {
                display: none !important;
            }
        }

        @media (prefers-contrast: more) {
            .contact-section {
                background: #ffffff;
                border: 2px solid #000000;
            }

            .contact-section h2 {
                color: #000000;
                -webkit-text-fill-color: #000000;
            }

            .contact-form {
                background: #ffffff;
                border: 1px solid #000000;
            }

            input[type="submit"],
            input[value="Send"],
            #ContentPlaceHolder1_btnSubmit,
            .btn {
                background: #000000 !important;
                border: 2px solid #000000 !important;
            }
        }
    </style>

    <script type="text/javascript">
        function validateForm() {
            // Get the actual client IDs of the controls
            var name = document.getElementById('<%= txtName.ClientID %>').value.trim();
            var email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
            var subject = document.getElementById('<%= txtSubject.ClientID %>').value.trim();
            var message = document.getElementById('<%= txtMessage.ClientID %>').value.trim();
            
            if (!name || !email || !subject || !message) {
                alert('Please fill in all fields.');
                return false;
            }
            
            // Basic email validation
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert('Please enter a valid email address.');
                return false;
            }
            
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="contact-section">
        <h2>Contact Me</h2>
        <div class="contact-form">
            <div>
                <label for="<%= txtName.ClientID %>">Name:</label>
                <asp:TextBox ID="txtName" runat="server" />
            </div>
            <div>
                <label for="<%= txtEmail.ClientID %>">Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />
            </div>
            <div>
                <label for="<%= txtSubject.ClientID %>">Subject:</label>
                <asp:TextBox ID="txtSubject" runat="server" />
            </div>
            <div>
                <label for="<%= txtMessage.ClientID %>">Message:</label>
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Send" CssClass="btn" OnClientClick="return validateForm();" OnClick="btnSubmit_Click" />
        </div>
    </section>
</asp:Content>
