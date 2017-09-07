using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Respati.Web.App.Ojk.Simple.rkp
{
    public partial class Home_hie : System.Web.UI.Page
    {
        protected System.Data.DataTable GetPivotData(string kdUnit)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@KD_UNIT", System.Data.SqlDbType.VarChar, kdUnit);
            return Helper.Helper.ExecuteSp("dbo.GetHirarkiRkpStatus_Group");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RadComboBox1.DataSource = Helper.Helper.GetEselonList();
                RadComboBox1.DataBind();
                RadComboBox1.SelectedIndex = 0;
            }

        }

        protected void RadComboBox1_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGrid1.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!e.IsFromDetailTable)
            {
                System.Data.DataTable dt = GetPivotData(RadComboBox1.SelectedValue);
                RadGrid1.DataSource = dt.Select("KD_PARENT IS NULL");
                ViewState["GRID_DATA"] = dt;
            }
        }

        protected void RadGrid1_DetailTableDataBind(object sender, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
        {
            System.Data.DataTable dt = (System.Data.DataTable)ViewState["GRID_DATA"];
            Telerik.Web.UI.GridDataItem dataItem = (Telerik.Web.UI.GridDataItem)e.DetailTableView.ParentItem;
            string kdInduk = dataItem.GetDataKeyValue("KD_UNIT").ToString();
            e.DetailTableView.DataSource = dt.Select("KD_PARENT = '" + kdInduk + "'");
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
            if (indexLength > 1) rpb.Height = Unit.Pixel(20);

            rpb.ID = "RadProgressBar1";

            return rpb;
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Telerik.Web.UI.GridDataItem item = (Telerik.Web.UI.GridDataItem)e.Item;
                System.Data.DataRowView row = (System.Data.DataRowView)item.DataItem;

                ////item cell 6.Progress bar. Update Progress bar.
                int angka1 = Convert.ToInt32(row.Row["TOTAL_RKP"]);
                int angka2 = Convert.ToInt32(row.Row["TOTAL_EMPLOYEE"]);
                Telerik.Web.UI.RadProgressBar rpb = (Telerik.Web.UI.RadProgressBar)item.Cells[6].FindControl("ProgressBar1");

                if (rpb != null)
                {
                    float persentase = 0;
                    if (angka2 != 0) persentase = ((float)angka1 / (float)angka2) * 100;
                    rpb.Value = persentase;
                    rpb.Label = ((int)persentase).ToString() + "%";
                    int groupClass = (int)System.Math.Floor(persentase / 20) * 20;
                    rpb.CssClass = "ProgressBar" + groupClass.ToString();

                }

                //Telerik.Web.UI.GridItem item = (Telerik.Web.UI.GridItem)e.Item;
                //for (int i = 0; i < item.Cells.Count; i++)
                //{
                //    item.Cells[i].Text = i.ToString() + "-" + item.Cells[i].Text + "-" + item.ItemType.ToString();
                //}
            }
        }
    }
}