using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using Newtonsoft.Json;

namespace shifat_hasan.Pages
{
    public partial class Projects : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadShowcaseData();
            }
        }

        private void LoadShowcaseData(string searchTerm = "", string typeFilter = "")
        {
            try
            {
                List<ShowcaseModel> projects = GetProjectsFromDatabase(searchTerm, typeFilter);
                ProjectsRepeater.DataSource = projects;
                ProjectsRepeater.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error loading projects: " + ex.Message);
            }
        }

        // Search functionality
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            string typeFilter = ddlTypeFilter.SelectedValue;
            LoadShowcaseData(searchTerm, typeFilter);
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlTypeFilter.SelectedIndex = 0;
            LoadShowcaseData();
        }

        // Database methods
        private static List<ShowcaseModel> GetProjectsFromDatabase(string searchTerm = "", string typeFilter = "")
        {
            var projects = new List<ShowcaseModel>();
            var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using var connection = new SqlConnection(connectionString);
            var query = @"SELECT * FROM [showcase] WHERE 1=1";

            // Add search conditions
            if (!string.IsNullOrEmpty(searchTerm))
            {
                query += " AND (title LIKE @searchTerm OR description LIKE @searchTerm)";
            }

            if (!string.IsNullOrEmpty(typeFilter))
            {
                query += " AND type = @typeFilter";
            }

            query += " ORDER BY id DESC";

            using var command = new SqlCommand(query, connection);
            if (!string.IsNullOrEmpty(searchTerm))
            {
                command.Parameters.AddWithValue("@searchTerm", "%" + searchTerm + "%");
            }

            if (!string.IsNullOrEmpty(typeFilter))
            {
                command.Parameters.AddWithValue("@typeFilter", typeFilter);
            }

            connection.Open();
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                var project = new ShowcaseModel
                {
                    Id = Convert.ToInt32(reader["id"]), // Fixed: Convert object to int
                    Type = reader["type"]?.ToString() ?? "",
                    Title = reader["title"]?.ToString() ?? "",
                    Description = reader["description"]?.ToString() ?? "",
                    UrlCoverImage = reader["url_cover_image"]?.ToString() ?? "",
                    UrlGithub = reader["url_github"]?.ToString() ?? "",
                    UrlDrive = reader["url_drive"]?.ToString() ?? "",
                    UrlYoutube = reader["url_youtube"]?.ToString() ?? "",
                    UrlOther = reader["url_other"]?.ToString() ?? ""
                };

                projects.Add(project);
            }

            return projects;
        }
        
        // Helper methods for display formatting
        protected string TruncateText(string text, int maxLength)
        {
            if (string.IsNullOrEmpty(text))
                return "No description available";

            if (text.Length <= maxLength)
                return Server.HtmlEncode(text);

            return Server.HtmlEncode(text.Substring(0, maxLength)) + "...";
        }

        protected string FormatProjectLinks(string github, string drive, string youtube, string other)
        {
            List<string> links = new List<string>();

            if (!string.IsNullOrEmpty(github))
            {
                string encodedGithub = Server.HtmlEncode(github);
                links.Add("<a href='" + encodedGithub +
                          "' target='_blank' rel='noopener' class='link-github'>GitHub</a>");
            }

            if (!string.IsNullOrEmpty(drive))
            {
                string encodedDrive = Server.HtmlEncode(drive);
                links.Add("<a href='" + encodedDrive +
                          "' target='_blank' rel='noopener' class='link-drive'>Drive</a>");
            }

            if (!string.IsNullOrEmpty(youtube))
            {
                string encodedYoutube = Server.HtmlEncode(youtube);
                links.Add("<a href='" + encodedYoutube +
                          "' target='_blank' rel='noopener' class='link-youtube'>YouTube</a>");
            }

            if (!string.IsNullOrEmpty(other))
            {
                string encodedOther = Server.HtmlEncode(other);
                links.Add(
                    "<a href='" + encodedOther + "' target='_blank' rel='noopener' class='link-other'>Link</a>");
            }

            if (links.Count > 0)
            {
                return string.Join(" ", links.ToArray());
            }
            else
            {
                return "<span class='no-links'>No external links</span>";
            }
        }
    }

    // Model classes
    public class ShowcaseModel
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string UrlCoverImage { get; set; }
        public string UrlGithub { get; set; }
        public string UrlDrive { get; set; }
        public string UrlYoutube { get; set; }
        public string UrlOther { get; set; }

        // Database column name aliases for databinding
        public int id => Id;
        public string type => Type;
        public string title => Title;
        public string description => Description;
        public string url_cover_image => UrlCoverImage;
        public string url_github => UrlGithub;
        public string url_drive => UrlDrive;
        public string url_youtube => UrlYoutube;
        public string url_other => UrlOther;
    }
}