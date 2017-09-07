using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Respati.Web.App.Ojk.Simple.Helper;
using System.Data;

namespace Respati.Web.App.Ojk.Simple.laporan
{
    public partial class DashboardRkpDetail : System.Web.UI.Page
    {
        private bool isExport = false;
        private string format = string.Empty;

        protected System.Data.DataTable GetDashboardRKP()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.GetDashboardRKP_Detail");
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            RadGrid1.ExportCellFormatting += new EventHandler<ExportCellFormattingEventArgs>(Helper.GirdHelper.OnExportCellFormatting);
            RadGrid1.HTMLExporting += new EventHandler<GridHTMLExportingEventArgs>
                ((send, ev) =>
                    Helper.GirdHelper.OnHTMLExporting(send, ev, Response,
                    "Dashboard Cascading IKU<br/>Pegawai Yang Belum Mengambil RKP"));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Helper.GirdHelper.SetUpGrid(RadGrid1);
                Helper.Helper.PopulateCmbPeriode(rdPeriode);

            }
        }
        protected void grid_binding(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = GetDashboardRKP();
            if (User.IsInRole("MIA"))
            {
                MembershipHelper.GetCurrentUser();
                var rows = dt.AsEnumerable()
                    .Where(x => x.Field<string>("Unit") == Session["User.Dept"].ToString());
                dt = !rows.Any() ? null : rows.CopyToDataTable();
            }
            RadGrid1.DataSource = dt;

        }
        protected void rdPeriode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGrid1.Rebind();
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

            Helper.GirdHelper.ExportGrid(format, RadGrid1, "Pegawai Yang Belum Mengambil RKP", Helper.GirdHelper.Orientation.Potrait);
        }

    }
}