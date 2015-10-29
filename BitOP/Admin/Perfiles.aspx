<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfiles.aspx.cs" Inherits="BitOp.Admin.Perfiles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>PERFILES</h3>
<p>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Perfil" DataSourceID="BopDBPerfiles" DefaultMode="Insert">
        <EditItemTemplate>
            Perfil:
            <asp:Label ID="PerfilLabel1" runat="server" Text='<%# Eval("Perfil") %>' />
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
            <table style="width:100%;">
                <tr>
                    <td>Perfil: </td>
                    <td>
                        <asp:TextBox ID="PerfilTextBox" runat="server" Text='<%# Bind("Perfil") %>' />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="PerfilTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Descripción: </td>
                    <td>
                        <asp:TextBox ID="DescripciónTextBox0" runat="server" MaxLength="30" Text='<%# Bind("Descripción") %>' Width="262px" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Estado:</td>
                    <td>
                        <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("Estado") %>'>
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
            Perfil:
            <asp:Label ID="PerfilLabel" runat="server" Text='<%# Eval("Perfil") %>' />
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
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Perfil" DataSourceID="BopDBPerfiles">
    <Columns>
        <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
        <asp:BoundField DataField="Perfil" HeaderText="Perfil" ReadOnly="True" SortExpression="Perfil" />
        <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
        <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [Estados]"></asp:SqlDataSource>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="BopDBPerfiles" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Perfiles] WHERE [Perfil] = @original_Perfil AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado" InsertCommand="p_ValidaInsertaPerfil" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Perfiles]" UpdateCommand="UPDATE [Perfiles] SET [Descripción] = @Descripción, [Estado] = @Estado WHERE [Perfil] = @original_Perfil AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado" InsertCommandType="StoredProcedure">
    <DeleteParameters>
        <asp:Parameter Name="original_Perfil" Type="String" />
        <asp:Parameter Name="original_Descripción" Type="String" />
        <asp:Parameter Name="original_Estado" Type="String" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Perfil" Type="String" />
        <asp:Parameter Name="Descripción" Type="String" />
        <asp:Parameter Name="Estado" Type="String" />
        <asp:Parameter Name="Done" Type="Boolean" />
        <asp:Parameter Name="Msg" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Descripción" Type="String" />
        <asp:Parameter Name="Estado" Type="String" />
        <asp:Parameter Name="original_Perfil" Type="String" />
        <asp:Parameter Name="original_Descripción" Type="String" />
        <asp:Parameter Name="original_Estado" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
