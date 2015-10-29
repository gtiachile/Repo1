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
    public partial class Configuracion_Planillas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);                  
            }
        }

        protected int getNewPlanilla()
        {
            {

                System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
                System.Configuration.ConnectionStringSettings connString;
                connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

                int res = 1;
                using (SqlConnection conn = new SqlConnection(connString.ToString()))
                {
                    using (SqlCommand comm = new SqlCommand("dbo.p_secuencia_Planillas", conn))
                    {
                        comm.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        comm.ExecuteNonQuery();
                        conn.Close();
                    }

                    using (SqlCommand comm = new SqlCommand("dbo.f_secuencia_Planilla", conn))
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

        protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Values["NroPlanilla"] = getNewPlanilla().ToString();
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {

            int i = GridView2.SelectedIndex;
            Label NroPlanilla = (Label)GridView2.Rows[i].FindControl("NroPlanilla");
            lblNroPlanillaSel.Text = NroPlanilla.Text;
            MultiView1.ActiveViewIndex = 1;
        }

        protected void FormView2_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Values["NroPlanilla"] = lblNroPlanillaSel.Text;
            e.Values["Linea"] = Get_Linea_Planilla(Convert.ToInt16(lblNroPlanillaSel.Text));
        }

        protected int Get_Linea_Planilla(int NroPlanilla)
        {

            System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
            System.Configuration.ConnectionStringSettings connString;
            connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

            int res = 1;
            using (SqlConnection conn = new SqlConnection(connString.ToString()))
            {
                using (SqlCommand comm = new SqlCommand("dbo.f_nueva_linea_planilla", conn))
                {
                    comm.CommandType = CommandType.StoredProcedure;

                    SqlParameter p1 = new SqlParameter("@NroPlanilla", SqlDbType.BigInt);
                    // You can call the return value parameter anything, .e.g. "@Result".
                    SqlParameter p2 = new SqlParameter("@Result", SqlDbType.Int);

                    p1.Direction = ParameterDirection.Input;
                    p2.Direction = ParameterDirection.ReturnValue;

                    p1.Value = NroPlanilla;

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

        protected void Button1_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }
    }
}