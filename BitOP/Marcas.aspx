<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="BitOp.Admin.Marcas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>MARCAS</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Codigo" DataSourceID="BopDBMarcas" DefaultMode="Insert">
            <EditItemTemplate>
                Codigo:
                <asp:Label ID="CodigoLabel1" runat="server" Text='<%# Eval("Codigo") %>' />
                <br />
                Marca:
                <asp:TextBox ID="MarcaTextBox" runat="server" Text='<%# Bind("Marca") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                <table style="width:100%;">
                    <tr>
                        <td>Codigo:</td>
                        <td>
                            <asp:TextBox ID="CodigoTextBox" runat="server" Text='<%# Bind("Codigo") %>' Width="18px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Marca:</td>
                        <td>
                            <asp:TextBox ID="MarcaTextBox0" runat="server" Text='<%# Bind("Marca") %>' />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                <asp:ListItem>Activo</asp:ListItem>
                                <asp:ListItem>Inactivo</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Codigo:
                <asp:Label ID="CodigoLabel" runat="server" Text='<%# Eval("Codigo") %>' />
                <br />
                Marca:
                <asp:Label ID="MarcaLabel" runat="server" Text='<%# Bind("Marca") %>' />
                <br />
                Estado:
                <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        </p>
<p>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Codigo" DataSourceID="BopDBMarcas">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
            <asp:BoundField DataField="Codigo" HeaderText="Codigo" ReadOnly="True" SortExpression="Codigo" />
            <asp:BoundField DataField="Marca" HeaderText="Marca" SortExpression="Marca" />
            <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [Estados]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="BopDBMarcas" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Marcas] WHERE [Codigo] = @original_Codigo AND [Marca] = @original_Marca AND [Estado] = @original_Estado" InsertCommand="INSERT INTO [Marcas] ([Codigo], [Marca], [Estado]) VALUES (@Codigo, @Marca, @Estado)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Marcas]" UpdateCommand="UPDATE [Marcas] SET [Marca] = @Marca, [Estado] = @Estado WHERE [Codigo] = @original_Codigo AND [Marca] = @original_Marca AND [Estado] = @original_Estado">
        <DeleteParameters>
            <asp:Parameter Name="original_Codigo" Type="String" />
            <asp:Parameter Name="original_Marca" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Codigo" Type="String" />
            <asp:Parameter Name="Marca" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Marca" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="original_Codigo" Type="String" />
            <asp:Parameter Name="original_Marca" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>
