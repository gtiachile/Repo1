<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Centros.aspx.cs" Inherits="BitOp.Admin.Centros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style10 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Centros</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Centro" DataSourceID="BopDBCentros" DefaultMode="Insert">
            <EditItemTemplate>
                Centro:
                <asp:Label ID="CentroLabel1" runat="server" Text='<%# Eval("Centro") %>' />
                <br />
                Descripción:
                <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Dirección:
                <asp:TextBox ID="DirecciónTextBox" runat="server" Text='<%# Bind("Dirección") %>' />
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
                        <td>Centro:</td>
                        <td>
                            <asp:TextBox ID="CentroTextBox" runat="server" Text='<%# Bind("Centro") %>' MaxLength="10" Width="26px" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CentroTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>Descripción:</td>
                        <td>
                            <asp:TextBox ID="DescripciónTextBox0" runat="server" Text='<%# Bind("Descripción") %>' MaxLength="15" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style10">Dirección:</td>
                        <td class="auto-style10">
                            <asp:TextBox ID="DirecciónTextBox0" runat="server" MaxLength="30" Text='<%# Bind("Dirección") %>' Width="239px" />
                        </td>
                        <td class="auto-style10">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DirecciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
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
                Centro:
                <asp:Label ID="CentroLabel" runat="server" Text='<%# Eval("Centro") %>' />
                <br />
                Descripción:
                <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Dirección:
                <asp:Label ID="DirecciónLabel" runat="server" Text='<%# Bind("Dirección") %>' />
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
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Centro" DataSourceID="BopDBCentros">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
            <asp:BoundField DataField="Centro" HeaderText="Centro" ReadOnly="True" SortExpression="Centro" />
            <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
            <asp:TemplateField HeaderText="Dirección" SortExpression="Dirección">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" MaxLength="30" Text='<%# Bind("Dirección") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dirección") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [Estados]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="BopDBCentros" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Centros] WHERE [Centro] = @original_Centro AND [Descripción] = @original_Descripción AND [Dirección] = @original_Dirección AND [Estado] = @original_Estado" InsertCommand="p_ValidaInsertaCENTROS" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Centro], [Descripción], [Dirección], [Estado] FROM [Centros]" UpdateCommand="UPDATE [Centros] SET [Descripción] = @Descripción, [Dirección] = @Dirección, [Estado] = @Estado WHERE [Centro] = @original_Centro AND [Descripción] = @original_Descripción AND [Dirección] = @original_Dirección AND [Estado] = @original_Estado" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="original_Centro" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Dirección" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Centro" Type="String" />
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Dirección" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Done" Type="Boolean" />
            <asp:Parameter Name="Msg" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Dirección" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="original_Centro" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Dirección" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>
