<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modulos.aspx.cs" Inherits="BitOp.Admin.Modulos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

        .auto-style1 {
            width: 86px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>MODULOS</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Modulo" DataSourceID="BopDBModulos" DefaultMode="Insert" Width="300px">
            <EditItemTemplate>
                Modulo:
                <asp:Label ID="ModuloLabel1" runat="server" Text='<%# Eval("Modulo") %>' />
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
                &nbsp;<table style="width:100%;">
                    <tr>
                        <td class="auto-style1">Módulo:</td>
                        <td>
                            <asp:TextBox ID="ModuloTextBox" runat="server" Text='<%# Bind("Modulo") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ModuloTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Descripción: </td>
                        <td>
                            <asp:TextBox ID="DescripciónTextBox0" runat="server" Height="22px" MaxLength="30" Text='<%# Bind("Descripción") %>' Width="243px" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Estado:</td>
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
                Modulo:
                <asp:Label ID="ModuloLabel" runat="server" Text='<%# Eval("Modulo") %>' />
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
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Modulo" DataSourceID="BopDBModulos" EnableModelValidation="False">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
                <asp:BoundField DataField="Modulo" HeaderText="Modulo" ReadOnly="True" SortExpression="Modulo" />
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
        <asp:SqlDataSource ID="BopDBModulos" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Modulos] WHERE [Modulo] = @original_Modulo AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado" InsertCommand="p_ValidaInsertaModulo" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Modulos]" UpdateCommand="UPDATE [Modulos] SET [Descripción] = @Descripción, [Estado] = @Estado WHERE [Modulo] = @original_Modulo AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado" InsertCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="original_Modulo" Type="String" />
                <asp:Parameter Name="original_Descripción" Type="String" />
                <asp:Parameter Name="original_Estado" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Modulo" Type="String" />
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Done" Type="Boolean" />
                <asp:Parameter Name="Msg" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="original_Modulo" Type="String" />
                <asp:Parameter Name="original_Descripción" Type="String" />
                <asp:Parameter Name="original_Estado" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
