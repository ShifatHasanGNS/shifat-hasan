using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace shifat_hasan.Pages
{
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeatureProjects();
            }
        }

        private void LoadFeatureProjects()
        {
            try
            {
                var projects = GetProjectsFromDatabase();
                FeatureProjectsRepeater.DataSource = projects;
                FeatureProjectsRepeater.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error loading projects: " + ex.Message);
            }
        }

        private static List<FeatureProjectModel> GetProjectsFromDatabase()
        {
            var projects = new List<FeatureProjectModel>();
            var connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using var connection = new SqlConnection(connectionString);
            const string query = @"SELECT * FROM [showcase] where type = 'feature' ORDER BY title";

            using var command = new SqlCommand(query, connection);
            connection.Open();
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                var project = new FeatureProjectModel
                {
                    Id = Convert.ToInt32(reader["id"]),
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
            var links = new List<string>();

            if (!string.IsNullOrEmpty(github))
            {
                var encodedGithub = Server.HtmlEncode(github);
                links.Add("<a href='" + encodedGithub +
                          "' target='_blank' rel='noopener' class='link-github'>GitHub</a>");
            }

            if (!string.IsNullOrEmpty(drive))
            {
                var encodedDrive = Server.HtmlEncode(drive);
                links.Add("<a href='" + encodedDrive +
                          "' target='_blank' rel='noopener' class='link-drive'>Drive</a>");
            }

            if (!string.IsNullOrEmpty(youtube))
            {
                var encodedYoutube = Server.HtmlEncode(youtube);
                links.Add("<a href='" + encodedYoutube +
                          "' target='_blank' rel='noopener' class='link-youtube'>YouTube</a>");
            }

            if (!string.IsNullOrEmpty(other))
            {
                var encodedOther = Server.HtmlEncode(other);
                links.Add(
                    "<a href='" + encodedOther + "' target='_blank' rel='noopener' class='link-other'>Link</a>");
            }

            return links.Count > 0
                ? string.Join(" ", links.ToArray())
                : "<span class='no-links'>No external links</span>";
        }
    }

    // Project model class
    public class FeatureProjectModel
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

        // Database column name aliases for data binding
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