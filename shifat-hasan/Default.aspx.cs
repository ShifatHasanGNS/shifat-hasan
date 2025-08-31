using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace shifat_hasan.Pages
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mysql"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            MySqlConnection connection = new MySqlConnection(conStr);
            try
            {
                connection.Open();
                Response.Write("<script>alert('Connection Successful');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Connection Failed: " + ex.Message + "');</script>");
            }
            finally
            {
                connection.Close();
            }
        }
    }
}