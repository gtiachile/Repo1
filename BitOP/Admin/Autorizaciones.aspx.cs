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
    public partial class Autorizaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);                  
        }

        protected void ButtonAgregaAut_Click(object sender, EventArgs e)
        {

            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil = DropDownListPerfil.SelectedValue;
            con = new SqlConnection(BopDBAutorizaciones.ConnectionString);
            cmd.Connection = con;
            con.Open();
            for (int i = 0; i < GridViewAutDisp.Rows.Count; i++)
            {
                Boolean indAut = ((CheckBox)GridViewAutDisp.Rows[i].FindControl("AutorOnOff")).Checked;
                if (indAut)
                {
                    try
                    {
                        ((CheckBox)GridViewAutDisp.Rows[i].FindControl("AutorOnOff")).Checked = false;
                        Label Modulo = (Label)GridViewAutDisp.Rows[i].FindControl("Modulo");
                        Label Opcion = (Label)GridViewAutDisp.Rows[i].FindControl("Opcion");
                        cmd.CommandText = "INSERT INTO [dbo].[Autorizaciones] ([Perfil],[Modulo],[Opcion],[Estado]) VALUES ('" + Perfil.Trim() + "','" + Modulo.Text.Trim() + "','" + Opcion.Text.Trim() + "','Activo')";
                        cmd.ExecuteNonQuery();
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
            con.Close();
            GridViewAutAsig.DataBind();
        }

        protected void ButtonElimAut_Click(object sender, EventArgs e)
        {
            SqlConnection con2;
            SqlCommand cmd2 = new SqlCommand();
            String Perfil = DropDownListPerfil.SelectedValue;
            con2 = new SqlConnection(BopDBAutorizaciones.ConnectionString);
            cmd2.Connection = con2;
            con2.Open();
            for (int j = 0; j < GridViewAutAsig.Rows.Count; j++)
            {
                Boolean indAut2 = ((CheckBox)GridViewAutAsig.Rows[j].FindControl("CheckBoxAut")).Checked;
                if (indAut2)
                {
                        ((CheckBox)GridViewAutAsig.Rows[j].FindControl("CheckBoxAut")).Checked = false;
                        Label Modulo = (Label)GridViewAutAsig.Rows[j].FindControl("Modulo");
                        Label Opcion = (Label)GridViewAutAsig.Rows[j].FindControl("Opcion");
                        cmd2.CommandText = "DELETE FROM [dbo].[Autorizaciones] WHERE Perfil ='" + Perfil.Trim() + "' And Modulo='" + Modulo.Text.Trim() + "' And Opcion='" + Opcion.Text.Trim() + "'";
                        cmd2.ExecuteNonQuery();

                }
            }
            con2.Close();
            GridViewAutAsig.DataBind();

        }

        protected void ButtonAgrAll_Click(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil = DropDownListPerfil.SelectedValue;
            con = new SqlConnection(BopDBAutorizaciones.ConnectionString);
            cmd.Connection = con;
            con.Open();
            cmd.CommandText = "DELETE FROM [dbo].[Autorizaciones] WHERE Perfil ='" + Perfil.Trim() + "'";
            cmd.ExecuteNonQuery();
            cmd.CommandText = "Insert into [dbo].[Autorizaciones] SELECT '" + Perfil.Trim() + "' as [Perfil],[Modulo],[Opcion],'Activo' as [Estado],Null as [Fecha Creación],Null as [Fecha Modif],Null as [Usuario Modif] FROM [Opciones]";
            cmd.ExecuteNonQuery();
            con.Close();
            GridViewAutAsig.DataBind();
        }

        protected void ButtonElimAll_Click(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String Perfil = DropDownListPerfil.SelectedValue;
            con = new SqlConnection(BopDBAutorizaciones.ConnectionString);
            cmd.Connection = con;
            con.Open();
            cmd.CommandText = "DELETE FROM [dbo].[Autorizaciones] WHERE Perfil ='" + Perfil.Trim() + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            GridViewAutAsig.DataBind();        
        }

    }
}