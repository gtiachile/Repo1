using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace BitOp.Incidentes
{
    public partial class Modificacion_Incidente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
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
                SelPlanta.Text = row["Planta"].ToString();
                lblEquipo.Text = row["DscEquipo"].ToString();
                lblCodEquipo.Text = row["Equipo"].ToString();
                lblTurno.Text = row["TurnoDsc"].ToString();
                lblNivRegDet.Text = row["NivelRegDetencion"].ToString();
                lblDiasAtr.Text = row["DiasAtrasoReg"].ToString();
                lblUsuario.Text = row["Usuario"].ToString();
                if (lblNivRegDet.Text == "Planta")
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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = GridView1.SelectedIndex;
            Label lblIncidente = (Label)GridView1.Rows[i].FindControl("lblIncidente");
            SelIncidente.Text = lblIncidente.Text;
            FormView1.DataBind();
            ButtonModificar.Enabled = true;
        }

        protected void ButtonModificar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;

        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            GridView1.DataBind();
            MultiView1.ActiveViewIndex = 0;
        }

        protected void UpdateCancelButton_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }
    }
}