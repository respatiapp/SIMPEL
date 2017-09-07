using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Respati.Web.App.Ojk.Simple.Helper;

namespace Respati.Web.App.Ojk.Simple
{
    public partial class UserManagement : System.Web.UI.Page
    {
        protected string ListDepartement = string.Empty;
        protected string ListUnitOrg = string.Empty;
        protected string ListEmployee = string.Empty;
        protected string ListRole;

        private System.Data.DataSet UnitKerjaList()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSpReturnDataset("dbo.GetSatkerIkuList");
        }

        private void BindRadComboBox()
        {   
            RadComboBox1.DataSource = Helper.MembershipHelper.GetAllRoles("SuperAdmin");
            RadComboBox1.DataBind();
        }

        private void BindRadGrid(string param)
        {
            //RadGrid1.DataSource = Helper.MembershipHelper.GetUserInRoles(param);
            RadGrid1.DataSource = Helper.Helper.GetUsers();
            RadGrid1.DataBind();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            List<string> allowedList = ConfigurationManager.AppSettings["UsermanagementAllowedList"].Split(';').Select(x => x.Trim().ToLower()).ToList<string>();
            ListDepartement = JsonConvert.SerializeObject(Helper.Helper.GetDepartment());
            ListEmployee = JsonConvert.SerializeObject(new List<string>());
            ListRole = JsonConvert.SerializeObject(MembershipHelper.GetAllRoles());
            ListUnitOrg = JsonConvert.SerializeObject(new List<string>());
            if (!Roles.GetRolesForUser(User.Identity.Name)
                .Where(x => allowedList.Contains(x.ToLower())).ToList().Any() && !allowedList.Contains("*"))
                Response.Redirect("AccessDenied.aspx");

            if (!Page.IsPostBack)
            {              
                BindRadComboBox();
                Helper.GirdHelper.SetUpGrid(RadGrid1);

            }


        }

        protected void RadComboBox1_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            BindRadGrid(RadComboBox1.SelectedValue);
            
        }

        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

            //BindRadGrid(RadComboBox1.SelectedValue);

            RadGrid1.DataSource = Helper.Helper.GetUsers();
        }
    }
}