using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using Telerik.Web.UI;

namespace Respati.Web.App.Ojk.Simple.Helper
{
    public class Helper
    {
        private static List<SqlParameter> parameters = new List<SqlParameter>();

        public static void AddParameters(string ParameterName, SqlDbType ParameterType, object ParameterValue)
        {
            SqlParameter param = new SqlParameter();
            param.ParameterName = ParameterName;
            param.SqlDbType = ParameterType;
            param.Value = ParameterValue;
            param.Direction = ParameterDirection.Input;

            parameters.Add(param);
        }

        public static void ClearParameters()
        {
            parameters.Clear();
            //spname = "";
        }

        public static DataSet ExecuteSpReturnDataset(string spName)
        {
            DataSet ds = new DataSet();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Simpel"].ConnectionString;
                cn.Open();

                SqlCommand cmd = cn.CreateCommand();

                cmd.CommandText = spName;
                cmd.CommandType = CommandType.StoredProcedure;

                string timeoutvalue = ConfigurationManager.AppSettings["timeout_value"].ToString();
                int cmdTimeOut = 60;
                try
                {
                    cmdTimeOut = Convert.ToInt32(timeoutvalue);
                }
                catch { }

                cmd.CommandTimeout = cmdTimeOut;

                if (parameters.Count > 0)
                {
                    foreach (SqlParameter parameter in parameters)
                    {
                        SqlParameter parm = new SqlParameter(parameter.ParameterName, parameter.SqlDbType);
                        parm.Value = parameter.Value;
                        parm.Direction = parameter.Direction;
                        cmd.Parameters.Add(parm);
                    }
                }

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }

                cn.Close();
            }

            return ds;
        }

        public static DataTable ExecuteSp(string spName)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection())
            {
                cn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Simpel"].ConnectionString;
                cn.Open();

                SqlCommand cmd = cn.CreateCommand();
                cmd.CommandText = spName;
                cmd.CommandType = CommandType.StoredProcedure;

                string timeoutvalue = ConfigurationManager.AppSettings["timeout_value"].ToString();
                int cmdTimeOut = 60;
                try
                {
                    cmdTimeOut = Convert.ToInt32(timeoutvalue);
                }
                catch { }

                cmd.CommandTimeout = cmdTimeOut;

                if (parameters.Count > 0)
                {
                    foreach (SqlParameter parameter in parameters)
                    {
                        SqlParameter parm = new SqlParameter(parameter.ParameterName, parameter.SqlDbType);
                        parm.Value = parameter.Value;
                        parm.Direction = parameter.Direction;
                        cmd.Parameters.Add(parm);
                    }
                }

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }

                cn.Close();
            }

            return dt;
        }

        public static DataTable GetEselonList()
        {
            ClearParameters();
            return ExecuteSp("dbo.GetEselon00");
        }

        public static DataTable GetDepartment()
        {
            ClearParameters();
            return ExecuteSp("dbo.GetDepartment");
        }

        public static DataTable GetIku()
        {
            ClearParameters();
            return ExecuteSp("dbo.GetIkuList");
        }

        public static DataTable GetHirarkiStatus(string param)
        {
            ClearParameters();
            AddParameters("@KD_UNIT", SqlDbType.VarChar, param);
            return ExecuteSp("dbo.GetHirarkiRkpStatus");
            //return ExecuteSp("dbo.GetHirarkiRkpStatus_Group");
        }

        public static DataTable GetHirarkiRkpStatus_Unit(string param, string src)
        {
            ClearParameters();
            AddParameters("@KD_UNIT", SqlDbType.VarChar, param);
            AddParameters("@KD_MAIN_ROOT", SqlDbType.VarChar, src);
            return ExecuteSp("dbo.GetHirarkiRkpStatus_DetailUnit");
        }

        public static DataTable GetHirarkiRkpStatus_Pegawai(string param, string src)
        {
            ClearParameters();
            AddParameters("@KD_UNIT", SqlDbType.VarChar, param);
            AddParameters("@KD_MAIN_ROOT", SqlDbType.VarChar, src);
            return ExecuteSp("dbo.GetHirarkiRkpStatus_DetailPegawai");
        }

        public static DataTable GetHirarkiRkpPegawaiStatus(string param, string src)
        {
            ClearParameters();
            AddParameters("@KD_UNIT", SqlDbType.VarChar, param);
            AddParameters("@KD_MAIN_ROOT", SqlDbType.VarChar, src);
            return ExecuteSp("dbo.GetHirarkiRkpPegawaiStatus");
        }

        public static DataTable GetHirarkiIkuStatus(string department, int ikuID)
        {
            ClearParameters();
            AddParameters("@KD_UNIT", SqlDbType.VarChar, department);
            AddParameters("@IKU_ID", SqlDbType.Int, ikuID);
            return ExecuteSp("dbo.GetHirarkiIkuStatus");
        }

        public static DataTable InsertMailHistory(string recipient, string subject, string message, string username,
            int status)
        {
            ClearParameters();
            AddParameters("@RECIPIENT", SqlDbType.NVarChar, recipient);
            AddParameters("@SUBJECT", SqlDbType.NVarChar, subject);
            AddParameters("@MESSAGE", SqlDbType.NVarChar, message);
            AddParameters("@USERNAME", SqlDbType.NVarChar, username);
            AddParameters("@STATUS", SqlDbType.NVarChar, status);
            return ExecuteSp("dbo.SP_InsertMailHistory");
        }

        public static DataTable GetDepartmentRoot2()
        {
            ClearParameters();
            return ExecuteSp("dbo.GetDepartmentRoot2");
        }
        public static string GetApplicationName()
        {
            MembershipSection section = ConfigurationManager.GetSection("system.web/membership") as MembershipSection;
            //section.Providers.CurrentConfiguration.Sections.
            if (section != null)
                return section.Providers["SqlMembershipProvider"].Parameters["applicationName"];
            return string.Empty;
        }

        public static void InsertUserDepartement(string username, string departementId, string nip, string kd_unit_org, string role_name, string new_username)
        {
            ClearParameters();
            Helper.AddParameters("@USERname", SqlDbType.NVarChar, username);
            Helper.AddParameters("@DEPARTEMENT_ID", SqlDbType.NVarChar, departementId);
            Helper.AddParameters("@NIP", SqlDbType.NVarChar, nip);
            Helper.AddParameters("@KD_UNIT_ORG", SqlDbType.NVarChar, kd_unit_org);
            Helper.AddParameters("@ROLENAME", SqlDbType.NVarChar, role_name);
            Helper.AddParameters("@NEW_USERNAME", SqlDbType.NVarChar, new_username);
            Helper.AddParameters("@CREATED_BY", SqlDbType.NVarChar, HttpContext.Current.User.Identity.Name);

            ExecuteSp("dbo.SP_InsertUserDepartement");
        }

        public static DataTable GetEmployee(string nama, string kd_unit_org)
        {
            ClearParameters();
            Helper.AddParameters("@NM_PEG", SqlDbType.NVarChar, nama);
            Helper.AddParameters("@KD_UNIT_ORG", SqlDbType.NVarChar, kd_unit_org);

            return ExecuteSp("dbo.SP_GetEmployeeByName");
        }

        public static DataTable GetUsers()
        {
            ClearParameters();
            AddParameters("@ApplicationName", SqlDbType.NVarChar, GetApplicationName());
            return ExecuteSp("dbo.SP_GetUsers");
        }

        public static DataTable GetUser(string username)
        {
            ClearParameters();
            AddParameters("@ApplicationName", SqlDbType.NVarChar, GetApplicationName());
            AddParameters("@Username", SqlDbType.NVarChar, username);
            return ExecuteSp("dbo.SP_GetUserCustom");
        }
        public static DataTable InsertSetting(Scheduler scheduler)
        {
            ClearParameters();

            AddParameters("@ID_SETTING", SqlDbType.NVarChar, scheduler.SettingID);
            AddParameters("@NM_SETTING", SqlDbType.NVarChar, scheduler.NamaSetting);
            AddParameters("@INTERVAL", SqlDbType.NVarChar, scheduler.Interval);
            AddParameters("@INTERVAL_TYPE", SqlDbType.NVarChar, scheduler.IntervalType);
            AddParameters("@IS_DIREKTUR", SqlDbType.NVarChar, scheduler.IsDirektur);
            AddParameters("@IS_KADEP", SqlDbType.NVarChar, scheduler.IsKepalaDepartement);
            AddParameters("@IS_DEPUTY_DIREKTUR", SqlDbType.NVarChar, scheduler.IsDeputyDirektur);
            AddParameters("@IS_KABAG", SqlDbType.NVarChar, scheduler.IsKaBag);
            AddParameters("@IS_AKTIF", SqlDbType.NVarChar, scheduler.IsActive);
            AddParameters("@NILAI_RKP", SqlDbType.NVarChar, scheduler.MinimalRKP);
            AddParameters("@USERNAME", SqlDbType.NVarChar, scheduler.created_by);
            return ExecuteSp("dbo.SP_InsertSetting");

        }

        public static DataTable GetSetting(string id)
        {
            ClearParameters();
            AddParameters("@ID_SETTING", SqlDbType.Int, int.Parse(id));
            return ExecuteSp("dbo.SP_GetSetting");
        }

        public static void RemoveSetting(string id)
        {
            ClearParameters();
            AddParameters("@ID_SETTING", SqlDbType.Int, int.Parse(id));
            ExecuteSp("dbo.SP_RemoveSetting");
        }

        public static DataTable GetAllSetting()
        {
            ClearParameters();
            return ExecuteSp("dbo.SP_GetAllSetting");
        }
        public static DataTable GetSchedule()
        {
            ClearParameters();
            return ExecuteSp("dbo.SP_GetScheduler");
        }

        public static void UpdateSettingRun(string id)
        {
            ClearParameters();
            AddParameters("@ID_SETTING", SqlDbType.NVarChar, id.ToString());
            ExecuteSp("dbo.SP_UpdateSettingRun");
        }
        public static DataTable GetEselonList(string name)
        {
            ClearParameters();
            AddParameters("@NM_DEPARTEMENT", SqlDbType.NVarChar, name);
            return ExecuteSp("dbo.GetEselon00ByName");
        }

        public static void UpdateHRISEmail(string nip, string email)
        {
            ClearParameters();
            AddParameters("@nip", SqlDbType.NVarChar, nip);
            AddParameters("@email", SqlDbType.NVarChar, email);
            ExecuteSp("dbo.SP_UpdateHRISEmail");
        }

        public static DataTable GetIKUList(string namaDept)
        {
            ClearParameters();
            AddParameters("@NAMA_SATKER", SqlDbType.NVarChar, namaDept);
            return ExecuteSp("dbo.SP_GetIKUList");
        }

        public static DataTable GetUserParentDepartemen(string username)
        {
            ClearParameters();
            AddParameters("@USERNAME", SqlDbType.NVarChar, username);
            return ExecuteSp("SP_GetUserParentDept");

        }

        public static void PopulateCmbPeriode(RadComboBox combo)
        {
            ClearParameters();
            PopuplateCombobox(combo, ExecuteSp("dbo.GetViewPeriode"), "TAHUN", "PERIODE_ID", "[Pilih periode]");
            
        }

        public static void PopuplateCombobox(RadComboBox combo, DataTable dataSouce, string DisplayText,
            string DisplayValue, string EmptyText = "", int selectedIndex = -1)
        {
            combo.DataSource = dataSouce;
            combo.AllowCustomText = false;
            combo.MarkFirstMatch = true;
            combo.Filter = RadComboBoxFilter.Contains;
            combo.EmptyMessage = EmptyText;
            combo.DataTextField = DisplayText;
            combo.DataValueField = DisplayValue;
            if (selectedIndex != -1)
            combo.SelectedIndex = selectedIndex;
            combo.DataBind();
        }


    }
}
