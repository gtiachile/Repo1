<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menus.aspx.cs" Inherits="BitOp.Admin.Menus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 226px;
            border-style: solid;
            border-width: 1px;
            padding: 1px 4px;
        }
        .auto-style3 {
            width: 239px;
            border-style: solid;
            border-width: 1px;
            padding: 1px 4px;
        }
        .auto-style4 {
            border-style: solid;
            border-width: 1px;
            padding: 1px 4px;
        }
        .auto-style5 {
            border-width: 1px;
            padding: 1px 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        MENUS</p>
    <p>
        Perfil:
        <asp:DropDownList ID="DropDownPerfil" runat="server" DataSourceID="BopDBPerfiles" DataTextField="Descripción" DataValueField="Perfil">
        </asp:DropDownList>
        <asp:SqlDataSource ID="BopDBPerfiles" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Perfil], [Descripción] FROM [Perfiles] where estado='Activo'"></asp:SqlDataSource>
    </p>
    <p>
        <table style="width: 75%;">
            <tr>
                <td class="auto-style1" rowspan="2" valign="top">Módulo:<br class="auto-style4" />
                    <asp:DropDownList ID="DropDownListModulo" runat="server" DataSourceID="BopDBModulos" DataTextField="Descripción" DataValueField="Modulo">
                    </asp:DropDownList>
                    <br class="auto-style4" />
                    <asp:Button ID="ButtonAgrModulo" runat="server" Text="Agregar" OnClick="ButtonAgrModulo_Click" />
                    <asp:SqlDataSource ID="BopDBModulos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [Modulos] where estado='Activo'"></asp:SqlDataSource>
                    <br />
                </td>
                <td class="auto-style3" valign="top">Menu:<br class="auto-style4" />
                    <asp:DropDownList ID="DropDownListMenu" runat="server" DataSourceID="BopDBOpcionesMenu" DataTextField="Descripción" DataValueField="Opcion">
                    </asp:DropDownList>
                    <br class="auto-style4" />
                    <asp:Button ID="ButtonAgrMenu" runat="server" style="margin-bottom: 0px" Text="Agregar" OnClick="ButtonAgrMenu_Click" />
                    <asp:SqlDataSource ID="BopDBOpcionesMenu" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Opcion], [Descripción] FROM [Opciones] where estado='Activo' and tipo='Menu' order by modulo,opcion"></asp:SqlDataSource>
                </td>
                <td class="auto-style5" rowspan="2" style="border-style: solid" valign="top">Opción:<br class="auto-style4" />
                    <asp:DropDownList ID="DropDownListOpcionPagN2" runat="server" DataSourceID="BopDBOpcionPagN2" DataTextField="Descripción" DataValueField="Opcion">
                    </asp:DropDownList>
                    <br class="auto-style4" />
                    <asp:Button ID="ButtonAgrOpcionN2" runat="server" Text="Agregar" OnClick="ButtonAgrOpcionN2_Click" />
                    <asp:SqlDataSource ID="BopDBOpcionPagN2" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Opcion], [Descripción] FROM [Opciones] where estado='Activo' and tipo='Pagina' order by modulo,opcion"></asp:SqlDataSource>
                    <br />
                    <asp:Label ID="ModuloSel" runat="server" Text="Modulo" Visible="False"></asp:Label>
                    &nbsp;<asp:Label ID="OpcionSel" runat="server" Text="Opcion" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style3" valign="top">Opción:<br class="auto-style4" />
                    <asp:DropDownList ID="DropDownOpcionPag_N1" runat="server" DataSourceID="BopDBOpcionesPag_N1" DataTextField="Descripción" DataValueField="Opcion">
                    </asp:DropDownList>
                    <br class="auto-style4" />
                    <asp:Button ID="ButtonAgrOpcion" runat="server" Text="Agregar" OnClick="ButtonAgrOpcion_Click" />
                    <asp:SqlDataSource ID="BopDBOpcionesPag_N1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Opcion], [Descripción] FROM [Opciones] where estado='Activo' and tipo='Pagina' order by modulo,opcion"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Nivel 0</td>
                <td class="auto-style3">Nivel 1</td>
                <td class="auto-style5" style="border-style: solid" valign="top">Nivel 2</td>
            </tr>
            <tr>
                <td class="auto-style1" valign="top">
                    <asp:GridView ID="GridViewMenu_N0" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="auto-style5" DataKeyNames="Perfil,Posicion,Modulo" DataSourceID="BopDBMenu_N0" OnSelectedIndexChanged="GridViewMenu_N0_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Images/DeleteHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="Perfil" HeaderText="Perfil" ReadOnly="True" SortExpression="Perfil" Visible="False" />
                            <asp:BoundField DataField="Posicion" HeaderText="Posicion" ReadOnly="True" SortExpression="Posicion" />
                            <asp:TemplateField HeaderText="Modulo" SortExpression="Modulo">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Modulo") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Modulo" runat="server" Text='<%# Bind("Modulo") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <selectedrowstyle backcolor="#4B6C9E"
                            forecolor="#CCCCCC"
                            font-bold="False"/> 
                    </asp:GridView>
                    <asp:SqlDataSource ID="BopDBMenu_N0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Menu_N0] WHERE [Perfil] = @Perfil AND [Posicion] = @Posicion AND [Modulo] = @Modulo" InsertCommand="INSERT INTO [Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (@Perfil, @Posicion, @Modulo)" SelectCommand="SELECT * FROM [Menu_N0] WHERE ([Perfil] = @Perfil)">
                        <DeleteParameters>
                            <asp:Parameter Name="Perfil" Type="String" />
                            <asp:Parameter Name="Posicion" Type="Int32" />
                            <asp:Parameter Name="Modulo" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Perfil" Type="String" />
                            <asp:Parameter Name="Posicion" Type="Int32" />
                            <asp:Parameter Name="Modulo" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownPerfil" Name="Perfil" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="auto-style3" valign="top">
                    <asp:GridView ID="GridViewMenu_N1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="auto-style5" DataKeyNames="Perfil,Modulo,Posicion,Opcion" DataSourceID="BopDBMenu_N1" OnSelectedIndexChanged="GridViewMenu_N1_SelectedIndexChanged">
                        <Columns>
                            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Images/DeleteHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowSelectButton="True" />
                            <asp:BoundField DataField="Perfil" HeaderText="Perfil" ReadOnly="True" SortExpression="Perfil" Visible="False" />
                            <asp:BoundField DataField="Modulo" HeaderText="Modulo" ReadOnly="True" SortExpression="Modulo" Visible="False" />
                            <asp:BoundField DataField="Posicion" HeaderText="Posicion" ReadOnly="True" SortExpression="Posicion" />
                            <asp:TemplateField HeaderText="Opcion" SortExpression="Opcion">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Opcion") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Opcion" runat="server" Text='<%# Bind("Opcion") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <SelectedRowStyle BackColor="#4B6C9E" ForeColor="#CCCCCC" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="BopDBMenu_N1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Menu_N1] WHERE [Perfil] = @Perfil AND [Modulo] = @Modulo AND [Posicion] = @Posicion AND [Opcion] = @Opcion" InsertCommand="INSERT INTO [Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (@Perfil, @Modulo, @Posicion, @Opcion)" SelectCommand="SELECT [Perfil], [Modulo], [Posicion], [Opcion] FROM [Menu_N1] WHERE ([Perfil] = @Perfil and [Modulo]=@Modulo)">
                        <DeleteParameters>
                            <asp:Parameter Name="Perfil" Type="String" />
                            <asp:Parameter Name="Modulo" Type="String" />
                            <asp:Parameter Name="Posicion" Type="Int32" />
                            <asp:Parameter Name="Opcion" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Perfil" Type="String" />
                            <asp:Parameter Name="Modulo" Type="String" />
                            <asp:Parameter Name="Posicion" Type="Int32" />
                            <asp:Parameter Name="Opcion" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownPerfil" Name="Perfil" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="ModuloSel" Name="Modulo" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="auto-style5" style="border-style: solid" valign="top">
                    <asp:GridView ID="GridViewMenu_N2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="auto-style5" DataKeyNames="Perfil,Modulo,Posicion,Opcion1,Opcion2" DataSourceID="BopDBMenu_N2">
                        <Columns>
                            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Images/DeleteHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" />
                            <asp:BoundField DataField="Perfil" HeaderText="Perfil" ReadOnly="True" SortExpression="Perfil" Visible="False" />
                            <asp:BoundField DataField="Modulo" HeaderText="Modulo" ReadOnly="True" SortExpression="Modulo" Visible="False" />
                            <asp:BoundField DataField="Posicion" HeaderText="Posicion" ReadOnly="True" SortExpression="Posicion" />
                            <asp:BoundField DataField="Opcion1" HeaderText="Opcion1" ReadOnly="True" SortExpression="Opcion1" Visible="False" />
                            <asp:BoundField DataField="Opcion2" HeaderText="Opcion2" ReadOnly="True" SortExpression="Opcion2" />
                        </Columns>
                        <SelectedRowStyle BackColor="#4B6C9E" ForeColor="#CCCCCC" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="BopDBMenu_N2" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Menu_N2] WHERE [Perfil] = @Perfil AND [Modulo] = @Modulo AND [Posicion] = @Posicion AND [Opcion1] = @Opcion1 AND [Opcion2] = @Opcion2" InsertCommand="INSERT INTO [Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (@Perfil, @Modulo, @Posicion, @Opcion1, @Opcion2)" SelectCommand="SELECT * FROM [Menu_N2] WHERE ([Perfil] = @Perfil and [Modulo] = @Modulo and Opcion1 = @Opcion)">
                        <DeleteParameters>
                            <asp:Parameter Name="Perfil" Type="String" />
                            <asp:Parameter Name="Modulo" Type="String" />
                            <asp:Parameter Name="Posicion" Type="Int32" />
                            <asp:Parameter Name="Opcion1" Type="String" />
                            <asp:Parameter Name="Opcion2" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Perfil" Type="String" />
                            <asp:Parameter Name="Modulo" Type="String" />
                            <asp:Parameter Name="Posicion" Type="Int32" />
                            <asp:Parameter Name="Opcion1" Type="String" />
                            <asp:Parameter Name="Opcion2" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownPerfil" Name="Perfil" PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="ModuloSel" Name="Modulo" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="OpcionSel" Name="Opcion" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </p>
</asp:Content>
