<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Formatos.aspx.cs" Inherits="BitOp.Admin.Formatos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    FORMATOS DE PRODUCTO<br />
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Formato,CodigoFamilia" DataSourceID="BopDBFormatos" DefaultMode="Insert" >
        <EditItemTemplate>
            Formato:
            <asp:Label ID="FormatoLabel1" runat="server" Text='<%# Eval("Formato") %>' />
            <br />
            CodigoFamilia:
            <asp:Label ID="CodigoFamiliaLabel1" runat="server" Text='<%# Eval("CodigoFamilia") %>' />
            <br />
            Rendimiento:
            <asp:TextBox ID="RendimientoTextBox" runat="server" Text='<%# Bind("Rendimiento") %>' />
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
                    <td>Formato:</td>
                    <td>
                        <asp:TextBox ID="FormatoTextBox" runat="server" MaxLength="10" Text='<%# Bind("Formato") %>' />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FormatoTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Familia:</td>
                    <td>
                        <asp:DropDownList ID="DropDownListFamiliaFV" runat="server" DataSourceID="BopDBFamiliasFV" DataTextField="FamiliaProducto" DataValueField="Codigo" SelectedValue='<%# Bind("CodigoFamilia") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBFamiliasFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [FamiliaProducto] FROM [FamiliaProductos]"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Rendimiento:</td>
                    <td>
                        <asp:TextBox ID="RendimientoTextBox" runat="server" Text='<%# Bind("Rendimiento") %>' TextMode="Number" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="RendimientoTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
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
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" OnClick="InsertButton_Click" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            Formato:
            <asp:Label ID="FormatoLabel" runat="server" Text='<%# Eval("Formato") %>' />
            <br />
            CodigoFamilia:
            <asp:Label ID="CodigoFamiliaLabel" runat="server" Text='<%# Eval("CodigoFamilia") %>' />
            <br />
            Rendimiento:
            <asp:Label ID="RendimientoLabel" runat="server" Text='<%# Bind("Rendimiento") %>' />
            <br />
            Estado:
            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="BopDBFormatos" runat="server"
         ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>"
         DeleteCommand="DELETE FROM [Formatos] WHERE [Formato] = @Formato AND [CodigoFamilia] = @CodigoFamilia"
         InsertCommand="p_ValidaInsertaFORMATOS"
         SelectCommand="SELECT [Formato], [CodigoFamilia], [Rendimiento], [Estado] FROM [Formatos]"
         UpdateCommand="UPDATE [Formatos] SET [Rendimiento] = @Rendimiento, [Estado] = @Estado WHERE [Formato] = @Formato AND [CodigoFamilia] = @CodigoFamilia"
         OnInserted="On_Inserted" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="Formato" Type="String" />
            <asp:Parameter Name="CodigoFamilia" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Formato" Type="String" />
            <asp:Parameter Name="CodigoFamilia" Type="String" />
            <asp:Parameter Name="Rendimiento" Type="Decimal" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Done" Type="Boolean" />
            <asp:Parameter Name="Msg" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Rendimiento" Type="Decimal" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Formato" Type="String" />
            <asp:Parameter Name="CodigoFamilia" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:DropDownList ID="DropDownListFamiliaFil" runat="server" DataSourceID="BopDBFamiliasFiltro" DataTextField="FamiliaProducto" DataValueField="Codigo" AutoPostBack="True">
    </asp:DropDownList>
    <asp:SqlDataSource ID="BopDBFamiliasFiltro" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [FamiliaProducto] FROM [FamiliaProductos]"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Formato,CodigoFamilia" DataSourceID="BopDBFormatosGV">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
            <asp:BoundField DataField="Formato" HeaderText="Formato" ReadOnly="True" SortExpression="Formato" />
            <asp:TemplateField HeaderText="Familia" SortExpression="CodigoFamilia">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="BopDBFamiliasGVI" DataTextField="FamiliaProducto" DataValueField="Codigo" Enabled="False" SelectedValue='<%# Bind("CodigoFamilia") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBFamiliasGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [FamiliaProducto] FROM [FamiliaProductos]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="BopDBFamiliasGVI" DataTextField="FamiliaProducto" DataValueField="Codigo" Enabled="False" SelectedValue='<%# Bind("CodigoFamilia") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBFamiliasGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Codigo], [FamiliaProducto] FROM [FamiliaProductos]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rendimiento" SortExpression="Rendimiento">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Rendimiento") %>' TextMode="Number"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Rendimiento") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                        <asp:ListItem>Activo</asp:ListItem>
                        <asp:ListItem>Inactivo</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="BopDBFormatosGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Formatos] WHERE [Formato] = @Formato AND [CodigoFamilia] = @CodigoFamilia" InsertCommand="INSERT INTO [Formatos] ([Formato], [CodigoFamilia], [Rendimiento], [Estado]) VALUES (@Formato, @CodigoFamilia, @Rendimiento, @Estado)" SelectCommand="SELECT [Formato], [CodigoFamilia], [Rendimiento], [Estado] FROM [Formatos] WHERE ([CodigoFamilia] = @CodigoFamilia)" UpdateCommand="UPDATE [Formatos] SET [Rendimiento] = @Rendimiento, [Estado] = @Estado WHERE [Formato] = @Formato AND [CodigoFamilia] = @CodigoFamilia">
        <DeleteParameters>
            <asp:Parameter Name="Formato" Type="String" />
            <asp:Parameter Name="CodigoFamilia" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Formato" Type="String" />
            <asp:Parameter Name="CodigoFamilia" Type="String" />
            <asp:Parameter Name="Rendimiento" Type="Decimal" />
            <asp:Parameter Name="Estado" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListFamiliaFil" Name="CodigoFamilia" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Rendimiento" Type="Decimal" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Formato" Type="String" />
            <asp:Parameter Name="CodigoFamilia" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>
