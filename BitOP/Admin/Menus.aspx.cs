using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace BitOp.Admin
{
    public partial class Menus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);                  
        }

        protected void ButtonAgrModulo_Click(object sender, EventArgs e)
        {

            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil =  DropDownPerfil.SelectedValue;
            String Modulo = DropDownListModulo.SelectedValue;
            int Posicion = GridViewMenu_N0.Rows.Count + 1;
            con = new SqlConnection(BopDBModulos.ConnectionString);
            cmd.Connection = con;
            con.Open();
            try
            {

                cmd.CommandText = "INSERT INTO [dbo].[Menu_N0] ([Perfil],[Posicion],[Modulo]) VALUES('" + Perfil.Trim() + "'," + Posicion.ToString() + ",'" + Modulo.Trim() + "')";
                cmd.ExecuteNonQuery();
                GridViewMenu_N0.DataBind();
            }
            catch (SqlException exception)
            {
                if (exception.Number == 2601) // Cannot insert duplicate key row in object error
                {
                    return;
                }

            }
        }


        protected void ButtonAgrMenu_Click(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil = DropDownPerfil.SelectedValue;
            String Opcion = DropDownListMenu.SelectedValue;
            int i = GridViewMenu_N0.SelectedIndex;
            Label Modulo = (Label)GridViewMenu_N0.Rows[i].FindControl("Modulo");
            int Posicion = GridViewMenu_N1.Rows.Count + 1;
            con = new SqlConnection(BopDBModulos.ConnectionString);
            cmd.Connection = con;
            con.Open();
            try
            {

                cmd.CommandText = "INSERT INTO [dbo].[Menu_N1] ([Perfil],[Modulo],[Posicion],[Opcion]) VALUES('" + Perfil.Trim() + "','" + Modulo.Text.Trim() + "'," + Posicion.ToString() + ",'" + Opcion.Trim() + "')";
                cmd.ExecuteNonQuery();
                GridViewMenu_N1.DataBind();
            }
            catch (SqlException exception)
            {
                if (exception.Number == 2601) // Cannot insert duplicate key row in object error
                {
                    return;
                }

            }
        }

        protected void ButtonAgrOpcion_Click(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil = DropDownPerfil.SelectedValue;
            String Opcion = DropDownOpcionPag_N1.SelectedValue;
            int i = GridViewMenu_N0.SelectedIndex;
            Label Modulo = (Label)GridViewMenu_N0.Rows[i].FindControl("Modulo");
            int Posicion = GridViewMenu_N1.Rows.Count + 1;
            con = new SqlConnection(BopDBModulos.ConnectionString);
            cmd.Connection = con;
            con.Open();
            try
            {

                cmd.CommandText = "INSERT INTO [dbo].[Menu_N1] ([Perfil],[Modulo],[Posicion],[Opcion]) VALUES('" + Perfil.Trim() + "','" + Modulo.Text.Trim() + "'," + Posicion.ToString() + ",'" + Opcion.Trim() + "')";
                cmd.ExecuteNonQuery();
                GridViewMenu_N1.DataBind();
            }
            catch (SqlException exception)
            {
                if (exception.Number == 2601) // Cannot insert duplicate key row in object error
                {
                    return;
                }

            }
        }

        protected void GridViewMenu_N0_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = GridViewMenu_N0.SelectedIndex;
            Label Modulo = (Label)GridViewMenu_N0.Rows[i].FindControl("Modulo");
            ModuloSel.Text = Modulo.Text;
            OpcionSel.Text = "";
            GridViewMenu_N1.SelectedIndex = -1;
            GridViewMenu_N1.DataBind();
        }

        protected void GridViewMenu_N1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = GridViewMenu_N1.SelectedIndex;
            Label Opcion = (Label)GridViewMenu_N1.Rows[i].FindControl("Opcion");
            OpcionSel.Text = Opcion.Text;
            GridViewMenu_N2.SelectedIndex = -1;
            GridViewMenu_N2.DataBind();
        }

        protected void ButtonAgrOpcionN2_Click(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil = DropDownPerfil.SelectedValue;
            String Opcion = DropDownListOpcionPagN2.SelectedValue;
            int i = GridViewMenu_N0.SelectedIndex;
            Label Modulo = (Label)GridViewMenu_N0.Rows[i].FindControl("Modulo");
            int j = GridViewMenu_N1.SelectedIndex;
            Label OpcionN1 = (Label)GridViewMenu_N1.Rows[j].FindControl("Opcion");
            int Posicion = GridViewMenu_N2.Rows.Count + 1;
            con = new SqlConnection(BopDBModulos.ConnectionString);
            cmd.Connection = con;
            con.Open();
            try
            {

                cmd.CommandText = "INSERT INTO [dbo].[Menu_N2] ([Perfil],[Modulo],[Posicion],[Opcion1],[Opcion2]) VALUES('" + Perfil.Trim() + "','" + Modulo.Text.Trim() + "'," + Posicion.ToString() + ",'" + OpcionN1.Text.Trim() +"','" + Opcion.Trim() + "')";
                cmd.ExecuteNonQuery();
                GridViewMenu_N2.DataBind();
            }
            catch (SqlException exception)
            {
                if (exception.Number == 2601) // Cannot insert duplicate key row in object error
                {
                    return;
                }

            }
        }


    }
}