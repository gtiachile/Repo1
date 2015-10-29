<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="prueba.aspx.cs" Inherits="BitOp.Admin.prueba" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Centro" DataSourceID="BopDBPrueba">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="Centro" HeaderText="Centro" ReadOnly="True" SortExpression="Centro" />
            <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
            <asp:BoundField DataField="Dirección" HeaderText="Dirección" SortExpression="Dirección" />
            <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="BopDBPrueba" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Centros] WHERE [Centro] = @Centro" InsertCommand="INSERT INTO [Centros] ([Centro], [Descripción], [Dirección], [Estado]) VALUES (@Centro, @Descripción, @Dirección, @Estado)" SelectCommand="SELECT [Centro], [Descripción], [Dirección], [Estado] FROM [Centros]" UpdateCommand="UPDATE [Centros] SET [Descripción] = @Descripción, [Dirección] = @Dirección, [Estado] = @Estado WHERE [Centro] = @Centro">
        <DeleteParameters>
            <asp:Parameter Name="Centro" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Centro" Type="String" />
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Dirección" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Dirección" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Centro" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
