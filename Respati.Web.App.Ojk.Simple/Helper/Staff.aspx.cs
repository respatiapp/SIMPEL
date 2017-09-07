using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Respati.Web.App.Ojk.Simple.Helper
{
    public partial class Staff : System.Web.UI.Page
    {
        protected string IKU_IKI_DATA = "";
        protected string VIEW_MODE = "IKU";
        protected System.Data.DataTable DATANYA = new System.Data.DataTable();
        //protected string HEADER_LABEL = "";

        protected static string DataTableToJSON(System.Data.DataTable table)
        {
            List<List<string>> list = new List<List<string>>();

            foreach (System.Data.DataRow row in table.Rows)
            {
                List<string> dict = new List<string>(row.ItemArray.Cast<string>().ToArray());
                list.Add(dict);
            }

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            return serializer.Serialize(list);
        }

        protected System.Data.DataSet GetPegawaiDetail(string nip)
        {
            Helper.ClearParameters();
            Helper.AddParameters("@NIP", System.Data.SqlDbType.VarChar, nip);
            return Helper.ExecuteSpReturnDataset("dbo.GetPegawaiDetail_IKU_IKI");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string nip = "";
            if (Request.QueryString["NIP"] != null) nip = Request.QueryString["NIP"];
            if (Request.QueryString["VW"] != null) VIEW_MODE = Request.QueryString["VW"];
            //if (VIEW_MODE == "IKU") HEADER_LABEL = "IKU";
            //else { HEADER_LABEL[0] = "IKI TURUNAN"; HEADER_LABEL[1] = "DESKRIPSI"; }

            System.Data.DataSet ds = GetPegawaiDetail(nip);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblNip.Text = ds.Tables[0].Rows[0]["NIP"].ToString();
                lblNama.Text = ds.Tables[0].Rows[0]["NM_PEG"].ToString();
                Image1.ImageUrl = ds.Tables[0].Rows[0]["FOTO"].ToString();
            }

            IKU_IKI_DATA = "";
            if (ds.Tables[1].Rows.Count > 0)
            {
                //IKU_IKI_DATA = DataTableToJSON(ds.Tables[1]);
                DATANYA = ds.Tables[1];
            }
        }
    }
}