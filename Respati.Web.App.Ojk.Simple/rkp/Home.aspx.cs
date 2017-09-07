using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple.rkp
{
    public partial class HomeTree : System.Web.UI.Page
    {
        protected System.Data.DataTable GetPivotData(string kdUnit)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@KD_UNIT", System.Data.SqlDbType.VarChar, kdUnit);
            if (rdPeriode.SelectedValue != "")
                Helper.Helper.AddParameters("@PERIOD_ID", System.Data.SqlDbType.NVarChar, rdPeriode.SelectedValue);

            return Helper.Helper.ExecuteSp("dbo.GetHirarkiRkpStatus_Group");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable dt = Helper.Helper.GetEselonList();
                if (User.IsInRole("MIA"))
                {
                    MembershipHelper.GetCurrentUser();
                    DataTable parentID = Helper.Helper.GetUserParentDepartemen(User.Identity.Name);
                    var rows =
                        dt.AsEnumerable().Cast<DataRow>().Where(x =>
                            x.Field<string>("KD_UNIT_ORG") == parentID.Rows[0]["KD_UNIT_ORG"].ToString());
                    dt = !rows.Any() ? null : rows.CopyToDataTable();
                }

                #region refactored
                /*
                RadComboBox1.DataSource = dt;

                //RadComboBox1.DataSource = Helper.Helper.GetEselonList();
                RadComboBox1.AllowCustomText = true;
                RadComboBox1.MarkFirstMatch = true;
                RadComboBox1.Filter = RadComboBoxFilter.Contains;
                RadComboBox1.EmptyMessage = "[Pilih Bidang]";
                RadComboBox1.SelectedIndex = 0;
                RadComboBox1.DataBind();
                 */
                #endregion

                Helper.Helper.PopuplateCombobox(RadComboBox1, dt, "NM_UNIT_ORG", "KD_UNIT_ORG", "[Pilih Bidang]");
                Helper.Helper.PopulateCmbPeriode(rdPeriode);
            }
        }

        protected void RadComboBox1_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadTreeList1.Rebind();
        }

        protected void rdPeriode_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadTreeList1.Rebind();
        }

        protected void RadTreeList1_NeedDataSource(object sender, Telerik.Web.UI.TreeListNeedDataSourceEventArgs e)
        {
            DataTable dt = GetPivotData(RadComboBox1.SelectedValue);

            //RadTreeList1.DataSource = GetPivotData(RadComboBox1.SelectedValue);

            if (User.IsInRole("MIA"))
            {
                MembershipHelper.GetCurrentUser();

                var rows =
                    dt.AsEnumerable().Cast<DataRow>().Where(x =>
                        x.Field<string>("KD_UNIT") == Session["User.DeptID"].ToString() || 
                        x.Field<string>("KD_PARENT") == Session["User.DeptID"].ToString()
                    );

                foreach (DataRow row in rows)
                {
                    if (row["KD_UNIT"].ToString() == Session["User.DeptID"].ToString())
                    {
                        row["KD_PARENT"] = "";
                    }

                }

                dt = !rows.Any() ? null : rows.CopyToDataTable();
            }

            RadTreeList1.DataSource = dt;

        }

        protected void RadTreeList1_ItemDataBound(object sender, Telerik.Web.UI.TreeListItemDataBoundEventArgs e)
        {
            if (e.Item is Telerik.Web.UI.TreeListDataItem)
            {
                Telerik.Web.UI.TreeListDataItem item = (Telerik.Web.UI.TreeListDataItem)e.Item;
                System.Data.DataRowView row = (System.Data.DataRowView)item.DataItem;

                string cssClass = "";
                int width = 160;
                if (row.Row["LVL_UNIT"].ToString() == "LV3") { cssClass = "item-level2"; width = 180; }

                if (row.Row["LVL_UNIT"].ToString() == "LV2" || row.Row["KD_PARENT"] == "") { cssClass = "item-level1"; width = 200; }
                if (cssClass != "") item.CssClass += cssClass;

                Telerik.Web.UI.RadProgressBar rpb = (Telerik.Web.UI.RadProgressBar)item["PROGRESSBAR"].FindControl("ProgressBar1");
                if (rpb != null)
                {
                    int angka1 = Convert.ToInt32(row.Row["TOTAL_RKP"]);
                    int angka2 = Convert.ToInt32(row.Row["TOTAL_EMPLOYEE"]);

                    float persentase = 0;
                    if (angka2 != 0) persentase = ((float)angka1 / (float)angka2) * 100;

                    rpb.Value = persentase;
                    rpb.Label = ((int)persentase).ToString() + "%";
                    int groupClass = (int)System.Math.Floor(persentase / 20) * 20;
                    rpb.CssClass = "ProgressBar" + groupClass.ToString();
                    rpb.Width = Unit.Pixel(width);
                }

            }
        }
    }
}