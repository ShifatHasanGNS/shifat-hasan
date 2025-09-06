using System;
using System.Web;
using System.Web.Routing;

namespace shifat_hasan
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // Register routes
            RegisterRoutes(RouteTable.Routes);
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // Redirect root URL to Home page
            var path = Request.Url.AbsolutePath;
            if (path is "/" or "")
            {
                Response.Redirect("~/Pages/Home.aspx", true);
            }
        }

        private static void RegisterRoutes(RouteCollection routes)
        {
            // Add any additional routing here if needed
            // Example: routes.MapPageRoute("Home", "home", "~/Pages/Home.aspx");
        }
    }
}