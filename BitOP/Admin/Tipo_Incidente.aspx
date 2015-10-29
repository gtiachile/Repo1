<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tipo_Incidente.aspx.cs" Inherits="BitOp.Admin.Tipo_Incidente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        TIPOS DE INCIDENTE</p>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="TipoInicidente" DataSourceID="BopDBTipoIncidente" DefaultMode="Insert">
            <EditItemTemplate>
                TipoInicidente:
                <asp:Label ID="TipoInicidenteLabel1" runat="server" Text='<%# Eval("TipoInicidente") %>' />
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
                <table style="width:100%;">
                    <tr>
                        <td>Tipo Inicidente:</td>
                        <td>
                            <asp:TextBox ID="TipoInicidenteTextBox" runat="server" MaxLength="10" Text='<%# Bind("TipoInicidente") %>' Width="50px" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TipoInicidenteTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>Descripcion:</td>
                        <td>
                            <asp:TextBox ID="DescripcionTextBox" runat="server" MaxLength="50" Text='<%# Bind("Descripcion") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripcionTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>email alerta:</td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("emailAlerta") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox1" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
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
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                TipoInicidente:
                <asp:Label ID="TipoInicidenteLabel" runat="server" Text='<%# Eval("TipoInicidente") %>' />
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
        <asp:SqlDataSource ID="BopDBTipoIncidente" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [TiposIncidentes] WHERE [TipoInicidente] = @TipoInicidente" InsertCommand="p_ValidaInsertaTIPOSINCIDENTES" SelectCommand="SELECT [TipoInicidente], [Descripcion], [Estado], [emailAlerta] FROM [TiposIncidentes] where Estado='Activo'" UpdateCommand="UPDATE [TiposIncidentes] SET [Descripcion] = @Descripcion,[emailAlerta]=@emailAlerta, [Estado] = @Estado WHERE [TipoInicidente] = @TipoInicidente" InsertCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="TipoInicidente" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="TipoInicidente" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="emailAlerta" />
                <asp:Parameter Name="Done" Type="Boolean" />
                <asp:Parameter Name="Msg" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="emailAlerta" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="TipoInicidente" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="TipoInicidente" DataSourceID="BopDBTipoIncidente">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/Cancel(build)_194_32.bmp" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" InsertImageUrl="~/Images/NewRow.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
                <asp:BoundField DataField="TipoInicidente" HeaderText="Tipo Inicidente" ReadOnly="True" SortExpression="TipoInicidente" />
                <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" SortExpression="Descripcion" />
                <asp:TemplateField HeaderText="email Alerta" SortExpression="emailAlerta">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("emailAlerta") %>' TextMode="Email"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("emailAlerta") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                            <asp:ListItem>Activo</asp:ListItem>
                            <asp:ListItem>Inactivo</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
