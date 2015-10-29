using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace BitOp.Detenciones
{
    public partial class Detenciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack!=true)
            {
                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);
                lblFecha.Text = DateTime.Today.ToString("dd-MM-yyyy");
                lblResponsable.Text = BitOP.Global.Nombre;
                Fill_User_Header();
            }

        }

        protected void Fill_User_Header()
        {
            DataView view = null;
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
            System.Configuration.ConnectionStringSettings connString;
            connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];
            con = new SqlConnection(connString.ToString());
            cmd.Connection = con;
            con.Open();
            string sql = @"SELECT        TOP (1) UsuarioFuncion.Usuario, UsuarioFuncion.Funcion, UsuarioFuncion.Area, UsuarioFuncion.Turno, Areas.Descripción AS AreaDsc, Plantas.Descripción AS PlantaDsc, TurnoPlanta.Descripción AS TurnoDsc, 
                         Equipos.Descripción AS DscEquipo, Equipos.Equipo, UsuarioFuncion.NivelRegDetencion, UsuarioFuncion.DiasAtrasoReg, Plantas.Planta, Equipos.Proceso
                         FROM UsuarioFuncion INNER JOIN
                         Areas ON UsuarioFuncion.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta INNER JOIN
                         TurnoPlanta ON UsuarioFuncion.Turno = TurnoPlanta.Codigo INNER JOIN
                         Equipos ON UsuarioFuncion.Equipo = Equipos.Equipo WHERE
                         UsuarioFuncion.Usuario = '" + BitOP.Global.Usuario + "'";
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            da.Fill(ds);
            dt = ds.Tables[0];
            view = new DataView(dt);
            foreach (DataRowView row in view)
            {
                
                lblCargo.Text = row["Funcion"].ToString();
                lblArea.Text = row["AreaDsc"].ToString();
                lblPlanta.Text = row["PlantaDsc"].ToString();
                lblEquipo.Text = row["DscEquipo"].ToString();
                lblCodEquipo.Text = row["Equipo"].ToString();
                lblTurno.Text = row["TurnoDsc"].ToString();
                lblNivRegDet.Text = row["NivelRegDetencion"].ToString();
                lblDiasAtr.Text = row["DiasAtrasoReg"].ToString();
                lblUsuario.Text = row["Usuario"].ToString();
                if  (lblNivRegDet.Text == "Planta")
                {
                    lblLocalizacion.Text = row["Planta"].ToString();
                }
                if (lblNivRegDet.Text == "Area")
                {
                    lblLocalizacion.Text = row["Area"].ToString();
                }
                if (lblNivRegDet.Text == "Proceso")
                {
                    lblLocalizacion.Text = row["Proceso"].ToString();
                }
                if (lblNivRegDet.Text == "Equipo")
                {
                    lblLocalizacion.Text = row["Equipo"].ToString();
                }
            }
            con.Close();

        }


        protected int getNewDetencion()
        {
            {

                System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
                System.Configuration.ConnectionStringSettings connString;
                connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

                int res = 1;
                using (SqlConnection conn = new SqlConnection(connString.ToString()))
                {
                    using (SqlCommand comm = new SqlCommand("dbo.p_secuencia_detencion", conn))
                    {
                        comm.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        comm.ExecuteNonQuery();
                        conn.Close();
                    }

                    using (SqlCommand comm = new SqlCommand("dbo.f_secuencia_detencion", conn))
                    {

                        SqlParameter p2 = new SqlParameter("@Result", SqlDbType.BigInt);

                        p2.Direction = ParameterDirection.ReturnValue;
                        comm.Parameters.Add(p2);
                        comm.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        comm.ExecuteNonQuery();
                        if (p2.Value != DBNull.Value)
                            res = Convert.ToInt16(p2.Value);
                        conn.Close();
                    }
                }
                return res;
            }
        }

        protected void FormViewDetencion_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Values["NroDetencion"] = getNewDetencion().ToString();
            e.Values["FechaGrabacion"] = DateTime.Today.ToString();
            e.Values["Usuario"] = BitOP.Global.Usuario;

        }

        protected void FormViewDetencion_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState == DataControlRowState.Edit)
            {
                TextBox txtUsuario = (TextBox)e.Row.FindControl("txtUsuario");
                txtUsuario.Text = BitOP.Global.Usuario;
                TextBox txtFechaMod = (TextBox)e.Row.FindControl("txtFechaMod");
                txtFechaMod.Text = DateTime.Now.ToString();
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            TextBox txtInicio = (TextBox)FormViewDetencion.FindControl("InicioDetencionTextBox");
            txtInicio.Text = DateTime.Now.ToString("hh:mm");
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            TextBox txtFin = (TextBox)FormViewDetencion.FindControl("FinDetencionTextBox");
            txtFin.Text = DateTime.Now.ToString("hh:mm");
        }

    }
}