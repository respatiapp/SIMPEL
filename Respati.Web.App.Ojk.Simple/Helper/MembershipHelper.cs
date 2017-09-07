using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.ApplicationServices;
using System.Web.Security;
using System.Diagnostics;
using System.Xml;

namespace Respati.Web.App.Ojk.Simple.Helper
{


    public class MembershipHelper
    {

        public static List<string> GetAllRoles(string excluderoles)
        {
            return Roles.GetAllRoles().ToList<string>().Where(x => x != excluderoles).ToList();
            //            return Roles.GetAllRoles().ToList();
        }
        public static List<string> GetAllRoles()
        {
            return Roles.GetAllRoles().ToList<string>().Where(x => !"SuperAdmin;Users".ToLower().Split(';').ToList().Contains(x.ToLower())).ToList();
        }

        public static List<MembershipUser> GetUserInRoles(string rolesName)
        {
            List<string> listUsername = Roles.GetUsersInRole(rolesName).ToList<string>();
            List<MembershipUser> listMembershipUser = new List<MembershipUser>();
            listUsername.ForEach(x => listMembershipUser.Add(Membership.GetUser(x)));
            return listMembershipUser;
        }

        public static List<MembershipUser> GetAllUser()
        {
            List<string> listRole = Roles.GetAllRoles().ToList();
            return null;

        }

        public static DataTable GetUserInRolesCustom(string roleName)
        {
            Helper.ClearParameters();
            Helper.AddParameters("@ApplicationName", SqlDbType.NVarChar, Helper.GetApplicationName());
            Helper.AddParameters("@roleName", SqlDbType.NVarChar, roleName);
            return Helper.ExecuteSp("SP_GetUserInRolesCustom");
        }

        public static DataTable GetUserByName(string userName)
        {

            Helper.ClearParameters();
            Helper.AddParameters("@ApplicationName", SqlDbType.NVarChar, Helper.GetApplicationName());
            Helper.AddParameters("@userName", SqlDbType.NVarChar, userName);
            return Helper.ExecuteSp("SP_GetEmployeeByName");

        }


        public static MembershipUser GetCurrentUser()
        {
            if (HttpContext.Current.Session["User"] != null)
                return (HttpContext.Current.Session["User"] as MembershipUser);
            else
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    System.Data.DataTable dt = Helper.GetUser(HttpContext.Current.User.Identity.Name);
                    dt.AsEnumerable().Cast<DataRow>().ToList().
                    ForEach(x =>
                    {
                        if (x.Field<string>("RoleName").ToUpper() == "MIA")
                        {
                            HttpContext.Current.Session["User.DeptID"] = x.Field<string>("DEPARTEMENT_ID");
                            HttpContext.Current.Session["User.Dept"] = x.Field<string>("NM_UNIT_ORG");
                        }

                    });

                    if (dt.Rows.Count > 0)
                    {
                        HttpContext.Current.Session["User.UnitName"] = dt.Rows[0]["NAMA_UNIT"].ToString();
                        HttpContext.Current.Session["User.RoleName"] = dt.Rows[0]["RoleName"].ToString();
                    }

                    return (HttpContext.Current.Session["User"] as MembershipUser);
                }
                return null;
            }
        }


        public static bool Login(string username, string password)
        {

            if (Membership.ValidateUser(username, password))
            {
                HttpContext.Current.Session["User"] = Membership.GetUser(username);

                System.Data.DataTable dt = Helper.GetUser(username);

                dt.AsEnumerable().Cast<DataRow>().ToList().
                    ForEach(x =>
                    {
                        if (x.Field<string>("RoleName").ToUpper() == "MIA")
                        {
                            HttpContext.Current.Session["User.DeptID"] = x.Field<string>("DEPARTEMENT_ID");
                            HttpContext.Current.Session["User.Dept"] = x.Field<string>("NM_UNIT_ORG");
                        }

                    });

                if (dt.Rows.Count > 0)
                {
                    HttpContext.Current.Session["User.UnitName"] = dt.Rows[0]["NM_UNIT_ORG"].ToString();
                    HttpContext.Current.Session["User.RoleName"] = dt.Rows[0]["RoleName"].ToString();
                }

                FormsAuthentication.SetAuthCookie(username, true);
                return true;
            }
            else
            {
                return false;
            }
        }
        public static void Logout()
        {
            var context = HttpContext.Current;
            HttpContext.Current.Session["User"] = null;
            HttpContext.Current.Session["User.Dept"] = null;
            HttpContext.Current.Session["User.DeptID"] = null;
            HttpContext.Current.Session["User.RoleName"] = null;
            HttpContext.Current.Session["User.UnitName"] = null;

            FormsAuthentication.SignOut();

            HttpContext.Current.Session.Abandon();


            FormsAuthentication.RedirectToLoginPage();
        }

        public static bool CreateUser(string username, string password)
        {
            if (Membership.FindUsersByName(username).Count == 0)
            {
                Membership.CreateUser(username, password);
                return true;
            }
            else
            {
                return false;
            }

        }

        public static void RemoveUser(string username)
        {
            Membership.DeleteUser(username, false);
        }

        public static DataTable FilterMia(DataTable dt, string FieldToCompare, string Value)
        {
            if (HttpContext.Current.User.IsInRole("MIA"))
            {
                GetCurrentUser();
                var rows = dt.AsEnumerable()
                    .Where(x => x.Field<string>(FieldToCompare) == HttpContext.Current.Session[Value].ToString());
                return !rows.Any() ? null : rows.CopyToDataTable();
            }
            return dt;
        }

    }

}