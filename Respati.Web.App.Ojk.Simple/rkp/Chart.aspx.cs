using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple.rkp
{
    public partial class Chart : System.Web.UI.Page
    {
        private string[] arrClass = new string[] { "btn-danger", "btn-warning", "btn-success" };

        protected System.Data.DataTable GetHirarkiRkpStatus_Unit_NonStaff(string param, string src)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@KD_UNIT", SqlDbType.VarChar, param);
            Helper.Helper.AddParameters("@KD_MAIN_ROOT", SqlDbType.VarChar, src);
            return Helper.Helper.ExecuteSp("dbo.GetHirarkiRkpStatus_DetailUnit_NonStaff");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = "";
            orgChartStatus.GroupEnabledBinding.NodeBindingSettings.DataFieldID = "KD_UNIT_MAIN";
            orgChartStatus.GroupEnabledBinding.NodeBindingSettings.DataFieldParentID = "KD_UNIT_MAIN_INDUK";

            orgChartStatus.GroupEnabledBinding.GroupItemBindingSettings.DataFieldNodeID = "KD_UNIT_MAIN";
            orgChartStatus.GroupEnabledBinding.GroupItemBindingSettings.DataFieldID = "NIP";
            orgChartStatus.GroupEnabledBinding.GroupItemBindingSettings.DataTextField = "NM_PEG";
            orgChartStatus.GroupEnabledBinding.GroupItemBindingSettings.DataImageUrlField = "FOTO";

            string chartdepth = System.Configuration.ConfigurationManager.AppSettings["chart_depth"].ToString();
            if (chartdepth != "0")
            {
                int chart_depth = 2;
                try
                {
                    chart_depth = Convert.ToInt32(chartdepth);
                }
                catch { }

                orgChartStatus.MaxDataBindDepth = chart_depth;
            }
            orgChartStatus.EnableDrillDown = true;
            orgChartStatus.GroupColumnCount = 10;

            orgChartStatus.RenderedFields.NodeFields.Add(new Telerik.Web.UI.OrgChartRenderedField() { DataField = "NM_UNIT_ORG" });
            orgChartStatus.RenderedFields.ItemFields.Add(new Telerik.Web.UI.OrgChartRenderedField() { DataField = "NIP" });

            string param = "";
            string src = "";
            if (Request.QueryString["kd"] != null) param = Request.QueryString["kd"];
            if (Request.QueryString["src"] != null) src = Request.QueryString["src"];

            try
            {
                //orgChartStatus.DataSource = Helper.Helper.GetHirarkiRkpPegawaiStatus(param, src);
                //orgChartStatus.GroupEnabledBinding.NodeBindingSettings.DataSource = Helper.Helper.GetHirarkiRkpStatus_Unit(param, src);

                DataTable dt2 = GetHirarkiRkpStatus_Unit_NonStaff(param, src);

                if (User.IsInRole("MIA"))
                {
                    //MembershipHelper.GetCurrentUser();
                    //var rows = dt2.AsEnumerable().Where(x => x.Field<string>("KD_UNIT_ORG") == Session["User.DeptID"].ToString());
                    //dt2 = !rows.Any() ? null : rows.CopyToDataTable();
                }
                //orgChartStatus.GroupEnabledBinding.NodeBindingSettings.DataSource = GetHirarkiRkpStatus_Unit_NonStaff(param, src);
                orgChartStatus.GroupEnabledBinding.NodeBindingSettings.DataSource = dt2;
                orgChartStatus.GroupEnabledBinding.GroupItemBindingSettings.DataSource = Helper.Helper.GetHirarkiRkpStatus_Pegawai(param, src);
                orgChartStatus.DataBind();
            }
            catch(Exception ex)
            {
                Label1.Text = "Data tidak bisa ditampilkan!";
            }
        }

        protected void orgChartStatus_NodeDataBound(object sender, Telerik.Web.UI.OrgChartNodeDataBoundEventArguments e)
        {
            foreach (Telerik.Web.UI.OrgChartGroupItem item in e.Node.GroupItems)
            {
                DataRow dr = ((DataRowView)item.DataItem).Row;
                item.CssClass = arrClass[Convert.ToInt32(dr["Status"])];
            }
        }

        protected void orgChartStatus_GroupItemDataBound(object sender, Telerik.Web.UI.OrgChartGroupItemDataBoundEventArguments e)
        {
            DataRow dr = ((DataRowView)e.Item.DataItem).Row;
            e.Item.CssClass = arrClass[Convert.ToInt32(dr["Status"])]; //"btn-danger";
        }

        protected void orgChartStatus_NodeDataBound1(object sender, Telerik.Web.UI.OrgChartNodeDataBoundEventArguments e)
        {
            DataRow dr = ((DataRowView)e.Node.DataItem).Row;
            string kdUnit = (string)dr["KD_UNIT_MAIN"].ToString();
            if (kdUnit.EndsWith("XX")) e.Node.CssClass = "AnggotaNode";
        }
    }
}