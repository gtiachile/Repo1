using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;

namespace BitOP
{
    public class Global : System.Web.HttpApplication
    {
        static string _perfil;
        static string _usuario;
        static string _nombre;

        /// <summary>
        /// Get or set the static important data.
        /// </summary>
        public static string Perfil
        {
            get
            {
                return _perfil;
            }
            set
            {
                _perfil = value;
            }
        }

        public static string Usuario
        {
            get
            {
                return _usuario;
            }
            set
            {
                _usuario = value;
            }
        }

        public static string Nombre
        {
            get
            {
                return _nombre;
            }
            set
            {
                _nombre = value;
            }
        }


        public static class MenuControl
        {
            static MenuControl() { } //default constructor to auto initialize the class
            public static void getMenu(Menu NavigationMenu, Login LoginControl, string perfil) //Test function
            {
                LoginControl.Visible = false;
                SqlConnection con;
                SqlCommand cmd = new SqlCommand();
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                System.Configuration.Configuration rootWebConfig =  System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("/BitOp");
                System.Configuration.ConnectionStringSettings connString;
                connString = rootWebConfig.ConnectionStrings.ConnectionStrings["BopDBConnectionString"];
                con = new SqlConnection(connString.ToString());
                cmd.Connection = con;
                con.Open();
                string sql = "SELECT * FROM [V_MENUS] Where [Perfil]='" + perfil + "'";
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                da.Fill(ds);
                dt = ds.Tables[0];
                NavigationMenu.Items.Clear();
                AddTopMenuItems(NavigationMenu, dt);
                con.Close();
            }

            private static void AddTopMenuItems(Menu NavigationMenu, DataTable menuData)
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

            private static void AddChildMenuItems(DataTable menuData, MenuItem parentMenuItem)
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

        }
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup

        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started

        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.

        }

    }
}
