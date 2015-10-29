using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BitOp.Incidentes
{
    public partial class Reporte_Incidentes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);
            }
        }

        protected void ButtonBuscar_Click(object sender, EventArgs e)
        {
            RVIncidentes.LocalReport.Refresh();
        }
    }
}