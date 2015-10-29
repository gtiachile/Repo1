<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Notificacion.aspx.cs" Inherits="BitOp.Produccion.Notificacion" %>
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
        .auto-style16 {
            width: 259px;
        }
        .auto-style17 {
            width: 66px;
        }
        .auto-style19 {
            width: 95px;
        }
        .auto-style20 {
            width: 75px;
        }
        .auto-style21 {
            width: 120px;
        }
        .auto-style23 {
            width: 55px;
        }
        .auto-style25 {
            width: 90px;
        }
        .auto-style26 {
            width: 71px;
        }
        .auto-style27 {
            width: 93px;
        }
        .auto-style29 {
            width: 147px;
            text-align: center;
        }
        .auto-style32 {
            width: 86px;
            text-align: center;
        }
        .auto-style34 {
            width: 147px;
            height: 26px;
        }
        .auto-style36 {
            width: 86px;
            height: 26px;
        }
        .auto-style37 {
            height: 26px;
        }
        .auto-style41 {
            width: 119px;
            height: 26px;
        }
        .auto-style42 {
            width: 119px;
            text-align: center;
        }
        .auto-style43 {
            width: 163px;
            text-align: center;
        }
        .auto-style44 {
            height: 26px;
            width: 163px;
        }
        .auto-style45 {
            width: 132px;
        }
        .auto-style46 {
            width: 56px;
        }
        .auto-style48 {
            width: 79px;
            height: 26px;
        }
        .auto-style49 {
            width: 155%;
        }
        .auto-style50 {
            width: 79px;
            text-align: center;
        }
        .auto-style53 {
            width: 109px;
            text-align: center;
        }
        .auto-style54 {
            width: 109px;
            height: 26px;
        }
        .auto-style55 {
            text-align: left;
        }
            .modalBackground
    {
        background-color: Black;
        filter: alpha(opacity=40);
        opacity: 0.4;
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
        min-height: 50px;
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
    NOTIFICACION PRODUCCION</p>
    <p>
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
                <td>&nbsp;</td>
            </tr>
        </table>
    </p>
    <p>
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="ViewPlan" runat="server">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OrdenFab" DataSourceID="BopDBOFSel" OnRowDataBound="GridView1_RowDataBound" ShowFooter="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/Select.png" ShowSelectButton="True" />
                        <asp:TemplateField HeaderText="OF" SortExpression="OrdenFab">
                            <EditItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("OrdenFab") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblOF" runat="server" Text='<%# Bind("OrdenFab") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FechaPlanif" HeaderText="Fecha" SortExpression="FechaPlanif" />
                        <asp:BoundField DataField="ProductoDsc" FooterText="Totales:" HeaderText="Producto" ReadOnly="True" SortExpression="ProductoDsc" />
                        <asp:BoundField DataField="Marca" HeaderText="Marca" SortExpression="Marca" />
                        <asp:TemplateField HeaderText="Cant. Planif" SortExpression="CantidadPlanif">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CantidadPlanif") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotPlanificado" runat="server" Text="lblTotPlanificado"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPlanificado" runat="server" Text='<%# Bind("CantidadPlanif") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cant. Produc" SortExpression="CantidadReal">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("CantidadReal") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotProducido" runat="server" Text="lblTotProducido"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblProducido" runat="server" Text='<%# Bind("CantidadReal") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="%Avance" SortExpression="Avance">
                            <EditItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Avance") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotAvance" runat="server" Text="lblTotAvance"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAvance" runat="server" Text='<%# Bind("Avance") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Unidad" HeaderText="UM" SortExpression="Unidad" />
                        <asp:BoundField DataField="Formato" HeaderText="Formato" SortExpression="Formato" />
                        <asp:TemplateField HeaderText="Mins.Planif" SortExpression="TiempoPlanif">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TiempoPlanif") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblMinsPlan" runat="server" Text="lblMinsPlan"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblMinsPlanGV" runat="server" Text='<%# Bind("TiempoPlanif") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Mins.Real" SortExpression="TiempoReal">
                            <EditItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("TiempoReal") %>'></asp:Label>
                            </EditItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblMinsReal" runat="server" Text="lblMinsReal"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblMinsrealGV" runat="server" Text='<%# Bind("TiempoReal") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Prioridad" HeaderText="Prioridad" SortExpression="Prioridad" />
                        <asp:BoundField DataField="EstadoOF" HeaderText="Estado" SortExpression="EstadoOF" />
                    </Columns>
                    <FooterStyle Font-Bold="True" />
                    <SelectedRowStyle BackColor="#293956" Font-Bold="True" ForeColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="BopDBOFSel" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT OrdenesFabricacion.OrdenFab, OrdenesFabricacion.FechaPlanif, OrdenesFabricacion.Material + ' - ' + Productos.Producto AS ProductoDsc, Marcas.Marca, OrdenesFabricacion.CantidadPlanif, ISNULL(OrdenesFabricacion.CantidadReal, 0) AS CantidadReal, ISNULL(OrdenesFabricacion.CantidadReal, 0) * 100 / OrdenesFabricacion.CantidadPlanif AS Avance, OrdenesFabricacion.CantidadPlanif - ISNULL(OrdenesFabricacion.CantidadReal, 0) AS Pendiente, Productos.Unidad, Productos.Formato, OrdenesFabricacion.TiempoPlanif, ISNULL(OrdenesFabricacion.TiempoReal, 0) AS TiempoReal, OrdenesFabricacion.Prioridad, OrdenesFabricacion.EstadoOF FROM OrdenesFabricacion INNER JOIN Productos ON OrdenesFabricacion.Material = Productos.Material INNER JOIN Marcas ON Productos.CodigoMarca = Marcas.Codigo WHERE (CAST(OrdenesFabricacion.FechaPlanif AS datetime) = CAST(CONVERT (varchar(10), GETDATE(), 20) AS datetime))"></asp:SqlDataSource>
                <asp:Button ID="btNotificar" runat="server" OnClick="btNotificar_Click" Text="Notificar" Enabled="False" />
                <asp:Label ID="gvOF" runat="server" Text="gvOF" Visible="False"></asp:Label>
            </asp:View>
            <asp:View ID="ViewNotificacion" runat="server">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="OrdenFab" DataSourceID="BopDBOFFV"  OnDataBound="FormView1_DataBound" Width="100%">
                    <EditItemTemplate>
                        OrdenFab:
                        <asp:Label ID="OrdenFabLabel1" runat="server" Text='<%# Eval("OrdenFab") %>' />
                        <br />
                        FechaPlanif:
                        <asp:TextBox ID="FechaPlanifTextBox" runat="server" Text='<%# Bind("FechaPlanif") %>' />
                        <br />
                        ProductoDsc:
                        <asp:TextBox ID="ProductoDscTextBox" runat="server" Text='<%# Bind("ProductoDsc") %>' />
                        <br />
                        Marca:
                        <asp:TextBox ID="MarcaTextBox" runat="server" Text='<%# Bind("Marca") %>' />
                        <br />
                        CantidadPlanif:
                        <asp:TextBox ID="CantidadPlanifTextBox" runat="server" Text='<%# Bind("CantidadPlanif") %>' />
                        <br />
                        CantidadReal:
                        <asp:TextBox ID="CantidadRealTextBox" runat="server" Text='<%# Bind("CantidadReal") %>' />
                        <br />
                        Avance:
                        <asp:TextBox ID="AvanceTextBox" runat="server" Text='<%# Bind("Avance") %>' />
                        <br />
                        Unidad:
                        <asp:TextBox ID="UnidadTextBox" runat="server" Text='<%# Bind("Unidad") %>' />
                        <br />
                        Formato:
                        <asp:TextBox ID="FormatoTextBox" runat="server" Text='<%# Bind("Formato") %>' />
                        <br />
                        TiempoPlanif:
                        <asp:TextBox ID="TiempoPlanifTextBox" runat="server" Text='<%# Bind("TiempoPlanif") %>' />
                        <br />
                        TiempoReal:
                        <asp:TextBox ID="TiempoRealTextBox" runat="server" Text='<%# Bind("TiempoReal") %>' />
                        <br />
                        Prioridad:
                        <asp:TextBox ID="PrioridadTextBox" runat="server" Text='<%# Bind("Prioridad") %>' />
                        <br />
                        EstadoOF:
                        <asp:TextBox ID="EstadoOFTextBox" runat="server" Text='<%# Bind("EstadoOF") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        OrdenFab:
                        <asp:TextBox ID="OrdenFabTextBox" runat="server" Text='<%# Bind("OrdenFab") %>' />
                        <br />
                        FechaPlanif:
                        <asp:TextBox ID="FechaPlanifTextBox0" runat="server" Text='<%# Bind("FechaPlanif") %>' />
                        <br />
                        ProductoDsc:
                        <asp:TextBox ID="ProductoDscTextBox0" runat="server" Text='<%# Bind("ProductoDsc") %>' />
                        <br />
                        Marca:
                        <asp:TextBox ID="MarcaTextBox0" runat="server" Text='<%# Bind("Marca") %>' />
                        <br />
                        CantidadPlanif:
                        <asp:TextBox ID="CantidadPlanifTextBox0" runat="server" Text='<%# Bind("CantidadPlanif") %>' />
                        <br />
                        CantidadReal:
                        <asp:TextBox ID="CantidadRealTextBox0" runat="server" Text='<%# Bind("CantidadReal") %>' />
                        <br />
                        Avance:
                        <asp:TextBox ID="AvanceTextBox0" runat="server" Text='<%# Bind("Avance") %>' />
                        <br />
                        Unidad:
                        <asp:TextBox ID="UnidadTextBox0" runat="server" Text='<%# Bind("Unidad") %>' />
                        <br />
                        Formato:
                        <asp:TextBox ID="FormatoTextBox0" runat="server" Text='<%# Bind("Formato") %>' />
                        <br />
                        TiempoPlanif:
                        <asp:TextBox ID="TiempoPlanifTextBox0" runat="server" Text='<%# Bind("TiempoPlanif") %>' />
                        <br />
                        TiempoReal:
                        <asp:TextBox ID="TiempoRealTextBox0" runat="server" Text='<%# Bind("TiempoReal") %>' />
                        <br />
                        Prioridad:
                        <asp:TextBox ID="PrioridadTextBox0" runat="server" Text='<%# Bind("Prioridad") %>' />
                        <br />
                        EstadoOF:
                        <asp:TextBox ID="EstadoOFTextBox0" runat="server" Text='<%# Bind("EstadoOF") %>' />
                        <br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <table style="width:100%;">
                            <tr>
                                <td class="auto-style17">OF</td>
                                <td class="auto-style16" colspan="3">
                                    <asp:Label ID="OrdenFabLabel" runat="server" Text='<%# Eval("OrdenFab") %>' />
                                </td>
                                <td class="auto-style10">Planificado:</td>
                                <td class="auto-style25">
                                    <asp:Label ID="CantidadPlanifLabel" runat="server" Text='<%# Bind("CantidadPlanif") %>' />
                                </td>
                                <td class="auto-style19">
                                    <asp:Label ID="UnidadLabel" runat="server" Text='<%# Bind("Unidad") %>' />
                                </td>
                                <td class="auto-style20">Mins. Plan:</td>
                                <td class="auto-style21">
                                    <asp:Label ID="TiempoPlanifLabel" runat="server" Text='<%# Bind("TiempoPlanif") %>' />
                                </td>
                                <td>Observaciones:</td>
                            </tr>
                            <tr>
                                <td class="auto-style17">Fecha:</td>
                                <td class="auto-style16" colspan="3">
                                    <asp:Label ID="FechaPlanifLabel" runat="server" Text='<%# Bind("FechaPlanif") %>' />
                                </td>
                                <td class="auto-style10">Producido:</td>
                                <td class="auto-style25">
                                    <asp:Label ID="CantidadRealLabel" runat="server" Text='<%# Bind("CantidadReal") %>'  />
                                </td>
                                <td class="auto-style19">
                                    <asp:Label ID="UnidadLabel0" runat="server" Text='<%# Bind("Unidad") %>' />
                                </td>
                                <td class="auto-style20">Mins. Real:</td>
                                <td class="auto-style21">
                                    <asp:Label ID="TiempoRealLabel" runat="server" Text='<%# Bind("TiempoReal") %>' />
                                </td>
                                <td rowspan="3" valign="top">
                                    <asp:TextBox ID="TextBox3" runat="server" Font-Bold="True" Height="57px" MaxLength="100" ReadOnly="True" Text='<%# Bind("Observaciones") %>' TextMode="MultiLine" Width="267px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style17">Producto:</td>
                                <td class="auto-style16" colspan="3">
                                    <asp:Label ID="ProductoDscLabel" runat="server" Text='<%# Bind("ProductoDsc") %>' />
                                </td>
                                <td class="auto-style10">Pendiente:</td>
                                <td class="auto-style25">
                                    <asp:Label ID="lblPendiente" runat="server" Text='<%# Bind("Pendiente") %>'></asp:Label>
                                </td>
                                <td class="auto-style19">
                                    <asp:Label ID="UnidadLabel1" runat="server" Text='<%# Bind("Unidad") %>' />
                                </td>
                                <td class="auto-style20">Prioridad:</td>
                                <td class="auto-style21">
                                    <asp:Label ID="PrioridadLabel" runat="server" Text='<%# Bind("Prioridad") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style17">Marca:</td>
                                <td class="auto-style27">
                                    <asp:Label ID="MarcaLabel" runat="server" Text='<%# Bind("Marca") %>' />
                                </td>
                                <td class="auto-style23">Formato:</td>
                                <td class="auto-style26">
                                    <asp:Label ID="FormatoLabel" runat="server" Text='<%# Bind("Formato") %>' />
                                </td>
                                <td class="auto-style10">Avance:</td>
                                <td class="auto-style25">
                                    <asp:Label ID="AvanceLabel" runat="server" Text='<%# Bind("Avance") %>' />
                                </td>
                                <td class="auto-style19">%</td>
                                <td class="auto-style20">Estado:</td>
                                <td class="auto-style21">
                                    <asp:Label ID="EstadoOFLabel" runat="server" Text='<%# Bind("EstadoOF") %>' />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="BopDBOFFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT OrdenesFabricacion.OrdenFab, OrdenesFabricacion.FechaPlanif, OrdenesFabricacion.Material + ' - ' + Productos.Producto AS ProductoDsc, Marcas.Marca, OrdenesFabricacion.CantidadPlanif, ISNULL(OrdenesFabricacion.CantidadReal, 0) AS CantidadReal, OrdenesFabricacion.CantidadPlanif - ISNULL(OrdenesFabricacion.CantidadReal, 0) AS Pendiente, ISNULL(OrdenesFabricacion.CantidadReal, 0) * 100 / OrdenesFabricacion.CantidadPlanif AS Avance, Productos.Unidad, Productos.Formato, OrdenesFabricacion.TiempoPlanif, ISNULL(OrdenesFabricacion.TiempoReal, 0) AS TiempoReal, OrdenesFabricacion.Prioridad, OrdenesFabricacion.EstadoOF, OrdenesFabricacion.Observaciones FROM OrdenesFabricacion INNER JOIN Productos ON OrdenesFabricacion.Material = Productos.Material INNER JOIN Marcas ON Productos.CodigoMarca = Marcas.Codigo WHERE (OrdenesFabricacion.OrdenFab = @OrdenFab)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvOF" 
                              DefaultValue="" 
                              Name="OrdenFab" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="OrdenFab,Lote" DataSourceID="BopDBNotificaciones" DefaultMode="Insert" OnItemInserting="FormView2_ItemInserting" OnItemInserted="FormView2_ItemInserted" Width="100%">

                    <EditItemTemplate>
                        OrdenFab:
                        <asp:Label ID="OrdenFabLabel2" runat="server" Text='<%# Eval("OrdenFab") %>' />
                        <br />
                        Lote:
                        <asp:Label ID="LoteLabel1" runat="server" Text='<%# Eval("Lote") %>' />
                        <br />
                        LoteSAP:
                        <asp:TextBox ID="LoteSAPTextBox" runat="server" Text='<%# Bind("LoteSAP") %>' />
                        <br />
                        Equipo:
                        <asp:TextBox ID="EquipoTextBox" runat="server" Text='<%# Bind("Equipo") %>' />
                        <br />
                        Inicio:
                        <asp:TextBox ID="InicioTextBox" runat="server" Text='<%# Bind("Inicio") %>' />
                        <br />
                        Fin:
                        <asp:TextBox ID="FinTextBox" runat="server" Text='<%# Bind("Fin") %>' />
                        <br />
                        Usuario:
                        <asp:TextBox ID="UsuarioTextBox" runat="server" Text='<%# Bind("Usuario") %>' />
                        <br />
                        FechaModificacion:
                        <asp:TextBox ID="FechaModificacionTextBox" runat="server" Text='<%# Bind("FechaModificacion") %>' />
                        <br />
                        Producción:
                        <asp:TextBox ID="ProducciónTextBox" runat="server" Text='<%# Bind("Producción") %>' />
                        <br />
                        Rechazo:
                        <asp:TextBox ID="RechazoTextBox" runat="server" Text='<%# Bind("Rechazo") %>' />
                        <br />
                        CausaRechazo:
                        <asp:TextBox ID="CausaRechazoTextBox" runat="server" Text='<%# Bind("CausaRechazo") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton0" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton0" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <table class="auto-style49" width="100%">
                            <tr>
                                <td class="auto-style50">&nbsp;</td>
                                <td class="auto-style29"><strong>Lote SAP</strong></td>
                                <td class="auto-style32"><strong>Inicio</strong></td>
                                <td class="auto-style53"><strong>Fin</strong></td>
                                <td class="auto-style42"><strong>Producción</strong></td>
                                <td class="auto-style43"><strong>Rechazo</strong></td>
                                <td class="auto-style55"><strong>Causa Rechazo</strong></td>
                            </tr>
                            <tr>
                                <td class="auto-style48" style="width: 115px">
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/NewRow.png" CausesValidation="True" CommandArgument='<%# Eval("OrdenFab")%>' CommandName="Insert" />
                                    <cc1:ConfirmButtonExtender ID="cbe" runat="server" ConfirmText="" Enabled="True" TargetControlID="ImageButton1" DisplayModalPopupID="mpe">
                                    </cc1:ConfirmButtonExtender>
                                    <cc1:ModalPopupExtender ID="mpe" runat="server"  Enabled="True" TargetControlID="ImageButton1" PopupControlID="pnlPopup" OkControlID="btnYes" CancelControlID="btnNo">
                                    </cc1:ModalPopupExtender>

                                   <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none">
                                        <div class="header">
                                            Confirmación
                                        </div>
                                        <div class="body">
                                            Cantidad sobrepasa lo planificado, ¿desea continuar?
                                        </div>
                                        <div class="footer" align="right">
                                            <asp:Button ID="btnYes" runat="server" Text="Si" CssClass="yes" />
                                            <asp:Button ID="btnNo" runat="server" Text="No" CssClass="no" />
                                        </div>
                                    </asp:Panel>
                                    &nbsp;
                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Cancel(build)_194_32.bmp" CausesValidation="False" CommandName="Cancel" />
                                </td>
                                <td class="auto-style34">
                                    <asp:TextBox ID="LoteSAPTextBox0" runat="server" MaxLength="50" Text='<%# Bind("LoteSAP") %>' Width="160px" />
                                </td>
                                <td class="auto-style36">
                                    <asp:TextBox ID="InicioTextBox0" runat="server" Text='<%# Bind("Inicio") %>' TextMode="Time" Width="97px" />
                                </td>
                                <td class="auto-style54">
                                    <asp:TextBox ID="FinTextBox0" runat="server" Text='<%# Bind("Fin") %>' TextMode="Time" Width="97px" />
                                </td>
                                <td class="auto-style41">
                                    <asp:TextBox ID="ProducciónTextBox0" runat="server" Text='<%# Bind("Producción") %>' TextMode="Number" Width="200px" />
                                </td>
                                <td class="auto-style44">
                                    <asp:TextBox ID="RechazoTextBox0" runat="server" Text='<%# Bind("Rechazo") %>' Width="160px" />
                                </td>
                                <td class="auto-style37">
                                    <asp:TextBox ID="CausaRechazoTextBox0" runat="server" Text='<%# Bind("CausaRechazo") %>' Width="260px" />
                                </td>
                            </tr>
                        </table>
                        
                        
                    </InsertItemTemplate>
                    <ItemTemplate>
                        OrdenFab:
                        <asp:Label ID="OrdenFabLabel3" runat="server" Text='<%# Eval("OrdenFab") %>' />
                        <br />
                        Lote:
                        <asp:Label ID="LoteLabel" runat="server" Text='<%# Eval("Lote") %>' />
                        <br />
                        LoteSAP:
                        <asp:Label ID="LoteSAPLabel" runat="server" Text='<%# Bind("LoteSAP") %>' />
                        <br />
                        Equipo:
                        <asp:Label ID="EquipoLabel" runat="server" Text='<%# Bind("Equipo") %>' />
                        <br />
                        Inicio:
                        <asp:Label ID="InicioLabel" runat="server" Text='<%# Bind("Inicio") %>' />
                        <br />
                        Fin:
                        <asp:Label ID="FinLabel" runat="server" Text='<%# Bind("Fin") %>' />
                        <br />
                        Usuario:
                        <asp:Label ID="UsuarioLabel" runat="server" Text='<%# Bind("Usuario") %>' />
                        <br />
                        FechaModificacion:
                        <asp:Label ID="FechaModificacionLabel" runat="server" Text='<%# Bind("FechaModificacion") %>' />
                        <br />
                        Producción:
                        <asp:Label ID="ProducciónLabel" runat="server" Text='<%# Bind("Producción") %>' />
                        <br />
                        Rechazo:
                        <asp:Label ID="RechazoLabel" runat="server" Text='<%# Bind("Rechazo") %>' />
                        <br />
                        CausaRechazo:
                        <asp:Label ID="CausaRechazoLabel" runat="server" Text='<%# Bind("CausaRechazo") %>' />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="BopDBNotificaciones" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Notificaciones] WHERE [OrdenFab] = @original_OrdenFab AND [Lote] = @original_Lote" InsertCommand="INSERT INTO [Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (@OrdenFab, @Lote, @LoteSAP, @Equipo, @Inicio, @Fin, @Usuario, @FechaModificacion, @Producción, @Rechazo, @CausaRechazo)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo] FROM [Notificaciones] where OrdenFab=@OrdenFab" UpdateCommand="UPDATE [Notificaciones] SET [LoteSAP] = @LoteSAP, [Equipo] = @Equipo, [Inicio] = @Inicio, [Fin] = @Fin, [Usuario] = @Usuario, [FechaModificacion] = @FechaModificacion, [Producción] = @Producción, [Rechazo] = @Rechazo, [CausaRechazo] = @CausaRechazo WHERE [OrdenFab] = @original_OrdenFab AND [Lote] = @original_Lote ">
                    <DeleteParameters>
                        <asp:Parameter Name="original_OrdenFab" Type="String" />
                        <asp:Parameter Name="original_Lote" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="OrdenFab" Type="String" />
                        <asp:Parameter Name="Lote" Type="Int32" />
                        <asp:Parameter Name="LoteSAP" Type="String" />
                        <asp:Parameter Name="Equipo" Type="String" />
                        <asp:Parameter Name="Inicio" Type="String" />
                        <asp:Parameter Name="Fin" Type="String" />
                        <asp:Parameter Name="Usuario" Type="String" />
                        <asp:Parameter Name="FechaModificacion" Type="String" />
                        <asp:Parameter Name="Producción" Type="Decimal" />
                        <asp:Parameter Name="Rechazo" Type="Decimal" />
                        <asp:Parameter Name="CausaRechazo" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvOF" Name="OrdenFab" PropertyName="Text" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="LoteSAP" Type="String" />
                        <asp:Parameter Name="Equipo" Type="String" />
                        <asp:Parameter Name="Inicio" Type="String" />
                        <asp:Parameter Name="Fin" Type="String" />
                        <asp:Parameter Name="Usuario" Type="String" />
                        <asp:Parameter Name="FechaModificacion" Type="String" />
                        <asp:Parameter Name="Producción" Type="Decimal" />
                        <asp:Parameter Name="Rechazo" Type="Decimal" />
                        <asp:Parameter Name="CausaRechazo" Type="String" />
                        <asp:Parameter Name="original_OrdenFab" Type="String" />
                        <asp:Parameter Name="original_Lote" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OrdenFab,Lote" DataSourceID="BopDBNotificaciones" OnRowDataBound="GridView2_RowDataBound"  OnRowDeleted="GridView2_RowDeleted" Width="100%">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update" ImageUrl="~/Images/saveHS.png" Text="Update" />
                                &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/Images/Cancel(build)_194_32.bmp" Text="Cancel" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Edit" ImageUrl="~/Images/EditTableHS.png" Text="Edit" />
                                &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/Images/DeleteHS.png" Text="Delete" />
                                    <cc1:ConfirmButtonExtender ID="cbe" runat="server" ConfirmText="" Enabled="True" TargetControlID="ImageButton2" DisplayModalPopupID="mpe">
                                    </cc1:ConfirmButtonExtender>
                                    <cc1:ModalPopupExtender ID="mpe" runat="server"  Enabled="True" TargetControlID="ImageButton2" PopupControlID="pnlPopup" OkControlID="btnYes" CancelControlID="btnNo">
                                    </cc1:ModalPopupExtender>

                                   <asp:Panel ID="pnlPopup" runat="server" CssClass="modalPopup" Style="display: none">
                                        <div class="header">
                                            Confirmación
                                        </div>
                                        <div class="body">
                                            ¿Desea eliminar la notificación?
                                        </div>
                                        <div class="footer" align="right">
                                            <asp:Button ID="btnYes" runat="server" Text="Si" CssClass="yes" />
                                            <asp:Button ID="btnNo" runat="server" Text="No" CssClass="no" />
                                        </div>
                                    </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="OrdenFab" HeaderText="OrdenFab" ReadOnly="True" SortExpression="OrdenFab" Visible="False" />
                        <asp:BoundField DataField="Lote" HeaderText="Lote" ReadOnly="True" SortExpression="Lote" Visible="False" />
                        <asp:BoundField DataField="LoteSAP" HeaderText="LoteSAP" SortExpression="LoteSAP" />
                        <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo" Visible="False">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEquipo" runat="server" Text='<%# Bind("Equipo") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Equipo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Inicio" HeaderText="Inicio" SortExpression="Inicio" />
                        <asp:BoundField DataField="Fin" HeaderText="Fin" SortExpression="Fin" />
                        <asp:TemplateField HeaderText="Usuario" SortExpression="Usuario" Visible="False">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUsuario" runat="server" Text='<%# Bind("Usuario") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Usuario") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FechaModificacion" SortExpression="FechaModificacion" Visible="False">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtFechaMod" runat="server" Text='<%# Bind("FechaModificacion") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("FechaModificacion") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Producción" HeaderText="Producción" SortExpression="Producción" />
                        <asp:BoundField DataField="Rechazo" HeaderText="Rechazo" SortExpression="Rechazo" />
                        <asp:BoundField DataField="CausaRechazo" HeaderText="CausaRechazo" SortExpression="CausaRechazo" />
                    </Columns>
                </asp:GridView>
                <br />
            </asp:View>
        </asp:MultiView>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
