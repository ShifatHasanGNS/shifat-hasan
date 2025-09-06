using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using Newtonsoft.Json;

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

                // Bind to repeater
                FeatureProjectsRepeater.DataSource = projects;
                FeatureProjectsRepeater.DataBind();

                // Serialize for JavaScript
                var jsonData = JsonConvert.SerializeObject(projects);
                FeatureProjectsJsonData.Value = jsonData;
            }
            catch (Exception ex)
            {
                // Log error (you might want to implement proper logging)
                Response.Write($"<script>console.error('Error loading projects: {ex.Message}');</script>");
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