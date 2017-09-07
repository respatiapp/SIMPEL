using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple.Report
{
    public partial class ReportIku : System.Web.UI.Page
    {
        private bool isExport = false;
        private string format = string.Empty;
        protected System.Data.DataSet GetLaporanIku(string pmf_id)
        {
            Helper.Helper.ClearParameters();
            if (!string.IsNullOrEmpty(pmf_id) )
            Helper.Helper.AddParameters("@PERIODE_ID", SqlDbType.Int, int.Parse(pmf_id));
            return Helper.Helper.ExecuteSpReturnDataset("dbo.ReportIKU");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Helper.GirdHelper.SetUpGrid(RadGrid1);

                rdPeriode.DataSource = GetLaporanIku("").Tables[1];
                rdPeriode.AllowCustomText = true;
                rdPeriode.DataValueField = "PFM_ID";
                rdPeriode.DataTextField = "PERIODE";
                rdPeriode.MarkFirstMatch = true;
                rdPeriode.Filter = RadComboBoxFilter.Contains;
                rdPeriode.DataBind();

            }
        }

        // method for sorting behaviour;
        protected void onGridSort(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = e.SortExpression;
            sortExpr.SortOrder = GridSortOrder.Ascending;

            e.Item.OwnerTableView.SortExpressions.AddSortExpression(sortExpr);
        }


        protected void grid_binding(object sender, GridNeedDataSourceEventArgs e)
        {
            string pfm_id = rdPeriode.SelectedValue;

            DataTable dt = GetLaporanIku(pfm_id).Tables[0];

            if (User.IsInRole("MIA"))
            {
                MembershipHelper.GetCurrentUser();
                if (dt != null)
                {
                    var rows = dt.AsEnumerable().Cast<DataRow>().Where(x =>
                        x.Field<string>("Nama Satuan Kerja") == Session["User.Dept"].ToString());
                    dt = !rows.Any() ? null : rows.CopyToDataTable();
                }
            }
            RadGrid1.DataSource = dt;


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

        protected void rdPeriode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            grid_binding(null, null);
            RadGrid1.Rebind();
        }


        protected void RadGrid1_OnHTMLExporting(object sender, GridHTMLExportingEventArgs e)
        {
            Helper.GirdHelper.OnHTMLExporting(sender, e , Response, "Laporan Indikator Kinerja Individu");
        }

        protected void RadGrid1_OnPdfExporting(object sender, GridPdfExportingArgs e)
        {
            Helper.GirdHelper.OnPdfExporting(sender, e, "Laporan Indikator Kinerja Individu");
        }

        protected void RadGrid1_OnGridExporting(object sender, GridExportingArgs e)
        {

            Helper.GirdHelper.OnGridExporting(sender, e);

        }

        protected void RadGrid1_OnExportCellFormatting(object sender, ExportCellFormattingEventArgs e)
        {
            Helper.GirdHelper.OnExportCellFormatting(sender, e);
        }
    }
}