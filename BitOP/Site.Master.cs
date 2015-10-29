using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace BitOP
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
                ViewState["LoginErrors"] = 0;
        }


        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            if (YourValidationFunction(Login1.UserName, Login1.Password))
            {

                SqlConnection sqlConnection = new SqlConnection(BopDBLogin.ConnectionString);
                String SQLQuery = "SELECT * FROM Usuarios where estado = 'Activo' and rtrim(Usuario)='" + Login1.UserName.ToString().Trim() + "'";
                SqlCommand command = new SqlCommand(SQLQuery, sqlConnection);
                SqlDataReader Dr;
                sqlConnection.Open();
                Dr = command.ExecuteReader();
                Dr.Read();
                String Perfil = Dr["Perfil"].ToString().Trim();
                String Usuario = Dr["Usuario"].ToString();
                String Nombre = Dr["Nombre"].ToString().Trim();
                getMenu(Perfil);
                Dr.Close();
//                UsuarioLogged.Text = Nombre;
                Global.Perfil = Perfil;
                Global.Usuario = Usuario;
                Global.Nombre = Nombre;
                Login1.Visible = false;
            }
            else
            {
                e.Authenticated = false;
            }
        }
        protected void Login1_LoginError(object sender, EventArgs e)
        {

            if (ViewState["LoginErrors"] == null)
                ViewState["LoginErrors"] = 0;

            int ErrorCount = (int)ViewState["LoginErrors"] + 1;
            ViewState["LoginErrors"] = ErrorCount;

            if ((ErrorCount > 3) && (Login1.PasswordRecoveryUrl != string.Empty))
                Response.Redirect(Login1.PasswordRecoveryUrl);
        }

        protected bool YourValidationFunction(string UserName, string Password)
        {
            bool boolReturnValue = false;

            SqlConnection sqlConnection = new SqlConnection(BopDBLogin.ConnectionString);
            String SQLQuery = "SELECT rtrim(Usuario) as Usuario, rtrim(Pass) as Pass FROM Usuarios where estado = 'Activo' and rtrim(Usuario)='" + UserName.ToString().Trim() + "'";
            SqlCommand command = new SqlCommand(SQLQuery, sqlConnection);
            SqlDataReader Dr;
            sqlConnection.Open();
            Dr = command.ExecuteReader();
            while (Dr.Read())
            {

                if ((UserName.Trim() == Dr["Usuario"].ToString().Trim()) & (Password.Trim() == Dr["Pass"].ToString().Trim()))
                {
                    boolReturnValue = true;
                }
                Dr.Close();
                return boolReturnValue;
            }
            return boolReturnValue;
        }


        private void getMenu(string perfil)
        {
            SqlConnection con;
            SqlCommand cmd = new SqlCommand();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            con = new SqlConnection(BopDBLogin.ConnectionString);
            cmd.Connection = con;
            con.Open();
            string sql = "SELECT * FROM [V_MENUS] Where [Perfil]='" + perfil + "'";
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            da.Fill(ds);
            dt = ds.Tables[0];
            AddTopMenuItems(dt);
            con.Close();

        }


        private void AddTopMenuItems(DataTable menuData)
        {
            DataView view = null;
            try
            {
                view = new DataView(menuData);
                view.RowFilter = "ParentID = 0";
                foreach (DataRowView row in view)
                {
                    //Adding the menu item
                    MenuItem newMenuItem = new MenuItem(row["Text"].ToString(), row["MenuID"].ToString());
                    NavigationMenu.Items.Add(newMenuItem);
                    //Calling the function to add the child menu items
                    AddChildMenuItems(menuData, newMenuItem); //This function will add child menu items to your menu control.
                }
            }
            catch (Exception ex)
            {
                //Show the error massage here
            }
            finally
            {
                view = null;
            }
        }

        private void AddChildMenuItems(DataTable menuData, MenuItem parentMenuItem)
        {
            DataView view = null;
            try
            {
                view = new DataView(menuData);
                view.RowFilter = "ParentID=" + parentMenuItem.Value;
                foreach (DataRowView row in view)
                {
                    MenuItem newMenuItem = new MenuItem(row["Text"].ToString(), row["MenuID"].ToString());
                    newMenuItem.NavigateUrl = row["NavigateUrl"].ToString();
                    parentMenuItem.ChildItems.Add(newMenuItem);
                    // This code is used to recursively add child menu items filtering by ParentID
                    AddChildMenuItems(menuData, newMenuItem);
                }
            }
            catch (Exception ex)
            {
                //Show the error massage here
            }
            finally
            {
                view = null;
            }
        }

        protected void btCerrarSesion_Click(object sender, EventArgs e)
        {
            NavigationMenu.Visible = false;
            Login1.Visible = true;
            Session.Clear();
            Session.Abandon();
        }

        
    }
}
