<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tipos_Detencion.aspx.cs" Inherits="BitOp.Admin.Tipos_Detencion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
    TIPOS DE DETENCION</p>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Tipo" DataSourceID="BopDBTipoDetencion" DefaultMode="Insert">
            <EditItemTemplate>
                Tipo:
                <asp:Label ID="TipoLabel1" runat="server" Text='<%# Eval("Tipo") %>' />
                <br />
                Descripción:
                <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                &nbsp;&nbsp;<table style="width:100%;">
                    <tr>
                        <td>Tipo:</td>
                        <td>
                            <asp:TextBox ID="TipoTextBox" runat="server" MaxLength="2" Text='<%# Bind("Tipo") %>' Width="16px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Descripción:</td>
                        <td>
                            <asp:TextBox ID="DescripciónTextBox0" runat="server" MaxLength="30" Text='<%# Bind("Descripción") %>' />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td>
                            <asp:DropDownList ID="DropDownListEstado" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                <asp:ListItem>Activo</asp:ListItem>
                                <asp:ListItem>Inactivo</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Tipo:
                <asp:Label ID="TipoLabel" runat="server" Text='<%# Eval("Tipo") %>' />
                <br />
                Descripción:
                <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
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
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Tipo" DataSourceID="BopDBTipoDetencion">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" ReadOnly="True" SortExpression="Tipo" />
            <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
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
    <asp:SqlDataSource ID="BopDBTipoDetencion" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [TipoDetencion] WHERE [Tipo] = @original_Tipo AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado" InsertCommand="INSERT INTO [TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (@Tipo, @Descripción, @Estado)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [TipoDetencion]" UpdateCommand="UPDATE [TipoDetencion] SET [Descripción] = @Descripción, [Estado] = @Estado WHERE [Tipo] = @original_Tipo AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado">
        <DeleteParameters>
            <asp:Parameter Name="original_Tipo" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Tipo" Type="String" />
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="original_Tipo" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>
