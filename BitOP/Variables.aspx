<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Variables.aspx.cs" Inherits="BitOp.Admin.Variables" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style11 {
            width: 99%;
            height: 198px;
        }
        .auto-style13 {
            height: 34px;
        }
        .auto-style14 {
            height: 18px;
        }
        .auto-style15 {
            height: 13px;
        }
        .auto-style16 {
            height: 4px;
        }
        .auto-style17 {
            height: 12px;
            width: 261px;
        }
        .auto-style18 {
            height: 18px;
            width: 261px;
        }
        .auto-style19 {
            height: 13px;
            width: 261px;
        }
        .auto-style20 {
            height: 4px;
            width: 261px;
        }
        .auto-style21 {
            height: 12px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>VARIABLES DE PROCESO</h3>
    <p>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Variable" DataSourceID="BopDBVariables" DefaultMode="Insert">
            <EditItemTemplate>
                Variable:
                <asp:Label ID="VariableLabel1" runat="server" Text='<%# Eval("Variable") %>' />
                <br />
                Equipo:
                <asp:TextBox ID="EquipoTextBox" runat="server" Text='<%# Bind("Equipo") %>' />
                <br />
                Descripcion:
                <asp:TextBox ID="DescripcionTextBox" runat="server" Text='<%# Bind("Descripcion") %>' />
                <br />
                Unidad:
                <asp:TextBox ID="UnidadTextBox" runat="server" Text='<%# Bind("Unidad") %>' />
                <br />
                LimSup:
                <asp:TextBox ID="LimSupTextBox" runat="server" Text='<%# Bind("LimSup") %>' />
                <br />
                LimInf:
                <asp:TextBox ID="LimInfTextBox" runat="server" Text='<%# Bind("LimInf") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                <table class="auto-style11">
                    <tr>
                        <td class="auto-style21">Variable:</td>
                        <td class="auto-style21">
                            <asp:TextBox ID="VariableTextBox" runat="server" MaxLength="10" Text='<%# Bind("Variable") %>' />
                        </td>
                        <td class="auto-style21">Descripcion:</td>
                        <td class="auto-style17">
                            <asp:TextBox ID="DescripcionTextBox" runat="server" MaxLength="50" Text='<%# Bind("Descripcion") %>' Width="200px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style14">Equipo:</td>
                        <td class="auto-style14">
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BobDBEquiposFV" DataTextField="descripcion" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BobDBEquiposFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Equipo], [Equipo]+' - '+[Descripción] as descripcion FROM [Equipos] where [Estado]='Activo'"></asp:SqlDataSource>
                        </td>
                        <td class="auto-style14">Unidad: </td>
                        <td class="auto-style18">
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BobDBUnidadesFV" DataTextField="Descripcion" DataValueField="Unidad" SelectedValue='<%# Bind("Unidad") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BobDBUnidadesFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Unidad], [Descripcion] FROM [Unidades]"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style15">Límite Sup.:</td>
                        <td class="auto-style15">
                            <asp:TextBox ID="LimSupTextBox" runat="server" Height="16px" Text='<%# Bind("LimSup") %>' TextMode="Number" />
                        </td>
                        <td class="auto-style15">Límite Inf.:</td>
                        <td class="auto-style19">
                            <asp:TextBox ID="LimInfTextBox" runat="server" Text='<%# Bind("LimInf") %>' TextMode="Number" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style16">Estado:</td>
                        <td class="auto-style16">
                            <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                <asp:ListItem>Activo</asp:ListItem>
                                <asp:ListItem>Inactivo</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style16"></td>
                        <td class="auto-style20"></td>
                    </tr>
                </table>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                Variable:
                <asp:Label ID="VariableLabel" runat="server" Text='<%# Eval("Variable") %>' />
                <br />
                Equipo:
                <asp:Label ID="EquipoLabel" runat="server" Text='<%# Bind("Equipo") %>' />
                <br />
                Descripcion:
                <asp:Label ID="DescripcionLabel" runat="server" Text='<%# Bind("Descripcion") %>' />
                <br />
                Unidad:
                <asp:Label ID="UnidadLabel" runat="server" Text='<%# Bind("Unidad") %>' />
                <br />
                LimSup:
                <asp:Label ID="LimSupLabel" runat="server" Text='<%# Bind("LimSup") %>' />
                <br />
                LimInf:
                <asp:Label ID="LimInfLabel" runat="server" Text='<%# Bind("LimInf") %>' />
                <br />
                Estado:
                <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="BopDBVariables" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Variables] WHERE [Variable] = @Variable" InsertCommand="INSERT INTO [Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Estado]) VALUES (@Variable, @Equipo, @Descripcion, @Unidad, @LimSup, @LimInf, @Estado)" SelectCommand="SELECT [Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Estado] FROM [Variables]" UpdateCommand="UPDATE [Variables] SET [Equipo] = @Equipo, [Descripcion] = @Descripcion, [Unidad] = @Unidad, [LimSup] = @LimSup, [LimInf] = @LimInf, [Estado] = @Estado WHERE [Variable] = @Variable">
            <DeleteParameters>
                <asp:Parameter Name="Variable" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Variable" Type="String" />
                <asp:Parameter Name="Equipo" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Unidad" Type="String" />
                <asp:Parameter Name="LimSup" Type="Decimal" />
                <asp:Parameter Name="LimInf" Type="Decimal" />
                <asp:Parameter Name="Estado" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Equipo" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Unidad" Type="String" />
                <asp:Parameter Name="LimSup" Type="Decimal" />
                <asp:Parameter Name="LimInf" Type="Decimal" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Variable" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Variable" DataSourceID="BopDBVariables">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/Cancel.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" />
                <asp:TemplateField HeaderText="Variable" SortExpression="Variable">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Variable") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Variable") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBEquiposGV" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBEquiposGV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Equipo], [Descripción] FROM [Equipos] where estado='Activo'"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Equipo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Descripcion" SortExpression="Descripcion">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="50" Text='<%# Bind("Descripcion") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Descripcion") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unidad" SortExpression="Unidad">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBUnidades" DataTextField="Descripcion" DataValueField="Unidad" SelectedValue='<%# Bind("Unidad") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Unidad], [Descripcion] FROM [Unidades] where estado='Activo'"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Unidad") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Lim.Sup." SortExpression="LimSup">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("LimSup") %>' TextMode="Number"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("LimSup") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Lim.Inf." SortExpression="LimInf">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("LimInf") %>' TextMode="Number"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("LimInf") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList6" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                            <asp:ListItem>Activo</asp:ListItem>
                            <asp:ListItem>Inactivo</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </p>
</asp:Content>
