<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UsuarioFuncion.aspx.cs" Inherits="BitOp.Admin.UsuarioFuncion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style11 {
            width: 63px;
        }
        .auto-style12 {
            width: 240px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        ASIGNACION FUNCIONES USUARIO OPERACIONES</p>
    <p>
        <table style="width: 100%;">
            <tr>
                <td valign="top">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Usuario" DataSourceID="BopDBUsuarioFuncion" DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" OnItemInserted="FormView1_ItemInserted" Width="1147px">
                        <EditItemTemplate>
                            Usuario:
                            <asp:Label ID="UsuarioLabel1" runat="server" Text='<%# Eval("Usuario") %>' />
                            <br />
                            Funcion:
                            <asp:TextBox ID="FuncionTextBox" runat="server" Text='<%# Bind("Funcion") %>' />
                            <br />
                            Area:
                            <asp:TextBox ID="AreaTextBox" runat="server" Text='<%# Bind("Area") %>' />
                            <br />
                            Turno:
                            <asp:TextBox ID="TurnoTextBox" runat="server" Text='<%# Bind("Turno") %>' />
                            <br />
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table style="border-width: thin; border-style: solid; width:100%;">
                                <tr>
                                    <td class="auto-style11">Usuario:</td>
                                    <td class="auto-style12">
                                        <asp:DropDownList ID="DropDownListUsuario" runat="server" DataSourceID="BopDBUsuarios" DataTextField="Nombre" DataValueField="Usuario">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Usuario], [Nombre] FROM [Usuarios] where Estado='Activo'"></asp:SqlDataSource>
                                    </td>
                                    <td>Planta:</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListPlanta" runat="server" AutoPostBack="True" DataSourceID="BopDBPlantas" DataTextField="Descripción" DataValueField="Planta">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBPlantas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas] WHERE ([Centro] = @Centro) and Estado='Activo'">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownListCentro" Name="Centro" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>Equipo:</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListEquipo" runat="server" DataSourceID="BopDBEquipos" DataTextField="Descripción" DataValueField="Equipo">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBEquipos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Equipo], [Descripción] FROM [Equipos] WHERE ([Proceso] = @Proceso and Estado='Activo')">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownListProceso" Name="Proceso" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>Días Permitidos<br />Actualización</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListDiasPerm" runat="server">
                                            <asp:ListItem>0</asp:ListItem>
                                            <asp:ListItem>1</asp:ListItem>
                                            <asp:ListItem>2</asp:ListItem>
                                            <asp:ListItem>3</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style11">Funcion:</td>
                                    <td class="auto-style12">
                                        <asp:TextBox ID="FuncionTextBox0" runat="server" Text='<%# Bind("Funcion") %>' MaxLength="50" Width="231px" />
                                    </td>
                                    <td>Area:</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListArea" runat="server" AutoPostBack="True" DataSourceID="BopDBAreas" DataTextField="Descripción" DataValueField="Area">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBAreas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas] WHERE ([Planta] = @Planta) and Estado='Activo'">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownListPlanta" Name="Planta" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>Nivel Registro Detenciones</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("NivelRegDetencion") %>'>
                                            <asp:ListItem>Planta</asp:ListItem>
                                            <asp:ListItem>Area</asp:ListItem>
                                            <asp:ListItem>Proceso</asp:ListItem>
                                            <asp:ListItem>Equipo</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style11">Centro:</td>
                                    <td class="auto-style12">
                                        <asp:DropDownList ID="DropDownListCentro" runat="server" AutoPostBack="True" DataSourceID="BopDBCentros" DataTextField="Descripción" DataValueField="Centro">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBCentros" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Centro], [Descripción] FROM [Centros] where Estado='Activo'"></asp:SqlDataSource>
                                    </td>
                                    <td>Proceso:</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListProceso" runat="server" AutoPostBack="True" DataSourceID="BopDBProcesos" DataTextField="Descripción" DataValueField="Proceso">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBProcesos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Proceso], [Descripción] FROM [Procesos] WHERE (Area = @Area and Estado='Activo')">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownListArea" Name="Area" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>Turno:</td>
                                    <td>
                                        <asp:DropDownList ID="DropDownListTurno" runat="server" DataSourceID="BopDBTurnos" DataTextField="Descripción" DataValueField="Codigo">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="BopDBTurnos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [Descripción] FROM [TurnoPlanta] WHERE ([Planta] = @Planta) and Estado='Activo'">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="DropDownListPlanta" Name="Planta" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style11">
                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                        &nbsp;</td>
                                    <td class="auto-style12">
                                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            Usuario:
                            <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Eval("Usuario") %>' />
                            <br />
                            Funcion:
                            <asp:Label ID="FuncionLabel" runat="server" Text='<%# Bind("Funcion") %>' />
                            <br />
                            Area:
                            <asp:Label ID="AreaLabel" runat="server" Text='<%# Bind("Area") %>' />
                            <br />
                            Turno:
                            <asp:Label ID="TurnoLabel" runat="server" Text='<%# Bind("Turno") %>' />
                            <br />
                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="BopDBUsuarioFuncion" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [UsuarioFuncion] WHERE [Usuario] = @Usuario" InsertCommand="p_ValidaInsertaUsuarioFuncion" SelectCommand="SELECT * FROM [UsuarioFuncion] " UpdateCommand="UPDATE [UsuarioFuncion] SET [Funcion] = @Funcion, [Area] = @Area, [Turno] = @Turno WHERE [Usuario] = @Usuario" InsertCommandType="StoredProcedure">
                        <DeleteParameters>
                            <asp:Parameter Name="Usuario" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Usuario" Type="String" />
                            <asp:Parameter Name="Funcion" Type="String" />
                            <asp:Parameter Name="eMail" Type="String" />
                            <asp:Parameter Name="Area" Type="String" />
                            <asp:Parameter Name="Turno" Type="String" />
                            <asp:Parameter Name="Proceso" />
                            <asp:Parameter Name="Equipo" />
                            <asp:Parameter Name="NivelRegDetencion" Type="String" />
                            <asp:Parameter Name="DiasAtrasoRef" Type="Int32" />
                            <asp:Parameter Name="Done" Type="Boolean" />
                            <asp:Parameter Name="Msg" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Funcion" Type="String" />
                            <asp:Parameter Name="Area" Type="String" />
                            <asp:Parameter Name="Turno" Type="String" />
                            <asp:Parameter Name="Usuario" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            </table>
<asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Usuario" DataSourceID="BopDBUsuarioFuncionDet" Width="100%">
                        <Columns>
                            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/Cancel(build)_194_32.bmp" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
                            <asp:BoundField DataField="Usuario" HeaderText="Usuario" ReadOnly="True" SortExpression="Usuario" />
                            <asp:TemplateField HeaderText="Funcion" SortExpression="Funcion">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" MaxLength="50" Text='<%# Bind("Funcion") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Funcion") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Area" SortExpression="Area">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BopDBAreaGV" DataTextField="Descripción" DataValueField="Area" SelectedValue='<%# Bind("Area") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBAreaGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas] where Estado='Activo'"></asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList8" runat="server" DataSourceID="BopDBAreaGVI" DataTextField="Descripción" DataValueField="Area" Enabled="False" SelectedValue='<%# Bind("Area") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBAreaGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Proceso" SortExpression="Proceso">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBProcesosGV" DataTextField="Descripción" DataValueField="Proceso" SelectedValue='<%# Bind("Proceso") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBProcesosGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Proceso], [Descripción] FROM [Procesos] where Estado='Activo'"></asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList9" runat="server" DataSourceID="BopDBProcesoGVI" DataTextField="Descripción" DataValueField="Proceso" Enabled="False" SelectedValue='<%# Bind("Proceso") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBProcesoGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Proceso], [Descripción] FROM [Procesos]"></asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBEquiposGV" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBEquiposGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Equipo], [Descripción] FROM [Equipos] where Estado='Activo'"></asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList10" runat="server" DataSourceID="BopDBEquipoGVI" DataTextField="Descripción" DataValueField="Equipo" Enabled="False">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBEquipoGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Niv.Reg.Det." SortExpression="NivelRegDetencion">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList6" runat="server" SelectedValue='<%# Bind("NivelRegDetencion") %>'>
                                        <asp:ListItem>Planta</asp:ListItem>
                                        <asp:ListItem>Area</asp:ListItem>
                                        <asp:ListItem>Proceso</asp:ListItem>
                                        <asp:ListItem>Equipo</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("NivelRegDetencion") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Días Atraso Reg." SortExpression="DiasAtrasoReg">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList11" runat="server" SelectedValue='<%# Bind("DiasAtrasoReg") %>'>
                                        <asp:ListItem>0</asp:ListItem>
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("DiasAtrasoReg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Turno" SortExpression="Turno">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="BopDBTurnosGV" DataTextField="Descripción" DataValueField="Codigo" SelectedValue='<%# Bind("Turno") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBTurnosGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [Descripción] FROM [TurnoPlanta]"></asp:SqlDataSource>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList12" runat="server" DataSourceID="BopDBTurnosPlantaGVI" DataTextField="Descripción" DataValueField="Codigo" SelectedValue='<%# Bind("Turno") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBTurnosPlantaGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [Descripción] FROM [TurnoPlanta]"></asp:SqlDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="#364E6F" ForeColor="#CCCCCC" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="BopDBUsuarioFuncionDet" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [UsuarioFuncion] WHERE [Usuario] = @Usuario" InsertCommand="INSERT INTO [UsuarioFuncion] ([Usuario], [Funcion], [Area], [Turno]) VALUES (@Usuario, @Funcion, @Area, @Turno)" SelectCommand="SELECT * FROM [UsuarioFuncion]" UpdateCommand="UPDATE [UsuarioFuncion] SET [Funcion] = @Funcion, [Area] = @Area, [Turno] = @Turno, [NivelRegDetencion] = @NivelRegDetencion, [DiasAtrasoReg]=@DiasAtrasoReg WHERE [Usuario] = @Usuario">
                        <DeleteParameters>
                            <asp:Parameter Name="Usuario" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Usuario" Type="String" />
                            <asp:Parameter Name="Funcion" Type="String" />
                            <asp:Parameter Name="Area" Type="String" />
                            <asp:Parameter Name="Turno" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Funcion" Type="String" />
                            <asp:Parameter Name="Area" Type="String" />
                            <asp:Parameter Name="Turno" Type="String" />
                            <asp:Parameter Name="NivelRegDetencion" />
                            <asp:Parameter Name="DiasAtrasoReg" />
                            <asp:Parameter Name="Usuario" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
    </p>
</asp:Content>
