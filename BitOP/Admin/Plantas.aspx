<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Plantas.aspx.cs" Inherits="BitOp.Admin.Plantas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Plantas</h3>
<p>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Planta" DataSourceID="BopDBPlantas" DefaultMode="Insert">
        <EditItemTemplate>
            Planta:
            <asp:Label ID="PlantaLabel1" runat="server" Text='<%# Eval("Planta") %>' />
            <br />
            Descripción:
            <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
            <br />
            Estado:
            <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
            <br />
            Centro:
            <asp:TextBox ID="CentroTextBox" runat="server" Text='<%# Bind("Centro") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            <table style="width:100%;">
                <tr>
                    <td>Planta:</td>
                    <td>
                        <asp:TextBox ID="PlantaTextBox" runat="server" Text='<%# Bind("Planta") %>' MaxLength="10" Width="71px" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="PlantaTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Descripción:</td>
                    <td>
                        <asp:TextBox ID="DescripciónTextBox0" runat="server" Text='<%# Bind("Descripción") %>' MaxLength="20" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Centro:</td>
                    <td>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BopDBCentros0" DataTextField="Centro" DataValueField="Centro" SelectedValue='<%# Bind("Centro") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBCentros0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Centro] FROM [Centros]"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Estado: </td>
                    <td>
                        <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("Estado") %>'>
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
            Planta:
            <asp:Label ID="PlantaLabel" runat="server" Text='<%# Eval("Planta") %>' />
            <br />
            Descripción:
            <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
            <br />
            Estado:
            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
            <br />
            Centro:
            <asp:Label ID="CentroLabel" runat="server" Text='<%# Bind("Centro") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>
</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Planta" DataSourceID="BopDBPlantas">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
                <asp:BoundField DataField="Planta" HeaderText="Planta" ReadOnly="True" SortExpression="Planta" />
                <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
                <asp:TemplateField HeaderText="Centro" SortExpression="Centro">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBCentros" DataTextField="Centro" DataValueField="Centro" SelectedValue='<%# Bind("Centro") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBCentros" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Centro] FROM [Centros]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBCentros" DataTextField="Descripción" DataValueField="Centro" Enabled="False" SelectedValue='<%# Bind("Centro") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBCentros" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Centro], [Descripción] FROM [Centros]"></asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [Estados]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="BopDBPlantas" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Plantas] WHERE [Planta] = @original_Planta AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado AND [Centro] = @original_Centro" InsertCommand="p_ValidaInsertaPLANTAS" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Planta], [Descripción], [Estado], [Centro] FROM [Plantas]" UpdateCommand="UPDATE [Plantas] SET [Descripción] = @Descripción, [Estado] = @Estado, [Centro] = @Centro WHERE [Planta] = @original_Planta AND [Descripción] = @original_Descripción AND [Estado] = @original_Estado AND [Centro] = @original_Centro" InsertCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="original_Planta" Type="String" />
                <asp:Parameter Name="original_Descripción" Type="String" />
                <asp:Parameter Name="original_Estado" Type="String" />
                <asp:Parameter Name="original_Centro" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Planta" Type="String" />
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Centro" Type="String" />
                <asp:Parameter Name="Done" Type="Boolean" />
                <asp:Parameter Name="Msg" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Centro" Type="String" />
                <asp:Parameter Name="original_Planta" Type="String" />
                <asp:Parameter Name="original_Descripción" Type="String" />
                <asp:Parameter Name="original_Estado" Type="String" />
                <asp:Parameter Name="original_Centro" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
