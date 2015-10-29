using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace BitOp.Admin
{
    public partial class UsuarioFuncion : System.Web.UI.Page
    {
        bool carga_inicial = true;
        protected void Page_Load(object sender, EventArgs e)
        {

                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);                  
        }



        protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            DropDownList UsuarioSel = (DropDownList)FormView1.FindControl("DropDownListUsuario");
            DropDownList AreaSel = (DropDownList)FormView1.FindControl("DropDownListArea");
            DropDownList ProcesoSel = (DropDownList)FormView1.FindControl("DropDownListProceso");
            DropDownList EquipoSel = (DropDownList)FormView1.FindControl("DropDownListEquipo");
            DropDownList TurnoSel = (DropDownList)FormView1.FindControl("DropDownListTurno");
            DropDownList DiasPermSel = (DropDownList)FormView1.FindControl("DropDownListDiasPerm");

            e.Values["Usuario"] = UsuarioSel.SelectedValue.ToString();
            e.Values["Area"] = AreaSel.SelectedValue.ToString();
            e.Values["Proceso"] = ProcesoSel.SelectedValue.ToString();
            e.Values["Equipo"] = EquipoSel.SelectedValue.ToString();
            e.Values["Turno"] = TurnoSel.SelectedValue.ToString();
            e.Values["DiasAtrasoReg"] = Convert.ToInt16(DiasPermSel.SelectedValue.ToString());

        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            GridView2.DataBind();
        }
    }
}