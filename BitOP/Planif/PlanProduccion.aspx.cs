using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BitOp.Planif
{
    public partial class PlanProduccion : System.Web.UI.Page
    {
        bool carga_inicial = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (carga_inicial)
            { 
            BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);
            carga_inicial = false;
            }
//            TextBoxFechaInicio.Text = DateTime.Today.ToString("yyyy-MM-dd");
        }

        protected void BtBuscar_Click(object sender, EventArgs e)
        {
            RVPlanProduccion.LocalReport.Refresh();
        }

        protected void DropDownListPlanta_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}