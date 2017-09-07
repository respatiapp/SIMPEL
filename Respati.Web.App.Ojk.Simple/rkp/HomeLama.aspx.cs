using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Respati.Web.App.Ojk.Simple.rkp
{
    public partial class Home : System.Web.UI.Page
    {
        private void BindRadComboBox()
        {
            RadComboBox1.DataSource = Helper.Helper.GetEselonList();
            RadComboBox1.DataBind();
        }

        private void BindRadGrid(string param)
        {
            RadGrid1.Columns[0].Visible = false;
            RadGrid1.DataSource = Helper.Helper.GetHirarkiStatus(param);
            RadGrid1.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindRadComboBox();
            }

            //BindRadGrid(RadComboBox1.SelectedValue);
        }

        protected void RadComboBox1_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            BindRadGrid(RadComboBox1.SelectedValue);
        }

        protected Telerik.Web.UI.RadProgressBar CreateProgressBar(int angka1, int angka2, int indexLength)
        {
            float persentase = 0;
            if (angka2 != 0) persentase = ((float)angka1 / (float)angka2) * 100;

            Telerik.Web.UI.RadProgressBar rpb = new Telerik.Web.UI.RadProgressBar();
            rpb.Value = persentase;
            //rpb.Label = angka1.ToString() + "/" + angka2.ToString();
            rpb.Label = ((int)persentase).ToString() + "%";

            int groupClass = (int)System.Math.Floor(persentase / 20) * 20;
            rpb.CssClass = "ProgressBar" + groupClass.ToString();

            rpb.Width = (indexLength > 1) ? Unit.Pixel(160) : Unit.Pixel(200);
            if (indexLength < 0) rpb.Width = Unit.Pixel(120);
            if (indexLength != 1) rpb.Height = Unit.Pixel(20);

            rpb.ID = "RadProgressBar1";

            return rpb;
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is Telerik.Web.UI.GridGroupHeaderItem)
            {
                Telerik.Web.UI.GridGroupHeaderItem hitem = (Telerik.Web.UI.GridGroupHeaderItem)e.Item;

                System.Data.DataRowView row = (System.Data.DataRowView)hitem.DataItem;
                if (row.Row[0].ToString() == "") hitem.Display = false;
                hitem.CssClass += (hitem.GroupIndex.Length > 1) ? "rgGroupHeader item-level2" : "rgGroupHeader item-level1";

                Telerik.Web.UI.GridTableCell curCell = (Telerik.Web.UI.GridTableCell)hitem.DataCell;
                hitem.Cells.Remove(curCell);

                Telerik.Web.UI.GridTableCell newCell = new Telerik.Web.UI.GridTableCell();
                newCell.ColumnSpan = hitem.DataCell.ColumnSpan - 2;  // - 4;
                newCell.Text = row.Row[0].ToString(); // +"-" + hitem.GroupIndex;
                hitem.Cells.Add(newCell);

                int angka1 = Convert.ToInt32(row.Row[1]);
                int angka2 = Convert.ToInt32(row.Row[2]);

                newCell = new Telerik.Web.UI.GridTableCell();
                newCell.Width = Unit.Pixel(220);
                newCell.Controls.Add(CreateProgressBar(angka1, angka2, hitem.GroupIndex.Length));
                hitem.Cells.Add(newCell);

                string level = (hitem.GroupIndex.Length > 1) ? "LV3" : "LV2";

                string strbutton = "";
                strbutton += "<button type='button' data-root='" + row.Row[3].ToString() + "' data-kd-root='" + level + "'";
                strbutton += "class='btnviewchart btn btn-default' data-toggle='tooltip' data-placement='top' title='Lihat hirarki'>";
                strbutton += "<span class='glyphicon glyphicon-zoom-in' aria-hidden='true'></span>";
                strbutton += "</button>";

                newCell = new Telerik.Web.UI.GridTableCell();
                newCell.Width = Unit.Pixel(30);
                newCell.Text = strbutton;
                hitem.Cells.Add(newCell);

            }

            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Telerik.Web.UI.GridDataItem item = (Telerik.Web.UI.GridDataItem)e.Item;
                System.Data.DataRowView row = (System.Data.DataRowView)item.DataItem;

                item.Display = !(row.Row["NM_ROOT3"].ToString() == "" || row.Row["NM_ROOT4"].ToString() == "");
                item.Cells[5].Text = "";
                item.Cells[5].Width = Unit.Pixel(20);
                //item cell 12. button
                item.Cells[12].Width = Unit.Pixel(30);

                //item cell 9. Ganti kolom persentase dgn Progress bar.
                int angka1 = Convert.ToInt32(row.Row["TOTAL_RKP"]);
                int angka2 = Convert.ToInt32(row.Row["TOTAL_EMPLOYEE"]);
                item.Cells[9].Text = "";
                item.Cells[9].Width = Unit.Pixel(220);
                item.Cells[9].Controls.Add(CreateProgressBar(angka1, angka2, -1));

            }

            //if (e.Item is Telerik.Web.UI.GridGroupHeaderItem || e.Item is Telerik.Web.UI.GridDataItem)
            //{
            //    Telerik.Web.UI.GridItem item = (Telerik.Web.UI.GridItem)e.Item;
            //    for (int i = 0; i < item.Cells.Count; i++)
            //    {
            //        item.Cells[i].Text = i.ToString() + "-" + item.Cells[i].Text;
            //    }
            //}
        }

        protected void RadGrid1_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            //if (e.Item is Telerik.Web.UI.GridGroupHeaderItem)
            //{
            //    Telerik.Web.UI.GridGroupHeaderItem hitem = (Telerik.Web.UI.GridGroupHeaderItem)e.Item;

            //    if (hitem.DataItem != null)
            //    {
            //        System.Data.DataRowView row = (System.Data.DataRowView)hitem.DataItem;
            //        if (row.Row[0].ToString() == "") hitem.Display = false;
            //        hitem.CssClass += (hitem.GroupIndex.Length > 1) ? "rgGroupHeader item-level2" : "rgGroupHeader item-level1";

            //        Telerik.Web.UI.GridTableCell curCell = (Telerik.Web.UI.GridTableCell)hitem.DataCell;
            //        hitem.Cells.Remove(curCell);

            //        Telerik.Web.UI.GridTableCell newCell = new Telerik.Web.UI.GridTableCell();
            //        newCell.ColumnSpan = hitem.DataCell.ColumnSpan - 2;  // - 4;
            //        newCell.Text = row.Row[0].ToString(); // +"-" + hitem.GroupIndex;
            //        hitem.Cells.Add(newCell);

            //        int angka1 = Convert.ToInt32(row.Row[1]);
            //        int angka2 = Convert.ToInt32(row.Row[2]);

            //        newCell = new Telerik.Web.UI.GridTableCell();
            //        newCell.Width = Unit.Pixel(220);
            //        newCell.Controls.Add(CreateProgressBar(angka1, angka2, hitem.GroupIndex.Length));
            //        hitem.Cells.Add(newCell);

            //        string level = (hitem.GroupIndex.Length > 1) ? "LV3" : "LV2";

            //        string strbutton = "";
            //        strbutton += "<button type='button' data-root='" + row.Row[3].ToString() + "' data-kd-root='" + level + "'";
            //        strbutton += "class='btnviewchart btn btn-default' data-toggle='tooltip' data-placement='top' title='Lihat hirarki'>";
            //        strbutton += "<span class='glyphicon glyphicon-zoom-in' aria-hidden='true'></span>";
            //        strbutton += "</button>";

            //        newCell = new Telerik.Web.UI.GridTableCell();
            //        newCell.Width = Unit.Pixel(30);
            //        newCell.Text = strbutton;
            //        hitem.Cells.Add(newCell);
            //    }
            //}

            //if (e.Item is Telerik.Web.UI.GridDataItem)
            //{
            //    Telerik.Web.UI.GridDataItem item = (Telerik.Web.UI.GridDataItem)e.Item;
            //    item.Cells.Add(new TableCell() { Text = "test" });
            //}
        }
    }
}