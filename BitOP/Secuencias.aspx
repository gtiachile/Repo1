<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Secuencias.aspx.cs" Inherits="BitOp.Admin.Secuencias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>SECUENCIAS</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="tipo" DataSourceID="BopDBSecuencias" DefaultMode="Insert">
            <EditItemTemplate>
                tipo:
                <asp:Label ID="tipoLabel1" runat="server" Text='<%# Eval("tipo") %>' />
                <br />
                inicial:
                <asp:TextBox ID="inicialTextBox" runat="server" Text='<%# Bind("inicial") %>' />
                <br />
                actual:
                <asp:TextBox ID="actualTextBox" runat="server" Text='<%# Bind("actual") %>' />
                <br />
                incremento:
                <asp:TextBox ID="incrementoTextBox" runat="server" Text='<%# Bind("incremento") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                &nbsp;<table style="width:100%;">
                    <tr>
                        <td>Tipo:</td>
                        <td>
                            <asp:TextBox ID="tipoTextBox" runat="server" MaxLength="10" Text='<%# Bind("tipo") %>' Width="55px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Inicial:</td>
                        <td>
                            <asp:TextBox ID="inicialTextBox" runat="server" Text='<%# Bind("inicial") %>' TextMode="Number" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Actual:</td>
                        <td>
                            <asp:TextBox ID="actualTextBox" runat="server" Text='<%# Bind("actual") %>' TextMode="Number" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Incremento:</td>
                        <td>
                            <asp:TextBox ID="incrementoTextBox" runat="server" Height="16px" Text='<%# Bind("incremento") %>' TextMode="Number" Width="46px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                tipo:
                <asp:Label ID="tipoLabel" runat="server" Text='<%# Eval("tipo") %>' />
                <br />
                inicial:
                <asp:Label ID="inicialLabel" runat="server" Text='<%# Bind("inicial") %>' />
                <br />
                actual:
                <asp:Label ID="actualLabel" runat="server" Text='<%# Bind("actual") %>' />
                <br />
                incremento:
                <asp:Label ID="incrementoLabel" runat="server" Text='<%# Bind("incremento") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="BopDBSecuencias" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Secuencias] WHERE [tipo] = @tipo" InsertCommand="INSERT INTO [Secuencias] ([tipo], [inicial], [actual], [incremento]) VALUES (@tipo, @inicial, @actual, @incremento)" SelectCommand="SELECT [tipo], [inicial], [actual], [incremento] FROM [Secuencias]" UpdateCommand="UPDATE [Secuencias] SET [inicial] = @inicial, [actual] = @actual, [incremento] = @incremento WHERE [tipo] = @tipo">
            <DeleteParameters>
                <asp:Parameter Name="tipo" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="tipo" Type="String" />
                <asp:Parameter Name="inicial" Type="Int64" />
                <asp:Parameter Name="actual" Type="Int64" />
                <asp:Parameter Name="incremento" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="inicial" Type="Int64" />
                <asp:Parameter Name="actual" Type="Int64" />
                <asp:Parameter Name="incremento" Type="Int32" />
                <asp:Parameter Name="tipo" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="tipo" DataSourceID="BopDBSecuencias">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/Cancel.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
                <asp:BoundField DataField="tipo" HeaderText="Tipo" ReadOnly="True" SortExpression="tipo" />
                <asp:BoundField DataField="inicial" HeaderText="Inicial" SortExpression="inicial" />
                <asp:BoundField DataField="actual" HeaderText="Actual" SortExpression="actual" />
                <asp:BoundField DataField="incremento" HeaderText="Incremento" SortExpression="incremento" />
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
