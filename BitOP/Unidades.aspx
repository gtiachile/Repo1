<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Unidades.aspx.cs" Inherits="BitOp.Admin.Unidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>UNIDADES DE MEDIDA</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Unidad" DataSourceID="BopDBUnidades" DefaultMode="Insert">
            <EditItemTemplate>
                Unidad:
                <asp:Label ID="UnidadLabel1" runat="server" Text='<%# Eval("Unidad") %>' />
                <br />
                Descripcion:
                <asp:TextBox ID="DescripcionTextBox" runat="server" Text='<%# Bind("Descripcion") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                &nbsp;<table style="width:100%;">
                    <tr>
                        <td>Unidad:</td>
                        <td>
                            <asp:TextBox ID="UnidadTextBox" runat="server" MaxLength="5" Text='<%# Bind("Unidad") %>' Width="60px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Descripcion: </td>
                        <td>
                            <asp:TextBox ID="DescripcionTextBox" runat="server" MaxLength="15" Text='<%# Bind("Descripcion") %>' />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Estado") %>'>
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
                Unidad:
                <asp:Label ID="UnidadLabel" runat="server" Text='<%# Eval("Unidad") %>' />
                <br />
                Descripcion:
                <asp:Label ID="DescripcionLabel" runat="server" Text='<%# Bind("Descripcion") %>' />
                <br />
                Estado:
                <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="BopDBUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Unidades] WHERE [Unidad] = @Unidad" InsertCommand="INSERT INTO [Unidades] ([Unidad], [Descripcion], [Estado]) VALUES (@Unidad, @Descripcion, @Estado)" SelectCommand="SELECT [Unidad], [Descripcion], [Estado] FROM [Unidades]" UpdateCommand="UPDATE [Unidades] SET [Descripcion] = @Descripcion, [Estado] = @Estado WHERE [Unidad] = @Unidad">
            <DeleteParameters>
                <asp:Parameter Name="Unidad" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Unidad" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Unidad" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Unidad" DataSourceID="BopDBUnidades">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
                <asp:BoundField DataField="Unidad" HeaderText="Unidad" ReadOnly="True" SortExpression="Unidad" />
                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion" />
                <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBEstados" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBEstados" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Estado] FROM [Estados]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
