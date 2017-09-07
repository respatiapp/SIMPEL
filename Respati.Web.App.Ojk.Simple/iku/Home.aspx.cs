using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Respati.Web.App.Ojk.Simple.Helper;
using Respati.Web.App.Ojk.Simple.rkp;
using Telerik.Web.UI;

namespace Respati.Web.App.Ojk.Simple.iku
{

    public partial class home : System.Web.UI.Page
    {
        private string format = string.Empty;
        private System.Data.DataSet SearchIKU(string deptName, string ikuName)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@DEPT_TEXT", System.Data.SqlDbType.VarChar, deptName);
            Helper.Helper.AddParameters("@IKU_TEXT", System.Data.SqlDbType.VarChar, ikuName);
            if (!string.IsNullOrEmpty(rdPeriode.SelectedValue))
            Helper.Helper.AddParameters("@PERIODE_ID", SqlDbType.Int, rdPeriode.SelectedValue);
            //return Helper.Helper.ExecuteSp("dbo.SearchIKU");
            return Helper.Helper.ExecuteSpReturnDataset("dbo.SearchIKU");
        }

        private System.Data.DataSet UnitKerjaList()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSpReturnDataset("dbo.GetSatkerIkuList");
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                #region refactored
                //DataTable dtDept = UnitKerjaList().Tables[0];
                //if (User.IsInRole("MIA"))
                //{
                //    MembershipHelper.GetCurrentUser();
                //    var rows = dtDept.Select("NAMA_SATKER = '" + Session["User.Dept"].ToString() + "'");
                //    dtDept = !rows.Any() ? null : rows.CopyToDataTable();
                //}
              
                //rdcmbDept.DataSource = dtDept;
                //rdcmbDept.AllowCustomText = true;
                //rdcmbDept.DataValueField = "NAMA_SATKER";
                //rdcmbDept.DataTextField = "NAMA_SATKER";
                //rdcmbDept.MarkFirstMatch = true;
                //rdcmbDept.Filter = RadComboBoxFilter.Contains;

                //rdcmbDept.DataBind();


                //rdcmbIKU.DataSource = UnitKerjaList().Tables[1];
                //rdcmbIKU.AllowCustomText = true;
                //rdcmbIKU.MarkFirstMatch = true;
                //rdcmbIKU.DataValueField = "IKU_DESKRIPSI";
                //rdcmbIKU.DataTextField = "IKU_DESKRIPSI";
                //rdcmbIKU.Filter = RadComboBoxFilter.Contains;
                //rdcmbIKU.DataBind();
                #endregion

                DataTable dtDept = MembershipHelper.FilterMia(UnitKerjaList().Tables[0], "NAMA_SATKER", "User.Dept");

                Helper.Helper.PopuplateCombobox(rdcmbDept, dtDept, "NAMA_SATKER", "NAMA_SATKER", "[Pilih satuan kerja]");
                Helper.Helper.PopuplateCombobox(rdcmbIKU, UnitKerjaList().Tables[1], "IKU_DESKRIPSI", "IKU_DESKRIPSI", "[Pilih IKU]");

                Helper.Helper.PopulateCmbPeriode(rdPeriode);

            }
            Helper.GirdHelper.SetUpGrid(RadGrid1);


        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            //RadGrid1.DataSource = ds.Tables[0];
            //RadGrid1.DataBind();
            RadGrid1.Rebind();
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (!e.IsFromDetailTable && Page.IsPostBack)
            {
                //                string deptName = rdtextDept.Text;
                //                string ikuName = rdtextIku.Text;

                string deptName = rdcmbDept.SelectedValue;
                string ikuName = rdcmbIKU.SelectedValue;

                System.Data.DataSet ds = SearchIKU(deptName, ikuName.Trim());

                ViewState["DATA.RESULT"] = ds;

                #region refactored
                /*
                DataTable dt = ds.Tables[0];

                if (User.IsInRole("MIA"))
                {
                    MembershipHelper.GetCurrentUser();
                    if (dt.Rows.Count > 0)
                    {
                        var rows = dt.AsEnumerable()
                            .Where(x => x.Field<string>("NAMA_SATKER") == Session["User.Dept"].ToString());
                        dt = !rows.Any() ? null : rows.CopyToDataTable();
                    }
                }
                */
                #endregion

                DataTable dt = MembershipHelper.FilterMia(ds.Tables[0], "NAMA_SATKER", "User.Dept");
                RadGrid1.DataSource = dt;


                //RadGrid1.DataSource = ds.Tables[0];
            }

        }

        protected void RadGrid1_DetailTableDataBind(object sender, Telerik.Web.UI.GridDetailTableDataBindEventArgs e)
        {
            System.Data.DataSet ds = (System.Data.DataSet)ViewState["DATA.RESULT"];
            Telerik.Web.UI.GridDataItem dataItem = (Telerik.Web.UI.GridDataItem)e.DetailTableView.ParentItem;
            string kdInduk = dataItem.GetDataKeyValue("ID_IKU").ToString();

            DataTable dt = ds.Tables[1].Select("ID_IKU = " + kdInduk).CopyToDataTable();

            e.DetailTableView.DataSource = dt;



        }
        protected void rdPeriode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadGrid1.Rebind();
        }


        [WebMethod]
        public static string GetIKUJSON(string nama_dept)
        {
            return JsonConvert.SerializeObject(Helper.Helper.GetIKUList(nama_dept));
        }

        protected void RadGrid1_OnItemCreated(object sender, GridItemEventArgs e)
        {
            Helper.GirdHelper.OnGridItemCreated(sender, e, false, format);
            
        }

        protected void RadGrid1_OnColumnCreated(object sender, GridColumnCreatedEventArgs e)
        {
            Helper.GirdHelper.OnGridBinding(sender,e);

        }
    }
}