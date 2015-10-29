<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registro Incidentes.aspx.cs" Inherits="BitOp.Incidentes.Registro_Inicidentes" %>
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
        .auto-style48 {
        }
        .auto-style49 {
            width: 60px;
        }
        .auto-style50 {
            width: 148px;
        }
        .auto-style51 {
            width: 47px;
        }
        .auto-style52 {
            width: 225px;
        }
        .auto-style53 {
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

    .auto-style54 {
        width: 70px;
        height: 25px;
    }
    .auto-style55 {
        height: 25px;
    }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        REGISTRO DE INCIDENTES</p>
    <p>
        <table style="width:100%;">
            <tr>
                <td class="auto-style10" rowspan="2" style="border-style: solid; border-width: thin" valign="top">
        <asp:TreeView ID="TreeView1" runat="server" MaxDataBindDepth="3" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" OnTreeNodePopulate="TreeView1_TreeNodePopulate">
            <Nodes>
                <asp:TreeNode PopulateOnDemand="True" ShowCheckBox="False" Text="Ubicación" Value="Localización"></asp:TreeNode>
            </Nodes>
            <SelectedNodeStyle BackColor="#CCCCCC" />
        </asp:TreeView>
                </td>
                <td valign="top">
        <table style="border-style: solid; border-width: thin; width:100%;">
            <tr>
                <td class="auto-style10">&nbsp;</td>
                <td class="auto-style11">&nbsp;</td>
                <td class="auto-style12">&nbsp;</td>
                <td class="auto-style45">&nbsp;</td>
                <td class="auto-style46">&nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
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
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Panel1" runat="server" BackColor="#CCCCCC" Visible="False">
                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Incidente" DataSourceID="BopDBIncidentes" DefaultMode="Insert" OnItemInserting="FormView1_ItemInserting" Width="100%">
                            <EditItemTemplate>
                                Incidente:
                                <asp:Label ID="IncidenteLabel1" runat="server" Text='<%# Eval("Incidente") %>' />
                                <br />
                                TipoIncidente:
                                <asp:TextBox ID="TipoIncidenteTextBox" runat="server" Text='<%# Bind("TipoIncidente") %>' />
                                <br />
                                Fecha Incidente:
                                <asp:TextBox ID="Fecha_IncidenteTextBox" runat="server" Text='<%# Bind("[Fecha Incidente]") %>' />
                                <br />
                                Hora Incidente:
                                <asp:TextBox ID="Hora_IncidenteTextBox" runat="server" Text='<%# Bind("[Hora Incidente]") %>' />
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
                                Alerta:
                                <asp:TextBox ID="AlertaTextBox" runat="server" Text='<%# Bind("Alerta") %>' />
                                <br />
                                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <table style="width:100%;">
                                    <tr>
                                        <td class="auto-style47">Fecha:</td>
                                        <td class="auto-style53">
                                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BopDBFechas" DataTextField="fecha" DataValueField="fecha" SelectedValue='<%# Bind("FechaIncidente") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBFechas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_fechasIngreso" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblDiasAtr" Name="diasAtras" PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                        <td class="auto-style49">Hora:</td>
                                        <td class="auto-style50">
                                            <asp:TextBox ID="Hora_IncidenteTextBox0" runat="server" Text='<%# Bind("HoraIncidente") %>' TextMode="Time" />
                                        </td>
                                        <td class="auto-style50">
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/clock.png" OnClick="ImageButton1_Click" CausesValidation="False" />
                                        </td>
                                        <td class="auto-style51">Tipo:</td>
                                        <td class="auto-style52">
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBTipoIncidentes" DataTextField="Descripcion" DataValueField="TipoInicidente" SelectedValue='<%# Bind("TipoIncidente") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBTipoIncidentes" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [TipoInicidente], [Descripcion] FROM [TiposIncidentes] where Estado='Activo'"></asp:SqlDataSource>
                                        </td>
                                        <td class="auto-style49">Equipo:</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBEquipos" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBEquipos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_equiposIncidente" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblNivRegDet" Name="nivel" PropertyName="Text" Type="String" />
                                                    <asp:ControlParameter ControlID="lblLocalizacion" Name="localizacion" PropertyName="Text" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                        <td>Alerta:</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("IndAlerta") %>'>
                                                <asp:ListItem>No</asp:ListItem>
                                                <asp:ListItem>Si</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style47">Resumen:</td>
                                        <td class="auto-style48" colspan="10">
                                            <asp:TextBox ID="AsuntoTextBox0" runat="server" Text='<%# Bind("Asunto") %>' Width="100%" MaxLength="300" CausesValidation="True" ValidateRequestMode="Enabled" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" BackColor="#CC0000" ControlToValidate="AsuntoTextBox0" ErrorMessage="Resumen es obligatorio" ForeColor="#CCCCCC"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style47" valign="top">Detalle:</td>
                                        <td class="auto-style53" colspan="10">
                                            <asp:TextBox ID="txtDescripcion" runat="server" Height="220px" Text='<%# Bind("Descripcion") %>' TextMode="MultiLine" Width="100%" MaxLength="2000"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style54" valign="top"></td>
                                        <td class="auto-style55" colspan="10">
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" BackColor="#CC0000" ControlToValidate="txtDescripcion" ErrorMessage="Descripción es obligatoria" ForeColor="#CCCCCC"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
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
                                Fecha Incidente:
                                <asp:Label ID="Fecha_IncidenteLabel" runat="server" Text='<%# Bind("[Fecha Incidente]") %>' />
                                <br />
                                Hora Incidente:
                                <asp:Label ID="Hora_IncidenteLabel" runat="server" Text='<%# Bind("[Hora Incidente]") %>' />
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
                                Alerta:
                                <asp:Label ID="AlertaLabel" runat="server" Text='<%# Bind("Alerta") %>' />
                                <br />
                                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="BopDBIncidentes" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Incidentes] WHERE [Incidente] = @Incidente" InsertCommand="INSERT INTO [Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (@Incidente, @TipoIncidente, @FechaIncidente, @HoraIncidente, @Planta, @Area, @Proceso, @Equipo, @Usuario, @Asunto, @Descripcion, @IndAlerta)" SelectCommand="SELECT * FROM [Incidentes]" UpdateCommand="UPDATE [Incidentes] SET [TipoIncidente] = @TipoIncidente, [FechaIncidente] = @FechaIncidente, [HoraIncidente] = @HoraIncidente, [Planta] = @Planta, [Area] = @Area, [Proceso] = @Proceso, [Equipo] = @Equipo, [Usuario] = @Usuario, [Asunto] = @Asunto, [Descripcion] = @Descripcion, [IndAlerta] = @IndAlerta WHERE [Incidente] = @Incidente">
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
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </p>
    <p>
        <asp:Label ID="labelStatus" runat="server" Text="Label" Visible="False"></asp:Label>
    </p>
</asp:Content>
