<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlanProduccion.aspx.cs" Inherits="BitOp.Planif.PlanProduccion" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style9 {
            width: 174px;
        }
        .auto-style10 {
            width: 163px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>PLAN DE PRODUCCION</h3>
    <p>
        <asp:SqlDataSource ID="BopDBPlantas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas] where estado='Activo'"></asp:SqlDataSource>
        <asp:SqlDataSource ID="BopDBFechasPlan" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT top 30 [Planta],[Fecha]
  FROM [v_PlanProduccion] where [Planta]=@Planta
group by [Planta],[Fecha] order by [Fecha] desc">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownListPlanta" Name="Planta" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        &nbsp;&nbsp;
        &nbsp;</p>
    <p>
        <table style="width:100%;">
            <tr>
                <td class="auto-style9">Planta:<asp:DropDownList ID="DropDownListPlanta" runat="server" DataSourceID="BopDBPlantas" DataTextField="Descripción" DataValueField="Planta">
        </asp:DropDownList>
                </td>
                <td class="auto-style10">Fecha:&nbsp;<asp:DropDownList ID="DropDownListFecha" runat="server" DataSourceID="BopDBFechasPlan" DataTextField="Fecha" DataValueField="Fecha">
        </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="BtBuscar" runat="server" OnClick="BtBuscar_Click" Text="Buscar..." />
                </td>
            </tr>
        </table>
    </p>
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
    <rsweb:ReportViewer ID="RVPlanProduccion" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
        <LocalReport ReportPath="Planif\PlanProduccionTurno.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="BopDBv_PlanProduccion" Name="PlanProduccionTurno" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="BopDBv_PlanProduccion" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [v_PlanProduccion] WHERE ([Planta] = @Planta and [Fecha]=@Fecha)  ORDER BY [Planta], [Fecha], [Formato]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListPlanta" Name="Planta" PropertyName="SelectedValue" Type="String" DefaultValue="VIE" />
            <asp:ControlParameter ControlID="DropDownListFecha" Name="Fecha" PropertyName="SelectedValue" Type="String" DefaultValue="2015-01-01"  />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
