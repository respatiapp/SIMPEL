using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class HistoriNotifikasi : System.Web.UI.Page
    {
        private static DataTable GetMailScheduleHistory()
        {

            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("SP_GetMailScheduleHistory");

        }

        private static DataTable GetMailScheduleHistoryDetail(int id)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@HISTORY_ID", SqlDbType.Int, id);
            return Helper.Helper.ExecuteSp("SP_GetmailScheduleHirtoryDetail");

        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!e.IsFromDetailTable)
            {
                RadGrid1.DataSource = GetMailScheduleHistory();
            }


        }

        protected void RadGrid1_DetailTableDataBind(object sender, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
        {
            Telerik.Web.UI.GridDataItem dataItem = (Telerik.Web.UI.GridDataItem)e.DetailTableView.ParentItem;
            int id = int.Parse(dataItem.GetDataKeyValue("ID").ToString());

            e.DetailTableView.DataSource = GetMailScheduleHistoryDetail(id);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                List<string> allowedList = ConfigurationManager.AppSettings["UsermanagementAllowedList"].Split(';').Select(x => x.Trim().ToLower()).ToList();
                if (!Roles.GetRolesForUser(User.Identity.Name)
                   .Where(x => allowedList.Contains(x.ToLower())).ToList().Any() && !allowedList.Contains("*"))
                    Response.Redirect("AccessDenied.aspx");

                Helper.GirdHelper.SetUpGrid(RadGrid1);
            }
        }
    }
}