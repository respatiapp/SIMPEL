using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Respati.Web.App.Ojk.Simple.laporan
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected System.Data.DataTable GetDashboardRKP()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.GetDashboardRKP");
        }

        protected System.Data.DataTable GetDashboardIKU()
        {
            Helper.Helper.ClearParameters();
            return Helper.Helper.ExecuteSp("dbo.GetDashboardIKU");
        }

        protected void UpdateRange(Telerik.Web.UI.RadRadialGauge g)
        {
            Telerik.Web.UI.GaugeRange range = new Telerik.Web.UI.GaugeRange();
            g.Scale.Labels.Template = "#=value# %";
            g.Scale.Ranges.Add(new Telerik.Web.UI.GaugeRange() { Color = System.Drawing.ColorTranslator.FromHtml("#c20000"), From = 0, To = 20 });
            g.Scale.Ranges.Add(new Telerik.Web.UI.GaugeRange() { Color = System.Drawing.ColorTranslator.FromHtml("#ff7a00"), From = 20, To = 40 });
            g.Scale.Ranges.Add(new Telerik.Web.UI.GaugeRange() { Color = System.Drawing.ColorTranslator.FromHtml("#ffc700"), From = 40, To = 60 });
            g.Scale.Ranges.Add(new Telerik.Web.UI.GaugeRange() { Color = System.Drawing.ColorTranslator.FromHtml("#8dcb2a"), From = 60, To = 80 });
        }

        protected void ProcessDashboardRKP()
        {
            System.Data.DataTable dt = GetDashboardRKP();

            if (dt.Rows.Count > 0)
            {
                UpdateRange(RadRadialGauge1);
                decimal maxvalue = Convert.ToDecimal(dt.Rows[0]["ANGKA_PEGAWAI"]);
                decimal curvalue = Convert.ToDecimal(dt.Rows[0]["ANGKA_RKP"]);
                decimal pointer_value = (curvalue / maxvalue) * 100;
                //RadRadialGauge1.Scale.Max = maxScale;
                RadRadialGauge1.Pointer.Value = pointer_value;
                lblGaugeRkp.Text = pointer_value.ToString("0.000000");
            }
        }

        protected void ProcessDashboardIKU()
        {
            System.Data.DataTable dt = GetDashboardIKU();

            if (dt.Rows.Count > 0)
            {
                UpdateRange(RadRadialGauge2);
                decimal maxvalue = Convert.ToDecimal(dt.Rows[0]["JUMLAH_IKU"]);
                decimal curvalue = Convert.ToDecimal(dt.Rows[0]["ANGKA_IKU"]);
                decimal pointer_value = (curvalue / maxvalue) * 100;
                RadRadialGauge2.Pointer.Value = pointer_value;
                lblGaugeIku.Text = pointer_value.ToString("0.000000");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ProcessDashboardRKP();
            ProcessDashboardIKU();
        }
    }
}