using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Respati.Web.App.Ojk.Simple
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (Context.Session != null && Context.Session.IsNewSession)
            {
                string sCookieHeader = Request.Headers["Cookie"];
                if (null != sCookieHeader && sCookieHeader.IndexOf("ASP.NET_SessionId") >= 0)
                    Response.Redirect("~/SessionExpired.aspx");
            }
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}