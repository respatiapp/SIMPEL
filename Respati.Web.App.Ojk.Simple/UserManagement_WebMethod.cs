using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Respati.Web.App.Ojk.Simple.Helper;
using System.Web.Security;
using Newtonsoft.Json;

namespace Respati.Web.App.Ojk.Simple
{

    public partial class UserManagement
    {

        [WebMethod]
        public static string Login(string username, string password)
        {
            if (MembershipHelper.Login(username, password))
                return "";
            else
                return "fail";
        }

        [WebMethod]
        public static void Logout()
        {
            HttpContext.Current.Session["IS_LOGIN"] = false;
        }

        [WebMethod]
        public static string Add(string username, string password, string email, bool isEdit, string role, string departementId, string nip, string kd_unit_org,string oldEmail)
        {
            try
            {
                if (!CheckUser(username, nip) || isEdit)
                {
             
                    if (!isEdit)
                    {
                        MembershipUser user = Membership.GetUser(username);
                        
                        if (!Roles.FindUsersInRole(role, username).Any())
                            Roles.AddUserToRole(username, role);
                        if (user == null)
                            Membership.CreateUser(username, password, email);
                        Helper.Helper.InsertUserDepartement(username, departementId.Trim(), nip, kd_unit_org.Trim(), role, "");

                    }
                    else
                    {
                        Roles.RemoveUserFromRoles(oldEmail, Roles.GetRolesForUser(oldEmail));
                        Helper.Helper.InsertUserDepartement(oldEmail, departementId.Trim(), nip, kd_unit_org.Trim(),
                            role, username);
                    }

                    return "";
                }
                else
                {
                    return "Email / NIP sudah digunakan pegawai lain";
                }
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        [WebMethod]
        public static string Remove(string username, string role_name, string roleid, string nip, string user_id)
        {
            try
            {
                //if (Roles.FindUsersInRole(role_name, username).Any())
                    Roles.RemoveUserFromRoles(username, Roles.GetRolesForUser(username));
                    DeleteUserFromDatabase(user_id, nip, role_name);

                return "";
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }

        [WebMethod]
        public static string ChangePassword(string oldpassword, string newpassword)
        {
            MembershipUser user = Membership.GetUser(MembershipHelper.GetCurrentUser().UserName);
            if (user != null && Membership.ValidateUser(user.UserName, oldpassword))
            {
                if (user.ChangePassword(oldpassword, newpassword))
                    return "Pergantian kata sandi berhasil";
                else
                    return "Pergantian kata sandi gagal";
            }
            else
            {
                return "Kata sandi lama salah";
            }
        }

        [WebMethod]
        public static string GetUser(string username)
        {
            //MembershipUser user = Membership.GetUser(username);

            //JavaScriptSerializer serializer = new JavaScriptSerializer();
            //return serializer.Serialize(MembershipHelper.GetUserByName(username));
            return JsonConvert.SerializeObject(GetUserFromDatabase(username));

        }

        [WebMethod]
        public static string GetPegawai(string nama, string kd_unit_org)
        {
            return JsonConvert.SerializeObject(Helper.Helper.GetEmployee(nama, kd_unit_org));
        }

        private static DataTable GetUserFromDatabase(string Username)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@username", SqlDbType.NVarChar, Username);
            return Helper.Helper.ExecuteSp("SP_GetUserCustom");
        }
        private static void DeleteUserFromDatabase(string UserID, string NIP, string rolename)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@user_id", SqlDbType.NVarChar, UserID);
            Helper.Helper.AddParameters("@nip", SqlDbType.NVarChar, NIP);
            Helper.Helper.AddParameters("@ROLENAME", SqlDbType.NVarChar, rolename);
            Helper.Helper.AddParameters("@USER", SqlDbType.NVarChar, HttpContext.Current.User.Identity.Name);
            Helper.Helper.ExecuteSp("SP_DeleteUserDepartemen");
        }

        private static void UpdateUserFromDatabase(string UserID, string NIP, string rolename)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@user_id", SqlDbType.NVarChar, UserID);
            Helper.Helper.AddParameters("@nip", SqlDbType.NVarChar, NIP);
            Helper.Helper.AddParameters("@ROLENAME", SqlDbType.NVarChar, rolename);
            Helper.Helper.AddParameters("@USER", SqlDbType.NVarChar, HttpContext.Current.User.Identity.Name);
            Helper.Helper.ExecuteSp("SP_UpdateUserDepartemen");
        }

        public static bool CheckUser(string username, string NIP)
        {
            Helper.Helper.ClearParameters();
            Helper.Helper.AddParameters("@username", SqlDbType.NVarChar, username);
            Helper.Helper.AddParameters("@nip", SqlDbType.NVarChar, NIP);
            return Convert.ToBoolean(Helper.Helper.ExecuteSp("SP_CheckUser").Rows[0]["IS_EXIST"]);

        }

    }
}