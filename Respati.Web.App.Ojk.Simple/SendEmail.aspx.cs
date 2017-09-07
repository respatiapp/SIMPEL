using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class SendEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string SendEmailMethod(string to, string subject, string message)
        {
            try
            {
                MailHelper mail = new MailHelper();
                mail.SendEmail(to, "", subject, message);
                return "OK";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }
    }
}