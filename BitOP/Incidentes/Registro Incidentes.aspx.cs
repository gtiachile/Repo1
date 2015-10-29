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
    public partial class Registro_Inicidentes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack != true)
            {
                BitOP.Global.MenuControl.getMenu((Menu)Master.FindControl("NavigationMenu"), (Login)Master.FindControl("Login1"), BitOP.Global.Perfil);
                lblFecha.Text = DateTime.Today.ToString("dd-MM-yyyy");
                lblResponsable.Text = BitOP.Global.Nombre;
                Fill_User_Header();
                TextBox txtInicio = (TextBox)FormView1.FindControl("Hora_IncidenteTextBox0");
                txtInicio.Text = DateTime.Now.ToString("hh:mm");
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

        protected int getNewIncidente()
        {
            {

                System.Configuration.Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
                System.Configuration.ConnectionStringSettings connString;
                connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];

                int res = 1;
                using (SqlConnection conn = new SqlConnection(connString.ToString()))
                {
                    using (SqlCommand comm = new SqlCommand("dbo.p_secuencia_incidente", conn))
                    {
                        comm.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        comm.ExecuteNonQuery();
                        conn.Close();
                    }

                    using (SqlCommand comm = new SqlCommand("dbo.f_secuencia_incidente", conn))
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


        protected void TreeView1_TreeNodePopulate(object sender, TreeNodeEventArgs e)
        {
            if (e.Node.ChildNodes.Count == 0)
            {
                switch (e.Node.Depth)
                {
                    case 0:
                        PopulatePlantas(e.Node);
                        break;
                    case 1:
                        PopulateAreas(e.Node);
                        break;
                    case 2:
                        PopulateProcesos(e.Node);
                        break;
                }
            }
        }


        void PopulatePlantas(TreeNode node)
        {
            SqlCommand sqlQuery = new SqlCommand(
                "Select [Descripción], Planta From Plantas");
            DataSet resultSet;
            resultSet = RunQuery(sqlQuery);
            if (resultSet.Tables.Count > 0)
            {
                foreach (DataRow row in resultSet.Tables[0].Rows)
                {
                    TreeNode NewNode = new
                        TreeNode(row["Descripción"].ToString(),
                        row["Planta"].ToString());
                    NewNode.PopulateOnDemand = true;
                    NewNode.SelectAction = TreeNodeSelectAction.SelectExpand;
                    node.ChildNodes.Add(NewNode);
                }
            }
        }

        void PopulateAreas(TreeNode node)
        {
            SqlCommand sqlQuery = new SqlCommand();
            sqlQuery.CommandText = "Select [Descripción],Area From Areas " +
                " Where Planta = @Planta";
            sqlQuery.Parameters.Add("@Planta", SqlDbType.VarChar).Value =
                node.Value;
            DataSet ResultSet = RunQuery(sqlQuery);
            if (ResultSet.Tables.Count > 0)
            {
                foreach (DataRow row in ResultSet.Tables[0].Rows)
                {
                    TreeNode NewNode = new
                        TreeNode(row["Descripción"].ToString(),row["Area"].ToString());
                    NewNode.PopulateOnDemand = true;
                    NewNode.SelectAction = TreeNodeSelectAction.SelectExpand;
                    node.ChildNodes.Add(NewNode);
                }
            }
        }

        void PopulateProcesos(TreeNode node)
        {
            SqlCommand sqlQuery = new SqlCommand();
            sqlQuery.CommandText = "Select [Descripción], Proceso From Procesos " +
                " Where Area = @Area";
            sqlQuery.Parameters.Add("@Area", SqlDbType.VarChar).Value =
                node.Value;
            DataSet ResultSet = RunQuery(sqlQuery);
            if (ResultSet.Tables.Count > 0)
            {
                foreach (DataRow row in ResultSet.Tables[0].Rows)
                {
                    TreeNode NewNode = new
                        TreeNode(row["Descripción"].ToString(), row["Proceso"].ToString());
                    NewNode.PopulateOnDemand = true;
                    NewNode.SelectAction = TreeNodeSelectAction.Select;
                    node.ChildNodes.Add(NewNode);
                }
            }
        }

        private DataSet RunQuery(SqlCommand sqlQuery)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings
                ["BopDBConnectionString"].ConnectionString;
            SqlConnection DBConnection =
                new SqlConnection(connectionString);
            SqlDataAdapter dbAdapter = new SqlDataAdapter();
            dbAdapter.SelectCommand = sqlQuery;
            sqlQuery.Connection = DBConnection;
            DataSet resultsDataSet = new DataSet();
            try
            {
                dbAdapter.Fill(resultsDataSet);
            }
            catch
            {
                labelStatus.Text = "Unable to connect to SQL Server.";
                labelStatus.Visible = true;
            }
            return resultsDataSet;
        }

        protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Values["Incidente"] = getNewIncidente().ToString();
            e.Values["Usuario"] = BitOP.Global.Usuario;
            e.Values["Planta"] = SelPlanta.Text;
            e.Values["Area"] = SelArea.Text;
            e.Values["Proceso"] = SelProceso.Text;

        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
                Panel1.Visible = true;
                switch (TreeView1.SelectedNode.Depth)
                {
                    case 1:
                        SelPlanta.Text = TreeView1.SelectedNode.Value.ToString();
                        SelArea.Text = "";
                        break;
                    case 2:
                        SelArea.Text = TreeView1.SelectedNode.Value.ToString();
                        SelPlanta.Text = TreeView1.SelectedNode.Parent.Value.ToString();
                        SelProceso.Text = "";
                        break;
                    case 3:
                        SelProceso.Text = TreeView1.SelectedNode.Value.ToString();
                        SelArea.Text = TreeView1.SelectedNode.Parent.Value.ToString();
                        SelPlanta.Text = TreeView1.SelectedNode.Parent.Parent.Value.ToString();
                        break;
                }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            TextBox txtInicio = (TextBox)FormView1.FindControl("Hora_IncidenteTextBox0");
            txtInicio.Text = DateTime.Now.ToString("hh:mm");
        }



    }
}