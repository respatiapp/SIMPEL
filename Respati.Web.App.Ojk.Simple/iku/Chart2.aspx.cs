using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Respati.Web.App.Ojk.Simple.iku
{
    public partial class Chart2 : System.Web.UI.Page
    {
        private string[] arrClass = new string[] { "btn-danger", "btn-success" };
        protected string iku_label = "";

        protected System.Data.DataTable GetHirarkiIkuStatus(string kdUnit, string kdLevel, int ikuId)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@KD_UNIT", System.Data.SqlDbType.VarChar, kdUnit);
            Helper.Helper.AddParameters("@KD_MAIN_ROOT", System.Data.SqlDbType.VarChar, kdLevel);
            Helper.Helper.AddParameters("@ID_IKU", System.Data.SqlDbType.Int, ikuId);
            return Helper.Helper.ExecuteSp("dbo.GetHirarkiIkuStatus_DetailPegawai");
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

            string chartdepth = System.Configuration.ConfigurationManager.AppSettings["chart_depth_iku"].ToString();
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
            
            //orgChartStatus.MaxDataBindDepth = chart_depth;
            orgChartStatus.EnableDrillDown = true;
            orgChartStatus.GroupColumnCount = 10;

            orgChartStatus.RenderedFields.NodeFields.Add(new Telerik.Web.UI.OrgChartRenderedField() { DataField = "NM_UNIT_ORG" });
            orgChartStatus.RenderedFields.ItemFields.Add(new Telerik.Web.UI.OrgChartRenderedField() { DataField = "NIP" });

            string param = "";
            string src = "";
            string iku = "";
            int ikuid = 0;

            if (Request.QueryString["kd"] != null) param = Request.QueryString["kd"];
            if (Request.QueryString["src"] != null) src = Request.QueryString["src"];
            if (Request.QueryString["id"] != null) 
            { 
                iku = Request.QueryString["id"];
                ikuid = Convert.ToInt32(iku);
            }

            DataTable dt = GetHirarkiIkuStatus(param, src, ikuid);

            try
            {
                DataRow[] drs = dt.Select("IKU_DETAIL IS NOT NULL");
                if (drs.Length > 0) iku_label = drs[0]["IKU_DETAIL"].ToString();
            }
            catch
            {
                iku_label = "";
            }

            try
            {
                orgChartStatus.GroupEnabledBinding.NodeBindingSettings.DataSource = Helper.Helper.GetHirarkiRkpStatus_Unit(param, src);
                orgChartStatus.GroupEnabledBinding.GroupItemBindingSettings.DataSource = dt;
                orgChartStatus.DataBind();
            }
            catch
            {
                Label1.Text = "Data tidak bisa ditampilkan!";
            }
        }

        protected void orgChartStatus_GroupItemDataBound(object sender, Telerik.Web.UI.OrgChartGroupItemDataBoundEventArguments e)
        {
            DataRow dr = ((DataRowView)e.Item.DataItem).Row;
            e.Item.CssClass = arrClass[Convert.ToInt32(dr["STATUS_IKU"])]; //"btn-danger";
        }

        protected void orgChartStatus_NodeDataBound(object sender, Telerik.Web.UI.OrgChartNodeDataBoundEventArguments e)
        {
            DataRow dr = ((DataRowView)e.Node.DataItem).Row;
            string kdUnit = (string)dr["KD_UNIT_MAIN"].ToString();
            if (kdUnit.EndsWith("XX")) e.Node.CssClass = "AnggotaNode";

            //e.Node.RenderedFields[0].Text += dr["KD_UNIT_MAIN"].ToString();
            //KD_UNIT_MAIN

            //e.Node.CssClass = "ABCE";
            //e.Node.DataItem
            //e.Node.RenderedFields[0].
        }
    }
}