using System;
using System.Linq;
using System.Web;
using Telerik.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.Data.Extensions;

namespace Respati.Web.App.Ojk.Simple.Helper
{
    public class GirdHelper
    {

        public enum Orientation
        {
            Lanscape = 0,
            Potrait
        }

        public enum Format
        {
            PDF = 0,
            Word,
            Excel
        }

        public static void OnGridBinding(object sender, GridColumnCreatedEventArgs e)
        {
            e.Column.AutoPostBackOnFilter = true;
            e.Column.CurrentFilterFunction = GridKnownFunction.Contains;
            e.Column.FilterDelay = 5000;
            e.Column.ShowFilterIcon = false;

            e.Column.FilterControlWidth = Unit.Percentage(100);
        }

        public static void SetUpGrid(RadGrid grid)
        {
            // content
            grid.ShowHeader = true;
            grid.MasterTableView.NoMasterRecordsText = "Tidak ada data";
            grid.MasterTableView.NoDetailRecordsText = "Tidak ada data";
            //sorting
            grid.AllowSorting = true;
            grid.HeaderStyle.Font.Bold = true;
            grid.MasterTableView.AllowMultiColumnSorting = true;
            // filtering
            grid.EnableLinqExpressions = false;
            grid.FilterType = GridFilterType.Classic;
            grid.AllowFilteringByColumn = true;
            grid.MasterTableView.AllowFilteringByColumn = true;
            grid.MasterTableView.EnableHeaderContextFilterMenu = false;
            // paging
            grid.AllowPaging = true;
            grid.PagerStyle.PageSizeLabelText = "Banyak baris";
            grid.PagerStyle.PrevPageToolTip = "Halaman sebelum";
            grid.PagerStyle.NextPageToolTip = "Halaman berikut";
            grid.PagerStyle.FirstPageToolTip = "Halaman pertama";
            grid.PagerStyle.LastPageToolTip = "Halaman terakhir";
            grid.PagerStyle.PagerTextFormat = "Menampilkan {3} dari {1} halaman";



        }

        public static void OnGridItemCreated(object sender, GridItemEventArgs e, bool isExport, string format)
        {
            RadGrid grid = (sender as RadGrid);

            if (isExport && e.Item is GridFilteringItem)
                e.Item.Visible = false;

            if (isExport)
            {
                if (format.ToLower() == "pdf")
                    FormatPdfOutput(grid);
                else
                {
                    foreach (GridColumn column in grid.Columns)
                    {
                        column.ItemStyle.Font.Size = FontUnit.Small;
                    }
                }

                var item = e.Item as GridDataItem;

                if (item != null)
                {
                    AlignGridTableCells(item);
                    foreach (TableCell cell in item.Cells)
                    {
                        cell.Style["text-align"] = "left";
                        cell.Style["font-size"] = "9pt";
                    }
                }
                else
                {
                    var gridHeaderItem = e.Item as GridHeaderItem;

                    if (gridHeaderItem != null)
                    {
                        AlignGridTableCells(gridHeaderItem, "center");
                        foreach (TableCell cell in gridHeaderItem.Cells)
                        {
                            cell.Style["font-size"] = "10pt";
                        }
                        

                    }
                    else
                    {
                        var gridFooterItem = e.Item as GridFooterItem;

                        if (gridFooterItem != null)
                        {
                            AlignGridTableCells(gridFooterItem);
                        }
                    }

                }
            }

        }

        private static void FormatPdfOutput(RadGrid radGrid)
        {
            radGrid.ExportSettings.IgnorePaging = true;
            radGrid.ExportSettings.ExportOnlyData = true;
            radGrid.ExportSettings.HideStructureColumns = true;

            double marginWidth = radGrid.ExportSettings.Pdf.PageLeftMargin.Value
                          + radGrid.ExportSettings.Pdf.PageRightMargin.Value;

            double printArea = radGrid.ExportSettings.Pdf.PageWidth.Value - marginWidth;

            //if the print area of the page is smaller than the RadGrid width (total column width),
            //change to percent based widths and evenly break up the columns.
            if (printArea < radGrid.Width.Value)
            {
                var visibleColumnCount = radGrid.Columns.Cast<GridColumn>().Count(column => column.Visible);

                //calculate the percentage to evenly display all the columns
                var tempWidth = 1.0 / (double)visibleColumnCount;

                foreach (GridColumn column in radGrid.Columns)
                {
                    //this is here to ensure the command columns aren't visible
                    if (column.Visible)
                    {
                        column.Visible = column.HeaderText.Length > 0;
                    }

                    column.HeaderStyle.Width = column.Visible
                                       ? Unit.Percentage(tempWidth)
                                       : Unit.Percentage(0);

                    column.HeaderStyle.Wrap = true;
                    column.ShowFilterIcon = false;
                    column.ItemStyle.Font.Size = FontUnit.Small;

                    //if ( column.Visible )
                    //{
                    //  column.HeaderStyle.HorizontalAlign = column as GridNumericColumn == null
                    //                                     ? HorizontalAlign.Left
                    //                                     : HorizontalAlign.Right;           
                    //}
                }
            }
        }
        private static void AlignGridTableCells(GridItem gridItem)
        {
            if (gridItem != null)
            {
                //dynamically set the cell's alignment
                for (int i = 0; i < gridItem.Cells.Count; i++)
                {
                    var cell = gridItem.Cells[i] as GridTableCell;

                    if (cell != null)
                    {
                        //for any value type, but 'char', align-right; otherwise, align-left
                        if (cell.Column.DataType.IsValueType && cell.Column.DataType != typeof(char))
                        {
                            gridItem.Cells[i].Style["text-align"] = "right";
                        }
                        else
                        {
                            gridItem.Cells[i].Style["text-align"] = "left";
                            //gridItem.Cells[i].Style["word-break"] = "break-all";
                            //gridItem.Cells[i].Style["word-warp"] = "break-word";
                        }
                    }
                }
            }
        }

        private static void AlignGridTableCells(GridItem gridItem, string alignment)
        {
            if (gridItem != null)
            {
                //dynamically set the cell's alignment
                for (int i = 0; i < gridItem.Cells.Count; i++)
                {
                    var cell = gridItem.Cells[i] as GridTableCell;

                    if (cell != null)
                    {
                        gridItem.Cells[i].Style["text-align"] = alignment;
                        //gridItem.Cells[i].Style["word-break"] = "break-all";
                        //gridItem.Cells[i].Style["word-warp"] = "break-word";

                    }
                }
            }
        }

        public static void ExportGrid(string format, RadGrid grid, string ReportName, Orientation orientation)
        {
            if (grid.MasterTableView.Items.Count == 0)
                return;
            grid.ExportSettings.FileName = string.Format("{0}_{1}", ReportName, DateTime.Now.ToString("dd_MM_yyyy_hh_mm_ss"));
            grid.ExportSettings.IgnorePaging = true;
            grid.ExportSettings.ExportOnlyData = true;

            switch (format.ToLower())
            {
                case "pdf":
                    //                    ApplyStylesToPdfExport(RadGrid1.MasterTableView);

                    grid.ExportSettings.OpenInNewWindow = true;


                    grid.ExportSettings.Pdf.PageHeight = Unit.Parse("210mm");
                    grid.ExportSettings.Pdf.PageWidth = Unit.Parse("297mm");
                    grid.ExportSettings.Pdf.PageLeftMargin = Unit.Parse("10mm");
                    grid.ExportSettings.Pdf.PageRightMargin = Unit.Parse("10mm");
                    grid.MasterTableView.ExportToPdf();
                    break;
                case "doc":
                    grid.MasterTableView.ExportToWord();
                    break;
                case "excel":
                    grid.MasterTableView.ExportToExcel();
                    break;
                default:
                    break;

            }
        }






        internal static void OnExportCellFormatting(object sender, ExportCellFormattingEventArgs e)
        {
            switch (e.FormattedColumn.UniqueName.ToLower())
            {
                case "nip":
                    e.Cell.Style["mso-number-format"] = @"\@";
                    break;
                case "realisasi":
                    e.Cell.Style["mso-number-format"] = @"0";
                    break;

            }
        }

        internal static void OnGridExporting(object sender, GridExportingArgs e)
        {
            if (e.ExportType == ExportType.Word)
            {
                e.ExportOutput = e.ExportOutput.Replace("<body>", "<body><div class=WordSection1>");
                e.ExportOutput = e.ExportOutput.Replace("</body>", "</div></body>");
            }
        }

        internal static void OnPdfExporting(object sender, GridPdfExportingArgs e, string title)
        {
            e.RawHTML =
                "<div width=\"100%\" style=\"text-align:center;font-size:12px;font-family:Verdana;font-weight:bold;margin-bottom:10px; \">"+ title +"</div>" +
                e.RawHTML;
        }

        public static void OnHTMLExporting(object sender, GridHTMLExportingEventArgs e, HttpResponse response, string title)
        {
            if (response.ContentType.Contains("excel"))
            {
                e.Styles.Append("<!--table @page { mso-page-orientation:landscape;} -->");

                e.XmlOptions = "<xml><x:ExcelWorkbook>" +
                                "<x:ExcelWorksheets><x:ExcelWorksheet><x:WorksheetOptions>" +
                                "<x:Print><x:ValidPrinterInfo/></x:Print>" +
                                "</x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets>" +
                                "</x:ExcelWorkbook></xml>";
            }
            else
            {
                e.Styles.Append("<!-- @page WordSection1 { size: 297mm 210mm; }" +
                                "div.WordSection1 {page:WordSection1;} -->");
            }
            e.Styles.Append("<div width=\"100%\" style=\"text-align:center;font-size:12px;font-family:Verdana;font-weight:bold;margin-bottom:10px; \">"+ title +"</div>");
        }
    }
}