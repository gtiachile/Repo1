<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Familias_Producto.aspx.cs" Inherits="BitOp.Admin.Familias_Producto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

        .auto-style3 {
            width: 230px;
        }
        .auto-style2 {
            width: 221px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>FAMILIAS DE PRODUCTO</h3>
<p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Codigo" DataSourceID="BopDBFamiliaProductos" DefaultMode="Insert" Width="331px">
            <EditItemTemplate>
                Codigo:
                <asp:Label ID="CodigoLabel1" runat="server" Text='<%# Eval("Codigo") %>' />
                <br />
                FamiliaProducto:
                <asp:TextBox ID="FamiliaProductoTextBox" runat="server" Text='<%# Bind("FamiliaProducto") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                <table style="width: 98%;">
                    <tr>
                        <td class="auto-style3">Codigo: </td>
                        <td class="auto-style2">
                            <asp:TextBox ID="CodigoTextBox" runat="server" MaxLength="2" Text='<%# Bind("Codigo") %>' Width="26px" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CodigoTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Familia Producto:</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="FamiliaProductoTextBox0" runat="server" MaxLength="20" Text='<%# Bind("FamiliaProducto") %>' Width="133px" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FamiliaProductoTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style3">Estado:</td>
                        <td class="auto-style2">
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
                FamiliaProducto:
                <asp:Label ID="FamiliaProductoLabel" runat="server" Text='<%# Bind("FamiliaProducto") %>' />
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
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Codigo" DataSourceID="BopDBFamiliaProductos">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
            <asp:BoundField DataField="Codigo" HeaderText="Codigo" ReadOnly="True" SortExpression="Codigo" />
            <asp:BoundField DataField="FamiliaProducto" HeaderText="Familia Producto" SortExpression="FamiliaProducto" />
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
    <asp:SqlDataSource ID="BopDBFamiliaProductos" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [FamiliaProductos] WHERE [Codigo] = @original_Codigo AND [FamiliaProducto] = @original_FamiliaProducto AND [Estado] = @original_Estado" InsertCommand="p_ValidaInsertaFAMILIAPRODUCTOS" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [FamiliaProductos]" UpdateCommand="UPDATE [FamiliaProductos] SET [FamiliaProducto] = @FamiliaProducto, [Estado] = @Estado WHERE [Codigo] = @original_Codigo AND [FamiliaProducto] = @original_FamiliaProducto AND [Estado] = @original_Estado" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="original_Codigo" Type="String" />
            <asp:Parameter Name="original_FamiliaProducto" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Codigo" Type="String" />
            <asp:Parameter Name="FamiliaProducto" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Done" Type="Boolean" />
            <asp:Parameter Name="Msg" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="FamiliaProducto" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="original_Codigo" Type="String" />
            <asp:Parameter Name="original_FamiliaProducto" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>
