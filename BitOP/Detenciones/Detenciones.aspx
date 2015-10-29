<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detenciones.aspx.cs" Inherits="BitOp.Detenciones.Detenciones" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

        .auto-style10 {
            width: 81px;
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
            width: 99px;
        }
        .auto-style49 {
            width: 234px;
        }
        .auto-style50 {
            width: 246px;
        }
        .auto-style51 {
            width: 149px;
        }
        .auto-style52 {
            width: 104px;
        }
        .auto-style53 {
            width: 176px;
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
    DETENCIONES<br />
    <br />
        <table style="width:100%;">
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
                </td>
            </tr>
        </table>
    <asp:FormView ID="FormViewDetencion" runat="server" DataKeyNames="NroDetencion" DataSourceID="BopDBDetenciones" Width="100%" DefaultMode="Insert" OnItemInserting="FormViewDetencion_ItemInserting" OnItemInserted="FormViewDetencion_ItemInserted">
        <EditItemTemplate>
            NroDetencion:
            <asp:Label ID="NroDetencionLabel1" runat="server" Text='<%# Eval("NroDetencion") %>' />
            <br />
            Equipo:
            <asp:TextBox ID="EquipoTextBox" runat="server" Text='<%# Bind("Equipo") %>' />
            <br />
            CodigoCausaPrimario:
            <asp:TextBox ID="CodigoCausaPrimarioTextBox" runat="server" Text='<%# Bind("CodigoCausaPrimario") %>' />
            <br />
            CodigoCausaSecundario:
            <asp:TextBox ID="CodigoCausaSecundarioTextBox" runat="server" Text='<%# Bind("CodigoCausaSecundario") %>' />
            <br />
            FechaDetencion:
            <asp:TextBox ID="FechaDetencionTextBox" runat="server" Text='<%# Bind("FechaDetencion") %>' />
            <br />
            InicioDetencion:
            <asp:TextBox ID="InicioDetencionTextBox" runat="server" Text='<%# Bind("InicioDetencion") %>' />
            <br />
            FinDetencion:
            <asp:TextBox ID="FinDetencionTextBox" runat="server" Text='<%# Bind("FinDetencion") %>' />
            <br />
            Observaciones:
            <asp:TextBox ID="ObservacionesTextBox" runat="server" Text='<%# Bind("Observaciones") %>' />
            <br />
            Usuario:
            <asp:TextBox ID="UsuarioTextBox" runat="server" Text='<%# Bind("Usuario") %>' />
            <br />
            FechaGrabacion:
            <asp:TextBox ID="FechaGrabacionTextBox" runat="server" Text='<%# Bind("FechaGrabacion") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            <table style="width:100%;">
                <tr>
                    <td class="auto-style47">Equipo: </td>
                    <td class="auto-style49">
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBEquipos" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBEquipos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_equiposDetencion" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblNivRegDet" Name="nivel" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="lblLocalizacion" Name="localizacion" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td class="auto-style53">Causa Principal:</td>
                    <td class="auto-style50">
                        <asp:TextBox ID="CodigoCausaPrimarioTextBox" runat="server" Text='<%# Bind("CodigoCausaPrimario") %>' Width="80px" MaxLength="3" />
                        <asp:Button ID="ButtonCausasP" runat="server" Text="?" />
                        <cc1:ModalPopupExtender ID="mpe" runat="server"  Enabled="True" TargetControlID="ButtonCausasP" PopupControlID="pnlPopup" OkControlID="btnYes" CancelControlID="btnNo">
                                    </cc1:ModalPopupExtender>

                                   <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none">
                                        <div class="header">
                                            Causa Detencion
                                        </div>
                                        <div class="body">
                                            <asp:ListBox ID="ListBoxCausas1" runat="server" DataSourceID="BopDBCausasDet" DataTextField="Descripcion" DataValueField="Causa">
                                            </asp:ListBox>
                                            <asp:SqlDataSource ID="BopDBCausasDet" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Causa], [Causa]+' - '+[Descripción] as Descripcion FROM [CausasDetencion] where estado='Activo'"></asp:SqlDataSource>

                                        </div>
                                        <div class="footer" align="right">
                                            <asp:Button ID="btnYes" runat="server" Text="Aceptar" CssClass="yes" />
                                            <asp:Button ID="btnNo" runat="server" Text="Cancelar" CssClass="no" />

                                        </div>
                                    </asp:Panel>
                        <asp:Label ID="lblCausaPDesc" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style50">Inicio:</td>
                    <td class="auto-style51">
                        <asp:TextBox ID="InicioDetencionTextBox" runat="server" Text='<%# Bind("InicioDetencion") %>' TextMode="Time" />
                    </td>
                    <td class="auto-style51">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/clock.png" OnClick="ImageButton1_Click" />
                    </td>
                    <td class="auto-style52">Observaciones:</td>
                    <td rowspan="2" valign="top">
                        <asp:TextBox ID="TextBox1" runat="server" Height="89px" TextMode="MultiLine" Width="257px" Text='<%# Bind("Observaciones") %>'></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style47">Fecha:</td>

                    <td class="auto-style49">

                        <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="BopDBfechasAtr" DataTextField="fecha" DataValueField="fecha" SelectedValue='<%# Bind("FechaDetencion") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBfechasAtr" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_fechasIngreso" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblDiasAtr" Name="diasAtras" PropertyName="Text" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:TextBox ID="NroDetencionTextBox" runat="server" Text='<%# Bind("NroDetencion") %>' Visible="False" />
                    </td>
                    <td class="auto-style53">Causa Secundaria:</td>
                    <td class="auto-style50">
                        <asp:TextBox ID="CodigoCausaSecundarioTextBox" runat="server" Text='<%# Bind("CodigoCausaSecundario") %>' Width="80px" MaxLength="3" />
                        <asp:Button ID="ButtonCausasS" runat="server" Text="?" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server"  Enabled="True" TargetControlID="ButtonCausasS" PopupControlID="pnlPopup2" OkControlID="btnYes2" CancelControlID="btnNo2">
                                    </cc1:ModalPopupExtender>

                                   <asp:Panel ID="pnlPopup2" runat="server" CssClass="modalPopup" Style="display: none">
                                        <div class="header">
                                            Causa Detencion
                                        </div>
                                        <div class="body">
                                            <asp:ListBox ID="ListBox2" runat="server" DataSourceID="BopDBCausasDet2" DataTextField="Descripcion" DataValueField="Causa">
                                            </asp:ListBox>
                                            <asp:SqlDataSource ID="BopDBCausasDet2" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Causa], [Causa]+' - '+[Descripción] as Descripcion FROM [CausasDetencion] where estado='Activo'"></asp:SqlDataSource>

                                        </div>
                                        <div class="footer" align="right">
                                            <asp:Button ID="btnYes2" runat="server" Text="Aceptar" CssClass="yes" />
                                            <asp:Button ID="btnNo2" runat="server" Text="Cancelar" CssClass="no" />

                                        </div>
                                    </asp:Panel>
                        <asp:Label ID="lblCausaSDesc" runat="server"></asp:Label>
                    </td>
                    <td class="auto-style50">Fin:</td>
                    <td class="auto-style51">
                        <asp:TextBox ID="FinDetencionTextBox" runat="server" Text='<%# Bind("FinDetencion") %>' TextMode="Time" />
                    </td>
                    <td class="auto-style51">
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/clock.png" OnClick="ImageButton2_Click" />
                    </td>
                    <td class="auto-style52">&nbsp;</td>
                </tr>
            </table>
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            NroDetencion:
            <asp:Label ID="NroDetencionLabel" runat="server" Text='<%# Eval("NroDetencion") %>' />
            <br />
            Equipo:
            <asp:Label ID="EquipoLabel" runat="server" Text='<%# Bind("Equipo") %>' />
            <br />
            CodigoCausaPrimario:
            <asp:Label ID="CodigoCausaPrimarioLabel" runat="server" Text='<%# Bind("CodigoCausaPrimario") %>' />
            <br />
            CodigoCausaSecundario:
            <asp:Label ID="CodigoCausaSecundarioLabel" runat="server" Text='<%# Bind("CodigoCausaSecundario") %>' />
            <br />
            FechaDetencion:
            <asp:Label ID="FechaDetencionLabel" runat="server" Text='<%# Bind("FechaDetencion") %>' />
            <br />
            InicioDetencion:
            <asp:Label ID="InicioDetencionLabel" runat="server" Text='<%# Bind("InicioDetencion") %>' />
            <br />
            FinDetencion:
            <asp:Label ID="FinDetencionLabel" runat="server" Text='<%# Bind("FinDetencion") %>' />
            <br />
            Observaciones:
            <asp:Label ID="ObservacionesLabel" runat="server" Text='<%# Bind("Observaciones") %>' />
            <br />
            Usuario:
            <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Bind("Usuario") %>' />
            <br />
            FechaGrabacion:
            <asp:Label ID="FechaGrabacionLabel" runat="server" Text='<%# Bind("FechaGrabacion") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="BopDBDetenciones" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Detenciones] WHERE [NroDetencion] = @NroDetencion" InsertCommand="INSERT INTO [Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (@NroDetencion, @Equipo, @CodigoCausaPrimario, @CodigoCausaSecundario, @FechaDetencion, @InicioDetencion, @FinDetencion, @Observaciones, @Usuario, @FechaGrabacion)" SelectCommand="SELECT * FROM [Detenciones]" UpdateCommand="UPDATE [Detenciones] SET [Equipo] = @Equipo, [CodigoCausaPrimario] = @CodigoCausaPrimario, [CodigoCausaSecundario] = @CodigoCausaSecundario, [FechaDetencion] = @FechaDetencion, [InicioDetencion] = @InicioDetencion, [FinDetencion] = @FinDetencion, [Observaciones] = @Observaciones, [Usuario] = @Usuario, [FechaGrabacion] = @FechaGrabacion WHERE [NroDetencion] = @NroDetencion">
        <DeleteParameters>
            <asp:Parameter Name="NroDetencion" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="NroDetencion" Type="Decimal" />
            <asp:Parameter Name="Equipo" Type="String" />
            <asp:Parameter Name="CodigoCausaPrimario" Type="String" />
            <asp:Parameter Name="CodigoCausaSecundario" Type="String" />
            <asp:Parameter Name="FechaDetencion" Type="String" />
            <asp:Parameter Name="InicioDetencion" Type="String" />
            <asp:Parameter Name="FinDetencion" Type="String" />
            <asp:Parameter Name="Observaciones" Type="String" />
            <asp:Parameter Name="Usuario" Type="String" />
            <asp:Parameter Name="FechaGrabacion" Type="DateTime" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Equipo" Type="String" />
            <asp:Parameter Name="CodigoCausaPrimario" Type="String" />
            <asp:Parameter Name="CodigoCausaSecundario" Type="String" />
            <asp:Parameter Name="FechaDetencion" Type="String" />
            <asp:Parameter Name="InicioDetencion" Type="String" />
            <asp:Parameter Name="FinDetencion" Type="String" />
            <asp:Parameter Name="Observaciones" Type="String" />
            <asp:Parameter Name="Usuario" Type="String" />
            <asp:Parameter Name="FechaGrabacion" Type="DateTime" />
            <asp:Parameter Name="NroDetencion" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NroDetencion" DataSourceID="BopDBDetencionesGV"  OnRowDataBound="GridView1_RowDataBound" Width="100%">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/Cancel(build)_194_32.bmp" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" InsertImageUrl="~/Images/NewRow.png" SelectImageUrl="~/Images/Select.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
            <asp:BoundField DataField="NroDetencion" HeaderText="N°" ReadOnly="True" SortExpression="NroDetencion"></asp:BoundField>
            <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBEquiposGVE" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBEquiposGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="p_equiposDetencion" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNivRegDet" Name="nivel" PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="lblLocalizacion" Name="localizacion" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBEquiposGV" DataTextField="Descripción" DataValueField="Equipo" Enabled="False" SelectedValue='<%# Bind("Equipo") %>' Width="150px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBEquiposGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Causa Principal" SortExpression="CodigoCausaPrimario">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="BopDBCausaPrimGVE" DataTextField="Descripcion" DataValueField="Causa" SelectedValue='<%# Bind("CodigoCausaPrimario") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBCausaPrimGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Causa], [Causa]+' - '+ [Descripción] as Descripcion FROM [CausasDetencion]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BopDBCausaP" DataTextField="Descripcion" DataValueField="Causa" SelectedValue='<%# Bind("CodigoCausaPrimario") %>' Enabled="False">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBCausaP" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Causa], [Causa]+' - '+[Descripción] as Descripcion FROM [CausasDetencion]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Causa Secundaria" SortExpression="CodigoCausaSecundario">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBCausaSec" DataTextField="descripcion" DataValueField="Causa" SelectedValue='<%# Bind("CodigoCausaSecundario") %>' Width="150px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBCausaSec" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as Causa, Null as descripcion
union
SELECT [Causa], [Causa]+' - '+[Descripción] as descripcion FROM [CausasDetencion]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBCausaSec" DataTextField="descripcion" DataValueField="Causa" SelectedValue='<%# Bind("CodigoCausaSecundario") %>' Enabled="False" Width="150px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBCausaSec" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as Causa, Null as descripcion
union
SELECT [Causa], [Causa]+' - '+[Descripción] as descripcion FROM [CausasDetencion]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fecha" SortExpression="FechaDetencion">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server"  Text='<%# Bind("FechaDetencion") %>' ReadOnly="True" Width="100px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FechaDetencion","{0:dd/MM/yyyy}") %>' Width="100px"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Inicio" SortExpression="InicioDetencion">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("InicioDetencion") %>' TextMode="Time"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("InicioDetencion") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fin" SortExpression="FinDetencion">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FinDetencion") %>' TextMode="Time"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("FinDetencion") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Observaciones" SortExpression="Observaciones">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Observaciones") %>' MaxLength="300" TextMode="MultiLine" Width="150px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Observaciones") %>' Width="150px"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Usuario" SortExpression="Usuario" Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="txtUsuario" runat="server" Text='<%# Bind("Usuario") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Usuario") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FechaGrabacion" SortExpression="FechaGrabacion" Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="txtFechaMod" runat="server" Text='<%# Bind("FechaGrabacion") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("FechaGrabacion") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#465767" ForeColor="#CCCCCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="BopDBDetencionesGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Detenciones] WHERE [NroDetencion] = @NroDetencion" InsertCommand="INSERT INTO [Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (@NroDetencion, @Equipo, @CodigoCausaPrimario, @CodigoCausaSecundario, @FechaDetencion, @InicioDetencion, @FinDetencion, @Observaciones, @Usuario, @FechaGrabacion)" SelectCommand="p_detenciones_usuario" UpdateCommand="UPDATE [Detenciones] SET [Equipo] = @Equipo, [CodigoCausaPrimario] = @CodigoCausaPrimario, [CodigoCausaSecundario] = @CodigoCausaSecundario, [FechaDetencion] = @FechaDetencion, [InicioDetencion] = @InicioDetencion, [FinDetencion] = @FinDetencion, [Observaciones] = @Observaciones, [FechaGrabacion] = @FechaGrabacion WHERE [NroDetencion] = @NroDetencion" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="NroDetencion" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="NroDetencion" Type="Decimal" />
            <asp:Parameter Name="Equipo" Type="String" />
            <asp:Parameter Name="CodigoCausaPrimario" Type="String" />
            <asp:Parameter Name="CodigoCausaSecundario" Type="String" />
            <asp:Parameter Name="FechaDetencion" Type="String" />
            <asp:Parameter Name="InicioDetencion" Type="String" />
            <asp:Parameter Name="FinDetencion" Type="String" />
            <asp:Parameter Name="Observaciones" Type="String" />
            <asp:Parameter Name="Usuario" Type="String" />
            <asp:Parameter Name="FechaGrabacion" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lblUsuario" Name="usuario" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Equipo" Type="String" />
            <asp:Parameter Name="CodigoCausaPrimario" Type="String" />
            <asp:Parameter Name="CodigoCausaSecundario" Type="String" />
            <asp:Parameter Name="FechaDetencion" Type="String" />
            <asp:Parameter Name="InicioDetencion" Type="String" />
            <asp:Parameter Name="FinDetencion" Type="String" />
            <asp:Parameter Name="Observaciones" Type="String" />
            <asp:Parameter Name="FechaGrabacion" Type="DateTime" />
            <asp:Parameter Name="NroDetencion" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
