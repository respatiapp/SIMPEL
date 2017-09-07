using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Respati.Web.App.Ojk.Simple.import
{
    public partial class ImportDone : System.Web.UI.Page
    {
        //protected DataSet ds = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SendEmailDeletedIku();
            }
        }

        protected DataSet GetDeletedIkuData(int mId, int pId)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@MODEL_ID", System.Data.SqlDbType.Int, mId);
            Helper.Helper.AddParameters("@PERIODE_ID", System.Data.SqlDbType.Int, pId);
            return Helper.Helper.ExecuteSpReturnDataset("dbo.Import_GetDeletedIku");
        }

        protected void SendEmailDeletedIku()
        {
            string s = "";
            if (Request.QueryString["s"] != null) s = Request.QueryString["s"];

            if (s != "")
            {
                string[] ss = s.Split("_".ToCharArray());

                int modId = -1;
                int perId = -1;

                try
                {
                    modId = Convert.ToInt32(ss[0]);
                    perId = Convert.ToInt32(ss[1]);
                }
                catch { }

                if (modId != -1 && perId != -1)
                {
                    DataSet ds = GetDeletedIkuData(modId, perId);
                    ds.Relations.Add(ds.Tables[0].Columns["NIP"], ds.Tables[1].Columns["NIP"]);

                    #region Send Email

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string subject = "IKU terpakai sudah tidak berlaku lagi";
                        string recipient = dr["EMAIL"].ToString();

                        string body = "<p>Yang terhormat saudara/i " + dr["NM_PEG"].ToString() + ",</p>";
                        body += "<p>Diberitahukan bahwa daftar IKU dibawah ini yang saat ini digunakan dalam RKP anda sudah tidak berlaku lagi.</p>";
                        body += "<p>Silahkan hubungi pihak-pihak terkait untuk menindaklanjutinya</p>.";

                        body += "<p>";
                        int i = 1;
                        foreach (DataRow dr2 in dr.GetChildRows(ds.Relations[0]))
                        {
                            body += (i++).ToString() + ". " + dr2["DESKRIPSI_IKU"].ToString();
                        }
                        body += "</p>";

                        Helper.MailHelper m = new Helper.MailHelper();
                        m.SendEmail(recipient, "", subject, body, true);
                    }

                    #endregion

                    RadGrid1.DataSource = ds.Tables[1];
                    RadGrid1.DataBind();
                }
            }
        }
    }
}