<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Procesos.aspx.cs" Inherits="BitOp.Admin.Procesos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 46px;
        }
        .auto-style2 {
            width: 2px;
        }
    .auto-style3 {
        width: 322px;
        border-style: solid;
        border-width: 1px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        PROCESOS</p>
<p>
        <table style="width:100%;">
            <tr>
                <td class="auto-style3">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="Proceso" DataSourceID="BopDBProc" DefaultMode="Insert">
            <EditItemTemplate>
                Proceso:
                <asp:Label ID="ProcesoLabel1" runat="server" Text='<%# Eval("Proceso") %>' />
                <br />
                Descripción:
                <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Estado:
                <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                Linea:
                <asp:TextBox ID="LineaTextBox" runat="server" Text='<%# Bind("Linea") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                <table style="width:100%;">
                    <tr>
                        <td>Proceso: </td>
                        <td>
                            <asp:TextBox ID="ProcesoTextBox" runat="server" Text='<%# Bind("Proceso") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ProcesoTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>Descripción: </td>
                        <td>
                            <asp:TextBox ID="DescripciónTextBox0" runat="server" Text='<%# Bind("Descripción") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>Area: </td>
                        <td>
                            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBAreasForm" DataTextField="Descripción" DataValueField="Area" SelectedValue='<%# Bind("Area") %>'>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="BopDBAreasForm" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Estado: </td>
                        <td>
                            <asp:DropDownList ID="DropDownListEstado" runat="server" SelectedValue='<%# Bind("Estado") %>'>
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
                Proceso:
                <asp:Label ID="ProcesoLabel" runat="server" Text='<%# Eval("Proceso") %>' />
                <br />
                Descripción:
                <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
                <br />
                Estado:
                <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                <br />
                Linea:
                <asp:Label ID="LineaLabel" runat="server" Text='<%# Bind("Linea") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
                </td>
                <td style="padding: 0px">&nbsp;</td>
            </tr>
        </table>
    </p>
<p>
        <table style="width:100%;">
            <tr>
                <td class="auto-style1" valign="top">Planta:</td>
                <td class="auto-style2" valign="top">
                    <asp:DropDownList ID="DropDownListPlanta" runat="server" AutoPostBack="True" DataSourceID="BopDBFiltroPlanta" DataTextField="Descripción" DataValueField="Planta">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBFiltroPlanta" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                </td>
                <td valign="top">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1" valign="top">Area:</td>
                <td class="auto-style2">
                    <asp:ListBox ID="ListBoxArea" runat="server" AutoPostBack="True" DataSourceID="BopDBAreasFiltro" DataTextField="Descripción" DataValueField="Area" Width="165px"></asp:ListBox>
                    <asp:SqlDataSource ID="BopDBAreasFiltro" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Proceso" DataSourceID="BopDBProc">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
                <asp:BoundField DataField="Proceso" HeaderText="Proceso" ReadOnly="True" SortExpression="Proceso" />
                <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
                <asp:TemplateField HeaderText="Area" SortExpression="Area" ConvertEmptyStringToNull="False">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBAreasDet" DataTextField="Descripción" DataValueField="Area" SelectedValue='<%# Bind("Area") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBAreasDet" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBAreasDet" DataTextField="Descripción" DataValueField="Area" Enabled="False" SelectedValue='<%# Bind("Area") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBAreasDet" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
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
    </p>
    <p>
        <asp:SqlDataSource ID="BopDBProc" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Procesos] WHERE [Proceso] = @Proceso" InsertCommand="p_ValidaInsertaPROCESOS" SelectCommand="SELECT * FROM [Procesos] WHERE ([Area] = @Area)" UpdateCommand="UPDATE [Procesos] SET [Descripción] = @Descripción, [Fecha Creación] = @Fecha_Creación, [Estado] = @Estado, [Area] = @Area WHERE [Proceso] = @Proceso" InsertCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="Proceso" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Proceso" Type="String" />
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Fecha_Creación" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Area" Type="String" />
                <asp:Parameter Name="Done" Type="Boolean" />
                <asp:Parameter Name="Msg" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ListBoxArea" Name="Area" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Descripción" Type="String" />
                <asp:Parameter Name="Fecha_Creación" Type="String" />
                <asp:Parameter Name="Estado" Type="String" />
                <asp:Parameter Name="Area" Type="String" />
                <asp:Parameter Name="Proceso" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
