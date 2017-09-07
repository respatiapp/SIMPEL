using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple.laporan
{
    public partial class DashboardIkuDetail : System.Web.UI.Page
    {
        private bool isExport = false;
        private string format = string.Empty;

        protected System.Data.DataTable GetDashboardIKU()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.GetDashboardIKU_Detail");
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            RadGrid1.ExportCellFormatting += new EventHandler<ExportCellFormattingEventArgs>(Helper.GirdHelper.OnExportCellFormatting);
            RadGrid1.HTMLExporting += new EventHandler<GridHTMLExportingEventArgs>
                ((send, ev) =>
                    Helper.GirdHelper.OnHTMLExporting(send, ev, Response,
                    "Dashboard Cascading IKU<br/>IKU Yang Belum Diturunkan"));
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Helper.GirdHelper.SetUpGrid(RadGrid1);
                Helper.Helper.PopulateCmbPeriode(rdPeriode);
                
                RadGrid1.GridExporting += new OnGridExportingEventHandler(Helper.GirdHelper.OnGridExporting);
                RadGrid1.ExportCellFormatting += new EventHandler<ExportCellFormattingEventArgs>(Helper.GirdHelper.OnExportCellFormatting);
            }
        }
        protected void rdPeriode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGrid1.Rebind();
        }

        protected void grid_binding(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = GetDashboardIKU();
            if (User.IsInRole("MIA"))
            {
                MembershipHelper.GetCurrentUser();
                var rows = dt.AsEnumerable()
                    .Where(x => x.Field<string>("Unit") == Session["User.Dept"].ToString());
                dt = !rows.Any() ? null : rows.CopyToDataTable();
            }
            RadGrid1.DataSource = dt;

            //RadGrid1.DataSource = GetDashboardIKU();
            //RadGrid1.DataBind();

        }
        protected void on_binding(object sender, GridColumnCreatedEventArgs e)
        {
            Helper.GirdHelper.OnGridBinding(sender, e);
        }

        protected void on_itemcreated(object sender, GridItemEventArgs e)
        {
            Helper.GirdHelper.OnGridItemCreated(sender, e, isExport, format);
        }
        // event handler exporting;
        protected void Export(object sender, EventArgs e)
        {
            isExport = true;
            format = (sender as HtmlButton).Attributes["Value"];

            Helper.GirdHelper.ExportGrid(format, RadGrid1, "Laporan IKU", Helper.GirdHelper.Orientation.Potrait);
        }


        protected void RadGrid1_OnHTMLExporting(object sender, GridHTMLExportingEventArgs e)
        {
           // Helper.GirdHelper.OnHTMLExporting(sender,e,Response, "Dashboard Cascading IKU");

        }
        protected void OnExportCellFormatting(object sender, ExportCellFormattingEventArgs e)
        {
            Helper.GirdHelper.OnExportCellFormatting(sender, e);
        }
    }
}