using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class SchedulerRunner : System.Web.UI.Page
    {
        protected string ListScheduler = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //ListScheduler = JsonConvert.SerializeObject(GetScheduler());

            string query = string.IsNullOrEmpty(Request.QueryString["auto"]) ? "" : Request.QueryString["auto"];
            if (query == "1")
                Run();
        }

        [WebMethod]
        public static string Run()
        {
            DataTable dt = Helper.Helper.GetSchedule();
            int counter = 0;
            foreach (DataRow dr in dt.Rows)
            {
                string message = "Dear " + dr["NM_PEG"];
                message += "\nNilai RKP kurang dari" + dr["MINIMAL_RKP"];
                MailHelper mail = new MailHelper();
                mail.SendEmail(dr["EMAIL"].ToString(), "", "NILAI RKP " + dr["CURRENT_RKP"], message);
                Helper.Helper.UpdateSettingRun(dr["ID_SETTING"].ToString());
                counter ++;
            }
            return string.Format("Success, mengirim {0} email", counter);
        }


    }
}