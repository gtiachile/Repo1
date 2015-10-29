using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace BitOp.Produccion
{
    public partial class Notificacion : System.Web.UI.Page
    {
        bool carga_inicial = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (carga_inicial)
            {
                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);
                lblFecha.Text = DateTime.Today.ToString("dd-MM-yyyy");
                lblResponsable.Text = BitOP.Global.Nombre;
                Fill_User_Header();
                carga_inicial = false;  

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
                         Equipos.Descripción AS DscEquipo, Equipos.Equipo as Equipo
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
            }
            con.Close();
        
        }




        decimal _totalPlanificado = 0;
        decimal _totalProducido = 0;
        decimal _totalAvance = 0;
        decimal _totalMinsPlan = 0;
        decimal _totalMinsreal = 0;
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string planificado = ((Label)e.Row.FindControl("lblPlanificado")).Text;
                decimal iplanificado = Convert.ToDecimal(planificado);
                _totalPlanificado += iplanificado;
                string txtproducido = ((Label)e.Row.FindControl("lblProducido")).Text;
                decimal decproducido = Convert.ToDecimal(txtproducido);
                _totalProducido += decproducido;
                string minsPlan = ((Label)e.Row.FindControl("lblMinsPlanGV")).Text;
                decimal iminsPlan = Convert.ToDecimal(minsPlan);
                _totalMinsPlan += iminsPlan;
                string minsReal = ((Label)e.Row.FindControl("lblMinsrealGV")).Text;
                decimal iminsReal = Convert.ToDecimal(minsReal);
                _totalMinsreal += iminsReal;

            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotPlanificado = (Label)e.Row.FindControl("lblTotPlanificado");
                lblTotPlanificado.Text = _totalPlanificado.ToString("N0");
                Label lblTotProducido = (Label)e.Row.FindControl("lblTotProducido");
                lblTotProducido.Text = _totalProducido.ToString("N0");
                Label lblTotAvance = (Label)e.Row.FindControl("lblTotAvance");
                _totalAvance = (_totalProducido * 100) / _totalPlanificado;
                lblTotAvance.Text = _totalAvance.ToString("N1");
                Label lblMinsPlan = (Label)e.Row.FindControl("lblMinsPlan");
                lblMinsPlan.Text = _totalMinsPlan.ToString("N2");
                Label lblMinsReal = (Label)e.Row.FindControl("lblMinsReal");
                lblMinsReal.Text = _totalMinsreal.ToString("N2");


            }
        }

        protected void btNotificar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            btNotificar.Enabled = true;
            int i = GridView1.SelectedIndex;
            Label lblOF = (Label)GridView1.Rows[i].FindControl("lblOF");
            gvOF.Text = lblOF.Text;
            FormView1.DataBind();
        }

        protected void FormView2_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Values["OrdenFab"] = gvOF.Text.ToString();
            e.Values["Lote"] = Get_Next_OF_Lote(gvOF.Text.ToString()).ToString();
            e.Values["Usuario"] = BitOP.Global.Usuario;
            e.Values["Equipo"] = lblCodEquipo.Text.ToString();
            e.Values["FechaModificacion"] = DateTime.Now.ToString();


        }


        protected int Get_Next_OF_Lote(string OF)
        {

            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
            System.Configuration.ConnectionStringSettings connString;
            connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

            int res = 1;
            using (SqlConnection conn = new SqlConnection(connString.ToString()))
            {
                using (SqlCommand comm = new SqlCommand("dbo.f_lote_OF", conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter p1 = new SqlParameter("@OrdenFab", SqlDbType.VarChar);
                    // You can call the return value parameter anything, .e.g. "@Result".
                    SqlParameter p2 = new SqlParameter("@Result", SqlDbType.Int);

                    p1.Direction = ParameterDirection.Input;
                    p2.Direction = ParameterDirection.ReturnValue;

                    p1.Value = OF;

                    comm.Parameters.Add(p1);
                    comm.Parameters.Add(p2);

                    conn.Open();
                    comm.ExecuteNonQuery();

                    if (p2.Value != DBNull.Value)
                        res = Convert.ToInt16(p2.Value);
                }
            }
            return res;
        }

        protected int Get_Avance_OF(string OF)
        {

            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
            System.Configuration.ConnectionStringSettings connString;
            connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

            int res = 1;
            using (SqlConnection conn = new SqlConnection(connString.ToString()))
            {
                using (SqlCommand comm = new SqlCommand("dbo.f_avanceOF", conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter p1 = new SqlParameter("@OF", SqlDbType.VarChar);
                    // You can call the return value parameter anything, .e.g. "@Result".
                    SqlParameter p2 = new SqlParameter("@Result", SqlDbType.Int);

                    p1.Direction = ParameterDirection.Input;
                    p2.Direction = ParameterDirection.ReturnValue;

                    p1.Value = OF;

                    comm.Parameters.Add(p1);
                    comm.Parameters.Add(p2);

                    conn.Open();
                    comm.ExecuteNonQuery();

                    if (p2.Value != DBNull.Value)
                        res = Convert.ToInt16(p2.Value);
                }
            }
            return res;
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowState == DataControlRowState.Edit)
            {
                TextBox txtEquipo = (TextBox)e.Row.FindControl("txtEquipo");
                txtEquipo.Text = lblEquipo.Text;
                TextBox txtUsuario = (TextBox)e.Row.FindControl("txtUsuario");
                txtUsuario.Text = BitOP.Global.Usuario;
                TextBox txtFechaMod = (TextBox)e.Row.FindControl("txtFechaMod");
                txtFechaMod.Text = DateTime.Now.ToString();


            }
        }

        protected void FormView2_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {



            FormView1.DataBind();
            GridView1.DataBind();

        }


        protected void Elimina_OF(string OF, int Lote)
        {

            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
            System.Configuration.ConnectionStringSettings connString;
            connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

            int res = 1;
            using (SqlConnection conn = new SqlConnection(connString.ToString()))
            {
                using (SqlCommand comm = new SqlCommand("dbo.p_eliminaOF", conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter p1 = new SqlParameter("@OF", SqlDbType.VarChar);
                    // You can call the return value parameter anything, .e.g. "@Result".
                    SqlParameter p2 = new SqlParameter("@Lote", SqlDbType.Int);

                    p1.Direction = ParameterDirection.Input;
                    p2.Direction = ParameterDirection.Input;

                    p1.Value = OF;

                    comm.Parameters.Add(p1);
                    comm.Parameters.Add(p2);

                    conn.Open();
                    comm.ExecuteNonQuery();

                }
            }
            return;
        }
        

        protected void GridView2_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            FormView1.DataBind();
            GridView1.DataBind();
        }

        protected void FormView1_DataBound(object sender, EventArgs e)
        {


        }
    }
}