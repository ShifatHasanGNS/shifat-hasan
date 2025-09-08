using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace shifat_hasan.Pages.Admin.Dashboard
{
    public partial class ShowcaseList : Page
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
                LiteralMessage.Text = "Error loading projects: " + ex.Message;
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

        // Load project for editing
        protected void btnLoadProjectForEdit_Click(object sender, EventArgs e)
        {
            try
            {
                string projectIdStr = hfEditProjectId.Value;
        
                if (string.IsNullOrEmpty(projectIdStr))
                {
                    LiteralMessage.Text = "No project ID provided.";
                    return;
                }
        
                if (!int.TryParse(projectIdStr, out int projectId))
                {
                    LiteralMessage.Text = "Invalid project ID.";
                    return;
                }

                ShowcaseModel project = GetProjectById(projectId);
                if (project != null)
                {
                    PopulateEditForm(project);
            
                    // Show edit modal - using a more reliable method
                    ScriptManager.RegisterStartupScript(this, GetType(), "showEditModal", 
                        "setTimeout(function() { document.getElementById('editFormModal').style.display = 'block'; }, 100);", true);
                }
                else
                {
                    LiteralMessage.Text = "Project not found with ID: " + projectId;
                    // Clear the hidden field
                    hfEditProjectId.Value = "";
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error loading project: " + ex.Message;
                hfEditProjectId.Value = ""; // Clear on error
            }
        }
        
        // Add new project
        protected void btnAddProject_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateAddForm())
                {
                    ShowcaseModel newProject = new ShowcaseModel
                    {
                        Type = ddlAddType.SelectedValue,
                        Title = txtAddTitle.Text.Trim(),
                        Description = txtAddDescription.Text.Trim(),
                        UrlCoverImage = txtAddCoverImage.Text.Trim(),
                        UrlGithub = txtAddGithub.Text.Trim(),
                        UrlDrive = txtAddDrive.Text.Trim(),
                        UrlYoutube = txtAddYoutube.Text.Trim(),
                        UrlOther = txtAddOther.Text.Trim()
                    };

                    int newId = AddProjectToDatabase(newProject);
                    if (newId > 0)
                    {
                        ClearAddForm();
                        LoadShowcaseData();
                        LiteralMessage.Text = $"Project added successfully! New Project ID: {newId}";

                        // Switch to gallery tab to show the new project
                        ClientScript.RegisterStartupScript(this.GetType(), "switchToGallery",
                            "setTimeout(function() { showTab('gallery'); }, 500);", true);
                    }
                    else
                    {
                        LiteralMessage.Text = "Failed to add project. Please try again.";
                    }
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error adding project: " + ex.Message;
            }
        }

        // Update existing project
        protected void btnUpdateProject_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(hfEditProjectId.Value) && ValidateEditForm())
                {
                    int projectId = int.Parse(hfEditProjectId.Value);

                    ShowcaseModel updatedProject = new ShowcaseModel
                    {
                        Id = projectId,
                        Type = ddlEditType.SelectedValue,
                        Title = txtEditTitle.Text.Trim(),
                        Description = txtEditDescription.Text.Trim(),
                        UrlCoverImage = txtEditCoverImage.Text.Trim(),
                        UrlGithub = txtEditGithub.Text.Trim(),
                        UrlDrive = txtEditDrive.Text.Trim(),
                        UrlYoutube = txtEditYoutube.Text.Trim(),
                        UrlOther = txtEditOther.Text.Trim()
                    };

                    bool success = UpdateProjectInDatabase(updatedProject);
                    if (success)
                    {
                        LoadShowcaseData();
                        LiteralMessage.Text = "Project updated successfully!";

                        // Close modal and refresh
                        ClientScript.RegisterStartupScript(this.GetType(), "closeModalAfterUpdate",
                            "closeEditModal(); setTimeout(function() { window.location.reload(); }, 500);", true);
                    }
                    else
                    {
                        LiteralMessage.Text = "Failed to update project. Please try again.";
                    }
                }
                else
                {
                    LiteralMessage.Text = "Please ensure all required fields are filled.";
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error updating project: " + ex.Message;
            }
        }

        // Delete project
        protected void btnDeleteProject_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(hfEditProjectId.Value))
                {
                    int projectId = int.Parse(hfEditProjectId.Value);
                    bool success = DeleteProjectFromDatabase(projectId);

                    if (success)
                    {
                        LoadShowcaseData();
                        LiteralMessage.Text = "Project deleted successfully!";

                        // Close modal if open and refresh the page
                        ClientScript.RegisterStartupScript(this.GetType(), "afterDelete",
                            "closeEditModal(); setTimeout(function() { window.location.reload(); }, 500);", true);
                    }
                    else
                    {
                        LiteralMessage.Text = "Failed to delete project. Please try again.";
                    }
                }
            }
            catch (Exception ex)
            {
                LiteralMessage.Text = "Error deleting project: " + ex.Message;
            }
        }

        // Helper methods for form validation
        private bool ValidateAddForm()
        {
            if (string.IsNullOrEmpty(ddlAddType.SelectedValue))
            {
                LiteralMessage.Text = "Please select a project type.";
                return false;
            }

            if (string.IsNullOrEmpty(txtAddTitle.Text.Trim()))
            {
                LiteralMessage.Text = "Please enter a project title.";
                return false;
            }

            return true;
        }

        private bool ValidateEditForm()
        {
            if (string.IsNullOrEmpty(ddlEditType.SelectedValue))
            {
                LiteralMessage.Text = "Please select a project type.";
                return false;
            }

            if (string.IsNullOrEmpty(txtEditTitle.Text.Trim()))
            {
                LiteralMessage.Text = "Please enter a project title.";
                return false;
            }

            return true;
        }

        private void PopulateEditForm(ShowcaseModel project)
        {
            // Set dropdown selection
            ddlEditType.SelectedValue = project.Type ?? "";
    
            // Populate text fields with existing values (empty string if null)
            txtEditTitle.Text = project.Title ?? "";
            txtEditDescription.Text = project.Description ?? "";
            txtEditCoverImage.Text = project.UrlCoverImage ?? "";
            txtEditGithub.Text = project.UrlGithub ?? "";
            txtEditDrive.Text = project.UrlDrive ?? "";
            txtEditYoutube.Text = project.UrlYoutube ?? "";
            txtEditOther.Text = project.UrlOther ?? "";
        }

        private void ClearAddForm()
        {
            ddlAddType.SelectedIndex = 0;
            txtAddTitle.Text = "";
            txtAddDescription.Text = "";
            txtAddCoverImage.Text = "";
            txtAddGithub.Text = "";
            txtAddDrive.Text = "";
            txtAddYoutube.Text = "";
            txtAddOther.Text = "";
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

        private ShowcaseModel GetProjectById(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            ShowcaseModel project = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT id, type, title, description, url_cover_image, 
                       url_github, url_drive, url_youtube, url_other 
                       FROM showcase WHERE id = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            project = new ShowcaseModel
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
                        }
                    }
                }
            }

            return project;
        }
        
        private int AddProjectToDatabase(ShowcaseModel project)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO showcase (type, title, description, url_cover_image, 
                               url_github, url_drive, url_youtube, url_other) 
                               VALUES (@type, @title, @description, @coverImage, @github, @drive, @youtube, @other);
                               SELECT SCOPE_IDENTITY();";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    AddProjectParameters(command, project);
                    connection.Open();

                    object result = command.ExecuteScalar();
                    return result != null ? Convert.ToInt32(result) : 0;
                }
            }
        }

        private bool UpdateProjectInDatabase(ShowcaseModel project)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"UPDATE showcase SET type = @type, title = @title, 
                               description = @description, url_cover_image = @coverImage, 
                               url_github = @github, url_drive = @drive, 
                               url_youtube = @youtube, url_other = @other 
                               WHERE id = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    AddProjectParameters(command, project);
                    command.Parameters.AddWithValue("@id", project.Id);

                    connection.Open();
                    int result = command.ExecuteNonQuery();
                    return result > 0;
                }
            }
        }

        private bool DeleteProjectFromDatabase(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM showcase WHERE id = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);
                    connection.Open();

                    int result = command.ExecuteNonQuery();
                    return result > 0;
                }
            }
        }

        private void AddProjectParameters(SqlCommand command, ShowcaseModel project)
        {
            command.Parameters.AddWithValue("@type", project.Type ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@title", project.Title ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@description", project.Description ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@coverImage", project.UrlCoverImage ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@github", project.UrlGithub ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@drive", project.UrlDrive ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@youtube", project.UrlYoutube ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@other", project.UrlOther ?? (object)DBNull.Value);
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