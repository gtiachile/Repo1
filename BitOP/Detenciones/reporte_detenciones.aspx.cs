using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BitOp.Detenciones
{
    public partial class reporte_detenciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);
        }

        protected void ButtonBuscar_Click(object sender, EventArgs e)
        {
            RVDetenciones.LocalReport.Refresh();
        }
    }
}