<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PlanProduccion.aspx.cs" Inherits="BitOp.Planif.PlanProduccion" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register assembly="CrystalDecisions.Web, Version=12.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>PLAN DE PRODUCCION</h3>
    <p>Fecha inicio:<asp:TextBox ID="TextBoxFechaInicio" runat="server" TextMode="Date"></asp:TextBox>
&nbsp;&nbsp;&nbsp; Fecha fin:<asp:TextBox ID="TextBoxFechaFin" runat="server" TextMode="Date"></asp:TextBox>
        &nbsp;</p>
    <p>
    </p>
    </asp:Content>
