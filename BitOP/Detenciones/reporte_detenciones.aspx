<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="reporte_detenciones.aspx.cs" Inherits="BitOp.Detenciones.reporte_detenciones" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style10 {
            width: 61px;
        }
        .auto-style11 {
            width: 209px;
        }
        .auto-style12 {
            width: 57px;
        }
        .auto-style13 {
            width: 148px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table style="width:100%;">
        <tr>
            <td class="auto-style10">Planta:</td>
            <td class="auto-style11">
                <asp:DropDownList ID="DropDownListPlanta" runat="server" DataSourceID="BopDBPlantas" DataTextField="Descripción" DataValueField="Planta">
                </asp:DropDownList>
                <asp:SqlDataSource ID="BopDBPlantas" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
            </td>
            <td class="auto-style12">Fecha:</td>
            <td class="auto-style13">
                <asp:TextBox ID="TextBoxFecha" runat="server" TextMode="Date"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="ButtonBuscar" runat="server" OnClick="ButtonBuscar_Click" Text="Buscar" style="height: 26px" />
            </td>
        </tr>
    </table>
    <br />
    <rsweb:ReportViewer ID="RVDetenciones" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%">
        <LocalReport ReportPath="Detenciones\reporte_detenciones.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="BopDBv_detenciones" Name="Detenciones" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="BopDBv_detenciones" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [v_reporte_detenciones] where Planta=@Planta and FechaDetencion=@FechaDetencion">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListPlanta" DefaultValue="VIE" Name="Planta" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBoxFecha" DefaultValue="2015-01-01" Name="FechaDetencion" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
