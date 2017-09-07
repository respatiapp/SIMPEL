using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Respati.Web.App.Ojk.Simple.Helper;
using Telerik.Web.UI;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class PengirimanNotifikasi : System.Web.UI.Page
    {
        private static int InsertMailSchedulerHistory(string target_level, string presentase, string sendby)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@TARGET_LEVEL", SqlDbType.NVarChar, target_level);
            Helper.Helper.AddParameters("@PERSENTASE", SqlDbType.NVarChar, presentase);
            Helper.Helper.AddParameters("@SEND_BY", SqlDbType.NVarChar, sendby);
            DataTable dt = Helper.Helper.ExecuteSp("SP_InsertMailScheduleHistory");
            int id = int.Parse(dt.Rows[0]["ID"].ToString());
            return id;

        }
        private static void InsertMailScheduleHistoryDetail(int id, EmailRecipient recipient, string subject, string message,bool sendStatus)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@HISTORY_ID", SqlDbType.Int, id);
            Helper.Helper.AddParameters("@RECIPIENT", SqlDbType.NVarChar, recipient.email);
            Helper.Helper.AddParameters("@SUBJECT", SqlDbType.NVarChar, subject ?? "");
            Helper.Helper.AddParameters("@MESSAGE", SqlDbType.NVarChar, message ?? "");
            Helper.Helper.AddParameters("@STATUS_TERPILIH", SqlDbType.SmallInt, recipient.is_selected);
            Helper.Helper.AddParameters("@SEND_STATUS", SqlDbType.SmallInt, sendStatus);
            Helper.Helper.AddParameters("@NM_DEPARTEMEN", SqlDbType.NVarChar, recipient.departemen);
            Helper.Helper.ExecuteSp("SP_InsertMailScheduleHistoryDetail");
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                List<string> allowedList =
                    ConfigurationManager.AppSettings["UsermanagementAllowedList"].Split(';')
                        .Select(x => x.Trim().ToLower())
                        .ToList();
                if (!Roles.GetRolesForUser(User.Identity.Name)
                    .Where(x => allowedList.Contains(x.ToLower())).ToList().Any() && !allowedList.Contains("*"))
                    Response.Redirect("AccessDenied.aspx");
                RadGrid1.DataSource = string.Empty;
                Helper.GirdHelper.SetUpGrid(RadGrid1);
            }

        }



        [WebMethod]
        public static string GetSchedule(string targetLevel, string persentase)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@TARGET_LEVEL", SqlDbType.NVarChar, targetLevel);
            Helper.Helper.AddParameters("@persentase", SqlDbType.Float, float.Parse(persentase));
            DataTable dt = Helper.Helper.ExecuteSp("dbo.SP_GetScheduler_NEW");
            return JsonConvert.SerializeObject(new
            {
                Data = dt,
                Count = dt.Rows.Count
            });
        }

        private static string FormatName(string name)
        {
            List<string> listName = name.ToLower().Split(' ').
                Select(x =>
                {
                    char[] c = x.ToCharArray();
                    c[0] = char.ToUpper(c[0]);
                    return new string(c);
                }).ToList();
            return string.Join(" ", listName);
        }

        protected void RadGrid1_OnItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridPagerItem)
            {
                GridPagerItem pagerItem = (GridPagerItem)e.Item;
                RadComboBox PageSizeCombo = (RadComboBox)pagerItem.FindControl("PageSizeComboBox");
                RadComboBoxItem item1 = new RadComboBoxItem();
                item1 = new RadComboBoxItem("All", int.MaxValue.ToString());
                item1.Attributes.Add("ownerTableViewId", e.Item.OwnerTableView.ClientID);
                PageSizeCombo.Items.Add(item1);

            }
        }
        [WebMethod]
        public static string SendEmail(string data, string target_level, string persentase)
        {
            try
            {
                string template = "";
                template += "Kepada Yth. {0}<br/><br/>Dengan ini kami informasikan bahwa untuk <b>{1}</b> pada saat ini ";
                template += "pengisian RKP baru mencapai <b>{2}%</b>.<br/><br/>";
                template += "Mohon dibantu dalam proses pengawasan pengisian RKP mengingat batas waktu yang semakin dekat.<br/><br/>";
                template += "Terima kasih.";
                string subject = "Pemberitahuan batas waktu pengisian RKP akan segera berakhir";

                string sendby = HttpContext.Current.User.Identity.Name;
                List<EmailRecipient> listRecipient = JsonConvert.DeserializeObject<List<EmailRecipient>>(data);

                int id = InsertMailSchedulerHistory(target_level, persentase, sendby);
                listRecipient
                    .ForEach(x =>
                    {
                        string message = null;
                        if (x.is_selected)
                        {
                            bool send_status = false;

                            MailHelper helper = new MailHelper();

                            message = string.Format(template,
                                    FormatName(x.nama_pegawai),
                                    x.departemen,
                                    x.nilai_rkp
                                    );
                           
                            try
                            {
                                helper.SendEmail(x.email, "", subject, message, true);
                                send_status = true;
                            }
                            catch (Exception ex)
                            {
                                send_status = false;
                            }
                            InsertMailScheduleHistoryDetail(id, x, subject, message,  send_status);

                        }
 
                    });

                return JsonConvert.SerializeObject(new 
                {
                  Success = true,
                  Message = "" 
                });
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(new
                {
                    Success = false,
                    Message = ex.ToString()
                });
            }

        }


    }

    internal class EmailRecipient
    {
        public string email { get; set; }
        public bool is_selected { get; set; }
        public string departemen { get; set; }
        public string nama_pegawai { get; set; }
        public string nama_jabatan { get; set; }
        public string nilai_rkp { get; set; }
        public string target_level { get; set; }
        public int jumlah_rkp { get; set; }
        public int jumlah_pegawai { get; set; }
        public string nip { get; set; }

    }
}
