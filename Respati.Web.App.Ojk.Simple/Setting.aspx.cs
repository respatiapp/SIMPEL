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
    public partial class Setting : System.Web.UI.Page
    {
        protected string Scheduler;
        protected string ListSetting;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
                Scheduler = JsonConvert.SerializeObject(Helper.Helper.GetSetting(Request.QueryString["id"]));
            else 
                Scheduler = JsonConvert.SerializeObject(new List<string>());

            ListSetting = JsonConvert.SerializeObject(Helper.Helper.GetAllSetting());
            if (!Page.IsPostBack)
            {

                BindRadComboBox();
            }
            BindRadGrid("");

        }
        private void BindRadComboBox()
        {
        }

        private void BindRadGrid(string param)
        {
            //RadGrid1.DataSource = Helper.MembershipHelper.GetUserInRoles(param);
            RadGrid1.DataSource = Helper.Helper.GetAllSetting();
            RadGrid1.DataBind();
        }

        protected void RadComboBox1_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        [WebMethod]
        public static string Save(string data)
        {

            try
            {
                Scheduler scheduler = JsonConvert.DeserializeObject<Scheduler>(data);
                scheduler.created_by = MembershipHelper.GetCurrentUser().UserName;
                DataTable dt = Helper.Helper.InsertSetting(scheduler);
                return JsonConvert.SerializeObject( 
                      new JsonResult() { isSuccess = true, message = dt.Rows[0]["id"].ToString()
                    });
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new JsonResult() {isSuccess = false, message = ex.ToString()});
            }
        }

        [WebMethod]
        public static string GetSetting(string id)
        {
            try
            {
                DataTable dt = Helper.Helper.GetSetting(id);
                return JsonConvert.SerializeObject(dt);
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new JsonResult() { isSuccess = false, message = ex.ToString() });

            }
        }

        [WebMethod]
        public static string Remove(string id)
        {
            try
            {
                Helper.Helper.RemoveSetting(id);
                return JsonConvert.SerializeObject(new JsonResult() {isSuccess = true, message = ""});
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new JsonResult() { isSuccess = false, message = ex.ToString() });
            }
        }

    }

    
    public class Scheduler
    {
        public string SettingID { get; set; }
        public string NamaSetting { get; set; }
        public string Interval { get; set; }
        public string IntervalType { get; set; }
        public bool IsDirektur { get; set; }
        public bool IsKepalaDepartement { get; set; }
        public bool IsDeputyDirektur { get; set; }
        public bool IsKaBag { get; set; }
        public bool IsActive { get; set; }
        public string MinimalRKP { get; set; }
        public string created_by { get; set; }
        public string created_date { get; set; }
        public string updated_by { get; set; }
        public string updated_time { get; set; }
    }

    public class JsonResult
    {
        public bool isSuccess { get; set; }
        public string message { get; set; }
    }

}