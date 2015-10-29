<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Equipos.aspx.cs" Inherits="BitOp.Admin.Equipos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>EQUIPOS</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Equipo" DataSourceID="BopDBEquipos" DefaultMode="Insert">
            <EditItemTemplate>
                Equipo:
                <asp:Label ID="EquipoLabel1" runat="server" Text='<%# Eval("Equipo") %>' />
                <br />
                Proceso:
                <asp:TextBox ID="ProcesoTextBox" runat="server" Text='<%# Bind("Proceso") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                Descripción:
                <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                &nbsp;<table style="width:100%;">
                    <tr>
                        <td>Equipo:</td>
                        <td>
                            <asp:TextBox ID="EquipoTextBox" runat="server" Text='<%# Bind("Equipo") %>' Width="64px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Descripción:</td>
                        <td>
                            <asp:TextBox ID="DescripciónTextBox" runat="server" MaxLength="30" Text='<%# Bind("Descripción") %>' Width="196px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Proceso:</td>
                        <td class="auto-style1">
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBProcesosFV" DataTextField="Descrip" DataValueField="Proceso" SelectedValue='<%# Bind("Proceso") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBProcesosFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT Proceso, Proceso + N' - ' + Descripción AS Descrip FROM Procesos"></asp:SqlDataSource>
                        </td>
                        <td class="auto-style1"></td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Estado] FROM [Estados]"></asp:SqlDataSource>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Equipo:
                <asp:Label ID="EquipoLabel" runat="server" Text='<%# Eval("Equipo") %>' />
                <br />
                Proceso:
                <asp:Label ID="ProcesoLabel" runat="server" Text='<%# Bind("Proceso") %>' />
                <br />
                Estado:
                <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                Descripción:
                <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="BopDBEquipos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Equipos] WHERE [Equipo] = @Equipo" InsertCommand="INSERT INTO [Equipos] ([Equipo], [Proceso], [Estado], [Descripción]) VALUES (@Equipo, @Proceso, @Estado, @Descripción)" SelectCommand="SELECT [Equipo], [Proceso], [Estado], [Descripción] FROM [Equipos]" UpdateCommand="UPDATE [Equipos] SET [Proceso] = @Proceso, [Estado] = @Estado, [Descripción] = @Descripción WHERE [Equipo] = @Equipo">
            <DeleteParameters>
                <asp:Parameter Name="Equipo" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Equipo" Type="String" />
                <asp:Parameter Name="Proceso" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Descripción" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Proceso" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Equipo" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Equipo" DataSourceID="BopDBEquipos">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
                <asp:BoundField DataField="Equipo" HeaderText="Equipo" ReadOnly="True" SortExpression="Equipo" />
                <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
                <asp:TemplateField HeaderText="Proceso" SortExpression="Proceso">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBProcesosGV" DataTextField="Descrip" DataValueField="Proceso" SelectedValue='<%# Bind("Proceso") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBProcesosGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT Proceso, Proceso + N' - ' + Descripción AS Descrip FROM Procesos"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Proceso") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBEstado" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBEstado" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Estado] FROM [Estados]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
