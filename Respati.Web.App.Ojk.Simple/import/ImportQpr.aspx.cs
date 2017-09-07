using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class ImportQpr : System.Web.UI.Page
    {
        /*
        [System.Web.Services.WebMethod]
        public static void ResetPage()
        {
            HttpContext.Current.Session["QPR.Model.ID"] = null;
            HttpContext.Current.Session["QPR.Period.ID"] = null;
            HttpContext.Current.Session["QPR.IKU"] = null;
        }
         * */

        protected System.Data.DataSet GetLaporanIku(string pmf_id)
        {
            Helper.Helper.ClearParameters();
            if (!string.IsNullOrEmpty(pmf_id))
                Helper.Helper.AddParameters("@PERIODE_ID", SqlDbType.Int, int.Parse(pmf_id));
            return Helper.Helper.ExecuteSpReturnDataset("dbo.ReportIKU");
        }

        protected System.Data.DataTable GetQprModel()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.GetQprModelList");
        }

        protected System.Data.DataTable GetQprPeriod(int modelId)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@MOD_ID", System.Data.SqlDbType.Int, modelId);
            return Helper.Helper.ExecuteSp("dbo.GetQprPeriodList");
        }

        protected System.Data.DataTable GetQprIku(int modelId, int periodId)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@MOD_ID", System.Data.SqlDbType.Int, modelId);
            Helper.Helper.AddParameters("@PERIOD_ID", System.Data.SqlDbType.Int, periodId);
            return Helper.Helper.ExecuteSp("dbo.GetQprIkuList");
        }

        protected System.Data.DataTable GetUnitList()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.GetUnitNonBagian");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                radComboUnit.DataSource = GetUnitList();
                radComboUnit.DataTextField = "NM_UNIT_ORG";
                radComboUnit.DataValueField = "KD_UNIT_ORG";
                //radComboUnit.AllowCustomText = true;
                radComboUnit.Filter = Telerik.Web.UI.RadComboBoxFilter.Contains;
                radComboUnit.DataBind();

                radComboModel.DataSource = GetQprModel();
                radComboModel.DataTextField = "MOD_NAME";
                radComboModel.DataValueField = "MOD_ID";
                radComboModel.DataBind();
                radComboModel.SelectedIndex = 0;

                radComboHrisPeriod.DataSource = GetLaporanIku("").Tables[1];
                radComboHrisPeriod.DataValueField = "PFM_ID";
                radComboHrisPeriod.DataTextField = "PERIODE";
                radComboHrisPeriod.DataBind();
                radComboHrisPeriod.SelectedIndex = 0;
                Session["HRIS.Period.ID"] = radComboHrisPeriod.SelectedValue;

                if (Session["QPR.Model.ID"] != null)
                {
                    radComboModel.SelectedValue = (string)Session["QPR.Model.ID"];
                    radComboModel_SelectedIndexChanged(null, null);
                }

                Helper.GirdHelper.SetUpGrid(RadGrid1);
                Helper.GirdHelper.SetUpGrid(RadGrid2);

            }

            if (Page.IsPostBack)
            {
                string ok = hKode.Value;
                if (ok != "")
                {
                    string prevKode = hPrevKdUnit.Value;
                    string newKode = radComboUnit.SelectedValue;
                    string newName = radComboUnit.SelectedItem.Text;

                    if (prevKode != newKode)
                    {
                        DataTable dt = (DataTable)Session["QPR.IKU"];

                        DataRow[] drs = dt.Select("MEA_ID = " + ok);
                        foreach (DataRow dr in drs)
                        {
                            dr["KODE_SATKER"] = newKode;
                            dr["NAMA_UNIT"] = newName;
                        }

                        dt.AcceptChanges();
                        RebindGrids(dt);
                        //Session["QPR.IKU"] = dt;
                        //RadGrid1.Rebind();

                        //DataView view = new DataView(dt);
                        ////view.RowFilter = "KODE_SATKER = ''";
                        //Session["QPR.MAP"] = view.ToTable(true, "MEA_ID", "NAMA_SATKER", "KODE_SATKER", "NAMA_UNIT");
                        //RadGrid2.Rebind();
                    }
                }

                hKode.Value = "";
            }

            btnImport.Enabled = (Session["QPR.IKU"] != null);
        }

        protected void radComboModel_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if (radComboModel.SelectedIndex != 0)
            {
                Session["QPR.Model.ID"] = radComboModel.SelectedValue;

                int modelId = Convert.ToInt32(radComboModel.SelectedValue);
                radComboPeriod.DataSource = GetQprPeriod(modelId);
                radComboPeriod.DataTextField = "PER_NAME";
                radComboPeriod.DataValueField = "PER_ID";
                radComboPeriod.DataBind();
                radComboPeriod.SelectedIndex = 0;

                if (!Page.IsPostBack)
                {
                    if (Session["QPR.Period.ID"] != null)
                    {
                        radComboPeriod.SelectedValue = (string)Session["QPR.Period.ID"];
                        RadButton1_Click(null, null);
                    }
                }
            }
        }

        protected void RebindGrids(DataTable dt)
        {
            Session["QPR.IKU"] = dt;
            RadGrid1.Rebind();

            DataView view = new DataView(dt);
            if(chkShowEmpty.Checked) view.RowFilter = "KODE_SATKER = ''";
            Session["QPR.MAP"] = view.ToTable(true, "MEA_ID", "NAMA_SATKER", "KODE_SATKER", "NAMA_UNIT");
            RadGrid2.Rebind();

            btnImport.Enabled = (Session["QPR.IKU"] != null);
        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            if (radComboModel.SelectedIndex >= 0 && radComboPeriod.SelectedIndex >= 0)
            {
                int modelId = Convert.ToInt32(radComboModel.SelectedValue);
                int periodId = Convert.ToInt32(radComboPeriod.SelectedValue);
                lblModelName.Text = radComboModel.Text;
                lblPeriodeName.Text = radComboPeriod.Text;

                //DataTable dt = GetQprIku(modelId, periodId);
                RebindGrids(GetQprIku(modelId, periodId));
            }
        }

        protected void radComboPeriod_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["QPR.Period.ID"] = radComboPeriod.SelectedValue;
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            Session["QPR.Model.ID"] = null;
            Session["QPR.Period.ID"] = null;
            Session["HRIS.Period.ID"] = null;
            Session["QPR.IKU"] = null;
            Session["QPR.MAP"] = null;
            Response.Redirect("ImportQpr.aspx", true);
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = (DataTable)Session["QPR.IKU"];

            //if (radComboModel.SelectedIndex > 0 && radComboPeriod.SelectedIndex > 0)
            //{
            //    int modelId = Convert.ToInt32(radComboModel.SelectedValue);
            //    int periodId = Convert.ToInt32(radComboPeriod.SelectedValue);

            //    DataTable dt = new DataTable();
            //    if(Page.IsPostBack && hKode.Value == "") dt = GetQprIku(modelId, periodId);
            //    else dt = (DataTable)Session["QPR.IKU"];

            //    Session["QPR.IKU"] = dt;
            //    RadGrid1.DataSource = dt;
            //}
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            ResetStatus();
            ImportData();

            string modId = (string)Session["QPR.Model.ID"];
            string perId = (string)Session["QPR.Period.ID"];

            Session["QPR.Model.ID"] = null;
            Session["QPR.Period.ID"] = null;
            Session["HRIS.Period.ID"] = null;
            Session["QPR.IKU"] = null;
            Session["QPR.MAP"] = null;
            Response.Redirect("ImportDone.aspx?s=" + modId + "_" + perId);
        }

        protected System.Data.DataTable ResetStatus()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.Import_Pre_UpdateStatus");
        }

        protected void ImportData()
        {
            DateTime ayeuna = DateTime.Now;
            string importCode = ayeuna.Year.ToString() + "-" + ayeuna.Month.ToString("00") + "-" + ayeuna.Day.ToString("00");
            importCode += "-" + ayeuna.Hour.ToString("00") + "-" + ayeuna.Minute.ToString("00");

            string pfmId = (string)Session["HRIS.Period.ID"];
            string modId = (string)Session["QPR.Model.ID"];
            string perId = (string)Session["QPR.Period.ID"];

            DataTable dt = (DataTable)Session["QPR.IKU"];

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Simpel"].ConnectionString;
                cn.Open();

                string timeoutvalue = System.Configuration.ConfigurationManager.AppSettings["timeout_value"].ToString();
                int cmdTimeOut = 60;
                try
                {
                    cmdTimeOut = Convert.ToInt32(timeoutvalue);
                }
                catch { }

                foreach (DataRow dr in dt.Rows)
                {
                    using (SqlCommand cmd = cn.CreateCommand())
                    {
                        cmd.CommandText = "dbo.Import_QprIku";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = cmdTimeOut;

                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@KODE_SATKER", DbType = DbType.String, Direction = ParameterDirection.Input, Value = dr["KODE_SATKER"].ToString() });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@NAMA_SATKER", DbType = DbType.String, Direction = ParameterDirection.Input, Value = dr["NAMA_UNIT"].ToString() });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@DESKRIPSI_IKU", DbType = DbType.String, Direction = ParameterDirection.Input, Value = dr["DESKRIPSI IKU"].ToString() });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@ID_IKU", DbType = DbType.Int32, Direction = ParameterDirection.Input, Value = Convert.ToInt32(dr["ID_IKU"]) });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@IMPORT_CODE", DbType = DbType.String, Direction = ParameterDirection.Input, Value = importCode });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@PFN_ID", DbType = DbType.Int32, Direction = ParameterDirection.Input, Value = Convert.ToInt32(pfmId) });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@PERSPEKTIF", DbType = DbType.String, Direction = ParameterDirection.Input, Value = dr["PERSPEKTIF"].ToString() });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@SASARAN", DbType = DbType.String, Direction = ParameterDirection.Input, Value = dr["SASARAN"].ToString() });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@TARGET", DbType = DbType.String, Direction = ParameterDirection.Input, Value = dr["TARGET"].ToString() });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@USERNAME", DbType = DbType.String, Direction = ParameterDirection.Input, Value = Page.User.Identity.Name });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@MOD_ID", DbType = DbType.Int32, Direction = ParameterDirection.Input, Value = Convert.ToInt32(modId) });
                        cmd.Parameters.Add(new SqlParameter() { ParameterName = "@PERIOD_ID", DbType = DbType.Int32, Direction = ParameterDirection.Input, Value = Convert.ToInt32(perId) });

                        cmd.ExecuteNonQuery();
                    }
                }

                cn.Close();
            }
        }

        protected void radComboHrisPeriod_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            Session["HRIS.Period.ID"] = radComboHrisPeriod.SelectedValue;
        }

        protected void RadGrid2_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid2.DataSource = (DataTable)Session["QPR.MAP"];
        }

        protected void chkShowEmpty_CheckedChanged(object sender, EventArgs e)
        {
            if(Session["QPR.IKU"]!=null)
                RebindGrids((DataTable)Session["QPR.IKU"]);
        }
    }
}