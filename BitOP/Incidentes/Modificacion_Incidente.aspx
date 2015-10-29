<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modificacion_Incidente.aspx.cs" Inherits="BitOp.Incidentes.Modificacion_Incidente" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

        .auto-style10 {
            width: 77px;
        }
        .auto-style11 {
            width: 203px;
        }
        .auto-style12 {
            width: 77px;
        }
        .auto-style45 {
            width: 132px;
        }
        .auto-style46 {
            width: 56px;
        }
        .auto-style47 {
            width: 70px;
        }
        .auto-style49 {
        }
        .auto-style50 {
            width: 50px;
        }
        .auto-style51 {
            width: 144px;
        }
        .auto-style52 {
            width: 40px;
        }
        .auto-style53 {
            width: 153px;
        }
            .modalPopup
    {
        background-color: #FFFFFF;
        width: 300px;
        border: 3px solid #0DA9D0;
    }
    .modalPopup .header
    {
        background-color: #2FBDF1;
        height: 30px;
        color: White;
        line-height: 30px;
        text-align: center;
        font-weight: bold;
    }
    .modalPopup .body
    {
        min-height: 100px;
        line-height: 30px;
        text-align: center;
        font-weight: bold;
    }
    .modalPopup .footer
    {
        padding: 3px;
    }
    .modalPopup .yes, .modalPopup .no
    {
        height: 23px;
        color: White;
        line-height: 23px;
        text-align: center;
        font-weight: bold;
        cursor: pointer;
    }
    .modalPopup .yes
    {
        background-color: #2FBDF1;
        border: 1px solid #0DA9D0;
    }
    .modalPopup .no
    {
        background-color: #9F9F9F;
        border: 1px solid #5C5C5C;
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
    MODIFICACION INCIDENTE</p>
        <table style="border-style: solid; border-width: thin; width:100%;">
            <tr>
                <td class="auto-style10">Fecha:</td>
                <td class="auto-style11"><strong>
                    <asp:Label ID="lblFecha" runat="server" Text="Label"></asp:Label>
                    </strong></td>
                <td class="auto-style12">Planta:</td>
                <td class="auto-style45"><strong>
                    <asp:Label ID="lblPlanta" runat="server" Text="Label"></asp:Label>
                    </strong></td>
                <td class="auto-style46">&nbsp;</td>
                <td>
                    <asp:Label ID="lblCodEquipo" runat="server" Text="lblCodEquipo" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style10">Responsable:</td>
                <td class="auto-style11"><strong>
                    <asp:Label ID="lblResponsable" runat="server" Text="Label"></asp:Label>
                    </strong></td>
                <td class="auto-style12">Area:</td>
                <td class="auto-style45"><strong>
                    <asp:Label ID="lblArea" runat="server" Text="Label"></asp:Label>
                    </strong></td>
                <td class="auto-style46">Equipo:</td>
                <td><strong>
                    <asp:Label ID="lblEquipo" runat="server" Text="Label"></asp:Label>
                    </strong></td>
            </tr>
            <tr>
                <td class="auto-style10">Cargo:</td>
                <td class="auto-style11"><strong>
                    <asp:Label ID="lblCargo" runat="server" Text="Label"></asp:Label>
                    </strong></td>
                <td class="auto-style12">Turno:</td>
                <td class="auto-style45"><strong>
                    <asp:Label ID="lblTurno" runat="server" Text="Label"></asp:Label>
                    </strong></td>
                <td class="auto-style46">&nbsp;</td>
                <td>
                    <asp:Label ID="lblNivRegDet" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblLocalizacion" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblDiasAtr" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblUsuario" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="SelPlanta" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="SelArea" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="SelProceso" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
                <br />
<asp:SqlDataSource ID="BopDBIncidentes" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Incidentes] WHERE [Incidente] = @Incidente" InsertCommand="INSERT INTO [Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (@Incidente, @TipoIncidente, @FechaIncidente, @HoraIncidente, @Planta, @Area, @Proceso, @Equipo, @Usuario, @Asunto, @Descripcion, @IndAlerta)" SelectCommand="SELECT * FROM [Incidentes] where usuario=@usuario and FechaIncidente&gt;=convert(varchar,getdate()-cast(@diasMenos as int),105) order by incidente desc" UpdateCommand="UPDATE [Incidentes] SET [TipoIncidente] = @TipoIncidente, [FechaIncidente] = @FechaIncidente, [HoraIncidente] = @HoraIncidente, [Planta] = @Planta, [Area] = @Area, [Proceso] = @Proceso, [Equipo] = @Equipo, [Usuario] = @Usuario, [Asunto] = @Asunto, [Descripcion] = @Descripcion, [IndAlerta] = @IndAlerta WHERE [Incidente] = @Incidente">
    <DeleteParameters>
        <asp:Parameter Name="Incidente" Type="Int64" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Incidente" Type="Int64" />
        <asp:Parameter Name="TipoIncidente" Type="String" />
        <asp:Parameter Name="FechaIncidente" Type="String" />
        <asp:Parameter Name="HoraIncidente" Type="String" />
        <asp:Parameter Name="Planta" Type="String" />
        <asp:Parameter Name="Area" Type="String" />
        <asp:Parameter Name="Proceso" Type="String" />
        <asp:Parameter Name="Equipo" Type="String" />
        <asp:Parameter Name="Usuario" Type="String" />
        <asp:Parameter Name="Asunto" Type="String" />
        <asp:Parameter Name="Descripcion" Type="String" />
        <asp:Parameter Name="IndAlerta" Type="String" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="lblUsuario" Name="usuario" PropertyName="Text" />
        <asp:ControlParameter ControlID="lblDiasAtr" DefaultValue="1" Name="diasMenos" PropertyName="Text" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="TipoIncidente" Type="String" />
        <asp:Parameter Name="FechaIncidente" Type="String" />
        <asp:Parameter Name="HoraIncidente" Type="String" />
        <asp:Parameter Name="Planta" Type="String" />
        <asp:Parameter Name="Area" Type="String" />
        <asp:Parameter Name="Proceso" Type="String" />
        <asp:Parameter Name="Equipo" Type="String" />
        <asp:Parameter Name="Usuario" Type="String" />
        <asp:Parameter Name="Asunto" Type="String" />
        <asp:Parameter Name="Descripcion" Type="String" />
        <asp:Parameter Name="IndAlerta" Type="String" />
        <asp:Parameter Name="Incidente" Type="Int64" />
    </UpdateParameters>
</asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Label ID="SelIncidente" runat="server" Visible="False"></asp:Label>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Incidente" DataSourceID="BopDBIncidentes" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1170px">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Select" ImageUrl="~/Images/Select.png" Text="Select" />
                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/Images/DeleteHS.png" Text="Delete" />
                            <cc1:ConfirmButtonExtender ID="cbe" runat="server" DisplayModalPopupID="mpe" TargetControlID="ImageButton2">
                        </cc1:ConfirmButtonExtender>
                        <cc1:ModalPopupExtender ID="mpe" runat="server"  Enabled="True" TargetControlID="ImageButton2" PopupControlID="pnlPopup" OkControlID="btnYes" CancelControlID="btnNo">
                                    </cc1:ModalPopupExtender>

                                   <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none">
                                        <div class="header">
                                            Causa Detencion
                                        </div>
                                        <div class="body">
                                        <asp:Label ID="lblMensaje" runat="server" Text="Desea eliminar el incidente?"></asp:Label>
                                        </div>
                                        <div class="footer" align="right">
                                            <asp:Button ID="btnYes" runat="server" Text="Aceptar" CssClass="yes" />
                                            <asp:Button ID="btnNo" runat="server" Text="Cancelar" CssClass="no" />

                                        </div>
                                    </asp:Panel>

                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Incidente" SortExpression="Incidente">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Incidente") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblIncidente" runat="server" Text='<%# Bind("Incidente") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tipo" SortExpression="TipoIncidente">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TipoIncidente") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBTipoIncidente" DataTextField="Descripcion" DataValueField="TipoInicidente" Enabled="False" SelectedValue='<%# Bind("TipoIncidente") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBTipoIncidente" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [TipoInicidente], [Descripcion] FROM [TiposIncidentes]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="FechaIncidente" HeaderText="Fecha" SortExpression="FechaIncidente" />
                    <asp:BoundField DataField="HoraIncidente" HeaderText="Hora" SortExpression="HoraIncidente" />
                    <asp:TemplateField HeaderText="Planta" SortExpression="Planta">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Planta") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBPlantas" DataTextField="Descripción" DataValueField="Planta" Enabled="False" SelectedValue='<%# Bind("Planta") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBPlantas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Area" SortExpression="Area">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Area") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BopDBAreas" DataTextField="Descripción" DataValueField="Area" Enabled="False" SelectedValue='<%# Bind("Area") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBAreas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT Null as Area, 'N/A' as [Descripción]
union
SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Proceso" SortExpression="Proceso">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Proceso") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBProcesos" DataTextField="Descripción" DataValueField="Proceso" Enabled="False" SelectedValue='<%# Bind("Proceso") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBProcesos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT Null as Proceso, 'N/A' as [Descripción]
union
SELECT [Proceso], [Descripción] FROM [Procesos]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Equipo") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBEquipos" DataTextField="Descripción" DataValueField="Equipo" Enabled="False" SelectedValue='<%# Bind("Equipo") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBEquipos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT '' AS Equipo, 'N/A' as [Descripción]
union
SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Asunto" SortExpression="Asunto">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Asunto") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Asunto") %>' Width="100%"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <SelectedRowStyle BackColor="#4D6082" Font-Bold="True" ForeColor="#CCCCCC" />
            </asp:GridView>
            <br />
            <asp:Button ID="ButtonModificar" runat="server" Enabled="False" OnClick="ButtonModificar_Click" Text="Modificar" />
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="Incidente" DataSourceID="BopDBIncidentesFV" DefaultMode="Edit" OnItemUpdated="FormView1_ItemUpdated" Width="100%">
                <EditItemTemplate>
                    <table style="width:100%;">
                        <tr>
                            <td class="auto-style47">Fecha:</td>
                            <td class="auto-style49">
                                <asp:DropDownList ID="DropDownList8" runat="server" DataSourceID="BopDBFechasGV" DataTextField="fecha" DataValueField="fecha" SelectedValue='<%# Bind("FechaIncidente") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBFechasGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_fechasIngreso" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblDiasAtr" Name="diasAtras" PropertyName="Text" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <td class="auto-style50">Hora:</td>
                            <td class="auto-style51">
                                <asp:TextBox ID="HoraIncidenteTextBox" runat="server" Text='<%# Bind("HoraIncidente") %>' TextMode="Time" />
                            </td>
                            <td class="auto-style52">Tipo:</td>
                            <td class="auto-style53">
                                <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="BopDBTipoIncidenteGV" DataTextField="Descripcion" DataValueField="TipoInicidente" SelectedValue='<%# Bind("TipoIncidente") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBTipoIncidenteGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [TipoInicidente], [Descripcion] FROM [TiposIncidentes]"></asp:SqlDataSource>
                            </td>
                            <td class="auto-style50">Equipo:</td>
                            <td>
                                <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="BopDBEquiposGV" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBEquiposGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_equiposIncidente" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblNivRegDet" Name="nivel" PropertyName="Text" Type="String" />
                                        <asp:ControlParameter ControlID="lblLocalizacion" Name="localizacion" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style47">Resumen:</td>
                            <td class="auto-style49" colspan="7">
                                <asp:TextBox ID="AsuntoTextBox" runat="server" Text='<%# Bind("Asunto") %>' Width="100%" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style47" valign="top">Detalle:</td>
                            <td class="auto-style49" colspan="7">
                                <asp:TextBox ID="DescripcionTextBox" runat="server" Height="220px" Text='<%# Bind("Descripcion") %>' TextMode="MultiLine" Width="100%" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" OnClick="UpdateCancelButton_Click" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    Incidente:
                    <asp:TextBox ID="IncidenteTextBox" runat="server" Text='<%# Bind("Incidente") %>' />
                    <br />
                    TipoIncidente:
                    <asp:TextBox ID="TipoIncidenteTextBox" runat="server" Text='<%# Bind("TipoIncidente") %>' />
                    <br />
                    FechaIncidente:
                    <asp:TextBox ID="FechaIncidenteTextBox" runat="server" Text='<%# Bind("FechaIncidente") %>' />
                    <br />
                    HoraIncidente:
                    <asp:TextBox ID="HoraIncidenteTextBox" runat="server" Text='<%# Bind("HoraIncidente") %>' />
                    <br />
                    Planta:
                    <asp:TextBox ID="PlantaTextBox" runat="server" Text='<%# Bind("Planta") %>' />
                    <br />
                    Area:
                    <asp:TextBox ID="AreaTextBox" runat="server" Text='<%# Bind("Area") %>' />
                    <br />
                    Proceso:
                    <asp:TextBox ID="ProcesoTextBox" runat="server" Text='<%# Bind("Proceso") %>' />
                    <br />
                    Equipo:
                    <asp:TextBox ID="EquipoTextBox" runat="server" Text='<%# Bind("Equipo") %>' />
                    <br />
                    Usuario:
                    <asp:TextBox ID="UsuarioTextBox" runat="server" Text='<%# Bind("Usuario") %>' />
                    <br />
                    Asunto:
                    <asp:TextBox ID="AsuntoTextBox" runat="server" Text='<%# Bind("Asunto") %>' />
                    <br />
                    Descripcion:
                    <asp:TextBox ID="DescripcionTextBox" runat="server" Text='<%# Bind("Descripcion") %>' />
                    <br />
                    IndAlerta:
                    <asp:TextBox ID="IndAlertaTextBox" runat="server" Text='<%# Bind("IndAlerta") %>' />
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
                    Incidente:
                    <asp:Label ID="IncidenteLabel" runat="server" Text='<%# Eval("Incidente") %>' />
                    <br />
                    TipoIncidente:
                    <asp:Label ID="TipoIncidenteLabel" runat="server" Text='<%# Bind("TipoIncidente") %>' />
                    <br />
                    FechaIncidente:
                    <asp:Label ID="FechaIncidenteLabel" runat="server" Text='<%# Bind("FechaIncidente") %>' />
                    <br />
                    HoraIncidente:
                    <asp:Label ID="HoraIncidenteLabel" runat="server" Text='<%# Bind("HoraIncidente") %>' />
                    <br />
                    Planta:
                    <asp:Label ID="PlantaLabel" runat="server" Text='<%# Bind("Planta") %>' />
                    <br />
                    Area:
                    <asp:Label ID="AreaLabel" runat="server" Text='<%# Bind("Area") %>' />
                    <br />
                    Proceso:
                    <asp:Label ID="ProcesoLabel" runat="server" Text='<%# Bind("Proceso") %>' />
                    <br />
                    Equipo:
                    <asp:Label ID="EquipoLabel" runat="server" Text='<%# Bind("Equipo") %>' />
                    <br />
                    Usuario:
                    <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Bind("Usuario") %>' />
                    <br />
                    Asunto:
                    <asp:Label ID="AsuntoLabel" runat="server" Text='<%# Bind("Asunto") %>' />
                    <br />
                    Descripcion:
                    <asp:Label ID="DescripcionLabel" runat="server" Text='<%# Bind("Descripcion") %>' />
                    <br />
                    IndAlerta:
                    <asp:Label ID="IndAlertaLabel" runat="server" Text='<%# Bind("IndAlerta") %>' />
                    <br />
                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="BopDBIncidentesFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Incidentes] WHERE [Incidente] = @Incidente" InsertCommand="INSERT INTO [Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (@Incidente, @TipoIncidente, @FechaIncidente, @HoraIncidente, @Planta, @Area, @Proceso, @Equipo, @Usuario, @Asunto, @Descripcion, @IndAlerta)" SelectCommand="SELECT * FROM [Incidentes] WHERE ([Incidente] = @Incidente)" UpdateCommand="UPDATE [Incidentes] SET [TipoIncidente] = @TipoIncidente, [FechaIncidente] = @FechaIncidente, [HoraIncidente] = @HoraIncidente,  [Equipo] = @Equipo, [Asunto] = @Asunto, [Descripcion] = @Descripcion WHERE [Incidente] = @Incidente">
                <DeleteParameters>
                    <asp:Parameter Name="Incidente" Type="Int64" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Incidente" Type="Int64" />
                    <asp:Parameter Name="TipoIncidente" Type="String" />
                    <asp:Parameter Name="FechaIncidente" Type="String" />
                    <asp:Parameter Name="HoraIncidente" Type="String" />
                    <asp:Parameter Name="Planta" Type="String" />
                    <asp:Parameter Name="Area" Type="String" />
                    <asp:Parameter Name="Proceso" Type="String" />
                    <asp:Parameter Name="Equipo" Type="String" />
                    <asp:Parameter Name="Usuario" Type="String" />
                    <asp:Parameter Name="Asunto" Type="String" />
                    <asp:Parameter Name="Descripcion" Type="String" />
                    <asp:Parameter Name="IndAlerta" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="SelIncidente" Name="Incidente" PropertyName="Text" Type="Int64" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TipoIncidente" Type="String" />
                    <asp:Parameter Name="FechaIncidente" Type="String" />
                    <asp:Parameter Name="HoraIncidente" Type="String" />
                    <asp:Parameter Name="Equipo" Type="String" />
                    <asp:Parameter Name="Asunto" Type="String" />
                    <asp:Parameter Name="Descripcion" Type="String" />
                    <asp:Parameter Name="Incidente" Type="Int64" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
</asp:Content>
