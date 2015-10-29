using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace BitOp.Planif
{
    public partial class Ordenes_Fab : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            { 
                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);                  
                EmptyPanel.Visible = false;
                TextBoxFechaLot0.Text = DateTime.Today.AddDays(2).ToString("yyyy-MM-dd");
                TextBoxFechaProd.Text = DateTime.Today.AddDays(1).ToString("yyyy-MM-dd");
            }

        }


     protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        SqlConnection con;
        SqlCommand cmd = new SqlCommand();
        String FechaProd = TextBoxFechaProd.Text.ToString();
        String Planta = DropDownListPlantas.SelectedValue.ToString();
        String Area = DropDownAreas.SelectedValue.ToString();
        String Turno = DropDownList1.SelectedValue.ToString();
        TextBox txtOF = (TextBox)GridView1.FooterRow.FindControl("TextBoxInsOF");
        txtOF.Text = getNewOF();
        DropDownList DropDownMaterial = (DropDownList)GridView1.FooterRow.FindControl("DropDownListMaterial");
        String txtMaterial = DropDownMaterial.SelectedValue.ToString();
        TextBox txtCantidadPlanif = (TextBox)GridView1.FooterRow.FindControl("TextBoxCantidadPlanif");
        TextBox txtTiempoPlan = (TextBox)GridView1.FooterRow.FindControl("TextBoxTiempoPlan");
        txtTiempoPlan.Text = getDuracionOF(txtMaterial.ToString(), txtCantidadPlanif.Text.ToString());
        DropDownList DropDownListPrio = (DropDownList)GridView1.FooterRow.FindControl("DropDownListPrio");
        String txtListPrio = DropDownListPrio.SelectedValue.ToString();
        TextBox txtFechaLot = (TextBox)GridView1.FooterRow.FindControl("TextBoxFechaLot");
        TextBox txtObs = (TextBox)GridView1.FooterRow.FindControl("TextBoxObs");
        String insValues = " VALUES ('" + txtOF.Text.Trim() + "','" + FechaProd.Trim() + "','" + Area.Trim() + "','" + Turno.Trim() + "','" + txtMaterial.Trim() + "'," + txtCantidadPlanif.Text.Trim() + "," + txtTiempoPlan.Text.Trim() + ",'" + txtListPrio.Trim() + "','" + txtFechaLot.Text.Trim() + "','" + txtObs.Text.Trim() + "')";
        String insComm = "INSERT INTO [OrdenesFabricacion] ([OrdenFab],[FechaPlanif],[Area],[Turno],[Material],[CantidadPlanif],[TiempoPlanif],[Prioridad],[Fecha Lote],[Observaciones])" + insValues;
        con = new SqlConnection(BopDBOrdenesFab.ConnectionString);
        cmd.Connection = con;
        con.Open();
        try
        {

            cmd.CommandText = insComm;
            cmd.ExecuteNonQuery();
            GridView1.DataBind();
            if (GridView1.Rows.Count > 0)
            {
                EmptyPanel.Visible = false;
            }
            else
            {
                EmptyPanel.Visible = true;
            }
        }
        catch (SqlException exception)
        {
            if (exception.Number == 2601) // Cannot insert duplicate key row in object error
            {
                return;
            }

        }
    }


        protected void BT_Nuevo_Click(object sender, EventArgs e)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            String FechaProd = TextBoxFechaProd.Text.ToString();
            String Planta = DropDownListPlantas.SelectedValue.ToString();
            String Area = DropDownAreas.SelectedValue.ToString();
            String Turno = DropDownList1.SelectedValue.ToString();


            TextBox txtOF = TextBoxInsOF0;
            txtOF.Text = getNewOF();
            DropDownList DropDownMaterial = DropDownListMaterial0;
            String txtMaterial = DropDownMaterial.SelectedValue.ToString();
            TextBox txtCantidadPlanif = TextBoxCantidadPlanif0;
            DropDownList DropDownListPrio = DropDownListPrio0;
            String txtListPrio = DropDownListPrio.SelectedValue.ToString();
            TextBox txtFechaLot = TextBoxFechaLot0;
            TextBox txtObs = TextBoxObs0;
            String duracion = getDuracionOF(txtMaterial, txtCantidadPlanif.Text.ToString());
            String insValues = " VALUES ('" + txtOF.Text.Trim() + "','" + FechaProd.Trim() + "','" + Area.Trim() + "','" + Turno.Trim() + "','" + txtMaterial.Trim() + "'," + txtCantidadPlanif.Text.Trim() + "," + duracion +",'" + txtListPrio.Trim() + "','" + txtFechaLot.Text.Trim() + "','" + txtObs.Text.Trim() + "')";
            String insComm = "INSERT INTO [OrdenesFabricacion] ([OrdenFab],[FechaPlanif],[Area],[Turno],[Material],[CantidadPlanif],[TiempoPlanif],[Prioridad],[Fecha Lote],[Observaciones])" + insValues;
            con = new SqlConnection(BopDBOrdenesFab.ConnectionString);
            cmd.Connection = con;
            con.Open();
            try
            {

                cmd.CommandText = insComm;
                cmd.ExecuteNonQuery();
                GridView1.DataBind();
                if (GridView1.Rows.Count > 0)
                {
                    EmptyPanel.Visible = false;
                }
                else
                {
                    EmptyPanel.Visible = true;
                }
            }
            catch (SqlException exception)
            {
                if (exception.Number == 2601) // Cannot insert duplicate key row in object error
                {
                    return;
                }

            }
        }

        protected void ButtonBuscar_Click(object sender, EventArgs e)
        {
            GridView1.DataBind();
            if (GridView1.Rows.Count > 0)
            {
                EmptyPanel.Visible = false;
            }
            else
            {
                EmptyPanel.Visible = true;
            }
        }

        protected String getNewOF()
        {
            String folioOF = "0";
            SqlConnection sqlConnection = new SqlConnection(BopDBOrdenesFab.ConnectionString);
            String SQLQuery = "exec p_secuencia_OF;select dbo.f_secuencia_OF() as folio";
            SqlCommand command = new SqlCommand(SQLQuery, sqlConnection);
            SqlDataReader Dr;
            sqlConnection.Open();
            Dr = command.ExecuteReader();
            Dr.Read();
            folioOF = Dr["folio"].ToString();
            Dr.Close();
            return folioOF;
        }

        protected String getDuracionOF(String Material, String Cantidad)
        {
            String duracion;
            SqlConnection sqlConnection = new SqlConnection(BopDBOrdenesFab.ConnectionString);
            String SQLQuery = "select dbo.f_duracionOF('" + Material + "'," + Cantidad + ") as duracion";
            SqlCommand command = new SqlCommand(SQLQuery, sqlConnection);
            SqlDataReader Dr;
            sqlConnection.Open();
            Dr = command.ExecuteReader();
            Dr.Read();
            duracion = Dr["duracion"].ToString();
            Dr.Close();
            return duracion;
        }

        protected void TextBoxInsOF_Load(object sender, EventArgs e)
        {
            TextBox txtBoxInsOF;
            txtBoxInsOF = (TextBox)GridView1.FooterRow.FindControl("TextBoxInsOF");
            txtBoxInsOF.Text = getNewOF();
        }

        protected void GridView1_RowDataBound(Object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState == DataControlRowState.Edit)
            {
                DropDownList DropListProducto = (DropDownList)e.Row.FindControl("DropDownList2");
                String Producto = DropListProducto.SelectedValue.ToString();
                TextBox txtCantidadPlan = (TextBox)e.Row.FindControl("TextBox2");
                TextBox txtTiempoEst = (TextBox)e.Row.FindControl("TextBox3");
                String duracion = getDuracionOF(Producto.Trim(), txtCantidadPlan.Text.ToString().Trim());
                TextBox txtFechaPlanif = (TextBox)e.Row.FindControl("TextBoxFechaPlanif");
                txtFechaPlanif.Text = TextBoxFechaProd.Text;
                // At this point, you can change the value as normal
                txtTiempoEst.Text = duracion;
            }
        }

        protected void TextBoxInsOF0_PreRender(object sender, EventArgs e)
        {
            TextBoxInsOF0.Text = getNewOF();
        }

        protected void BT_Nuevo_Click1(object sender, ImageClickEventArgs e)
        {

        }



    }
}