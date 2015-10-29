<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Turno_Planta.aspx.cs" Inherits="BitOp.Admin.Turno_Planta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>TURNOS POR PLANTA</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Codigo" DataSourceID="BopDBTurnosPlanta" DefaultMode="Insert">
            <EditItemTemplate>
                Codigo:
                <asp:Label ID="CodigoLabel1" runat="server" Text='<%# Eval("Codigo") %>' />
                <br />
                Descripción:
                <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Planta:
                <asp:TextBox ID="PlantaTextBox" runat="server" Text='<%# Bind("Planta") %>' />
                <br />
                Turno:
                <asp:TextBox ID="TurnoTextBox" runat="server" Text='<%# Bind("Turno") %>' />
                <br />
                DotacionStd:
                <asp:TextBox ID="DotacionStdTextBox" runat="server" Text='<%# Bind("DotacionStd") %>' />
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
                        <td>Codigo:</td>
                        <td>
                            <asp:TextBox ID="CodigoTextBox" runat="server" MaxLength="10" Text='<%# Bind("Codigo") %>' Width="76px" />
                        </td>
                        <td>Descripción:</td>
                        <td>
                            <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>Planta:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBPlantasFV" DataTextField="Descripción" DataValueField="Planta" SelectedValue='<%# Bind("Planta") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBPlantasFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                        </td>
                        <td>Turno:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBTurnos" DataTextField="Turno" DataValueField="Turno" SelectedValue='<%# Bind("Turno") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBTurnos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Turno] FROM [Turnos]"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>Dotacion Est.:</td>
                        <td>
                            <asp:TextBox ID="DotacionStdTextBox" runat="server" Text='<%# Bind("DotacionStd") %>' TextMode="Number" Width="45px" />
                        </td>
                        <td>Estado:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                <asp:ListItem Selected="True">Activo</asp:ListItem>
                                <asp:ListItem>Inactivo</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Hora inicio:</td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" MaxLength="5" Text='<%# Bind("HoraInicio") %>' Width="58px"></asp:TextBox>
                        </td>
                        <td>Hora Fin:</td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" MaxLength="5" Text='<%# Bind("HoraFin") %>' Width="58px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Codigo:
                <asp:Label ID="CodigoLabel" runat="server" Text='<%# Eval("Codigo") %>' />
                <br />
                Descripción:
                <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Planta:
                <asp:Label ID="PlantaLabel" runat="server" Text='<%# Bind("Planta") %>' />
                <br />
                Turno:
                <asp:Label ID="TurnoLabel" runat="server" Text='<%# Bind("Turno") %>' />
                <br />
                DotacionStd:
                <asp:Label ID="DotacionStdLabel" runat="server" Text='<%# Bind("DotacionStd") %>' />
                <br />
                Estado:
                <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="BopDBTurnosPlanta" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [TurnoPlanta] WHERE [Codigo] = @Codigo" InsertCommand="INSERT INTO [TurnoPlanta] ([Codigo], [Descripción], [Planta], [Turno], [DotacionStd], [Estado], [HoraInicio], [HoraFin]) VALUES (@Codigo, @Descripción, @Planta, @Turno, @DotacionStd, @Estado, @HoraInicio, @HoraFin)" SelectCommand="SELECT [Codigo], [Descripción], [Planta], [Turno], [DotacionStd], [Estado], [HoraInicio], [HoraFin] FROM [TurnoPlanta]" UpdateCommand="UPDATE [TurnoPlanta] SET [Descripción] = @Descripción, [Planta] = @Planta, [Turno] = @Turno, [DotacionStd] = @DotacionStd, [Estado] = @Estado, [HoraInicio] = @HoraInicio, [HoraFin] = @HoraFin WHERE [Codigo] = @Codigo">
            <DeleteParameters>
                <asp:Parameter Name="Codigo" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Codigo" Type="String" />
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Planta" Type="String" />
                <asp:Parameter Name="Turno" Type="String" />
                <asp:Parameter Name="DotacionStd" Type="Int32" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="HoraInicio" Type="String" />
                <asp:Parameter Name="HoraFin" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Planta" Type="String" />
                <asp:Parameter Name="Turno" Type="String" />
                <asp:Parameter Name="DotacionStd" Type="Int32" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="HoraInicio" Type="String" />
                <asp:Parameter Name="HoraFin" Type="String" />
                <asp:Parameter Name="Codigo" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Codigo" DataSourceID="BopDBTurnosPlanta">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
                <asp:BoundField DataField="Codigo" HeaderText="Codigo" ReadOnly="True" SortExpression="Codigo" />
                <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
                <asp:TemplateField HeaderText="Planta" SortExpression="Planta">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBPlantaGV" DataTextField="Descripción" DataValueField="Planta" SelectedValue='<%# Bind("Planta") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBPlantaGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Planta") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Turno" SortExpression="Turno">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBTurnosGV" DataTextField="Turno" DataValueField="Turno" SelectedValue='<%# Bind("Turno") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBTurnosGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Turno] FROM [Turnos]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Turno") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dot.Est." SortExpression="DotacionStd">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DotacionStd") %>' TextMode="Number" Width="53px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("DotacionStd") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Inicio" SortExpression="HoraInicio">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" MaxLength="5" Text='<%# Bind("HoraInicio") %>' Width="58px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("HoraInicio") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fin" SortExpression="HoraFin">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" MaxLength="5" Text='<%# Bind("HoraFin") %>' Width="58px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("HoraFin") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="BopDBEstadoGV" DataTextField="Estado" DataValueField="Estado" SelectedValue='<%# Bind("Estado") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBEstadoGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Estado] FROM [Estados]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
