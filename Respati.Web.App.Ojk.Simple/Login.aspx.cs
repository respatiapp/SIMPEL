using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Services;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class LoginNew : System.Web.UI.Page
    {
        protected string PreviousUrl;
        protected void Page_Load(object sender, EventArgs e)
        {
            PreviousUrl = string.IsNullOrEmpty(Request.QueryString["ReturnURL"])
                ? "default.aspx"
                : Request.QueryString["ReturnURL"];

        }
        [WebMethod]
        public static string LoginMethod(string username, string password)
        {

            if (MembershipHelper.Login(username, password))
                return "";
            else
                return "fail";
        }
    }
}