<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Opciones.aspx.cs" Inherits="BitOp.Admin.Opciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

    .auto-style2 {
        height: 25px;
        width: 73px;
    }
    .auto-style4 {
        height: 25px;
        width: 245px;
    }
    .auto-style1 {
        height: 25px;
    }
    .auto-style7 {
        width: 73px;
    }
    .auto-style5 {
        width: 245px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>OPCIONES</h3>
<p>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="Opcion" DataSourceID="BopDBOpcionesFV" DefaultMode="Insert">
        <EditItemTemplate>
            Opcion:
            <asp:Label ID="OpcionLabel1" runat="server" Text='<%# Eval("Opcion") %>' />
            <br />
            Descripción:
            <asp:TextBox ID="DescripciónTextBox" runat="server" Text='<%# Bind("Descripción") %>' />
            <br />
            Modulo:
            <asp:TextBox ID="ModuloTextBox" runat="server" Text='<%# Bind("Modulo") %>' />
            <br />
            Estado:
            <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            &nbsp;<table style="width:50%;">
                <tr>
                    <td class="auto-style2">Opción:</td>
                    <td class="auto-style4" colspan="3">
                        <asp:TextBox ID="OpcionTextBox" runat="server" Text='<%# Bind("Opcion") %>' />
                    </td>
                    <td class="auto-style1">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="OpcionTextBox" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">Descripción:</td>
                    <td class="auto-style5" colspan="3">
                        <asp:TextBox ID="DescripciónTextBox0" runat="server" Text='<%# Bind("Descripción") %>' Width="258px" />
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DescripciónTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">Codigo Tx:</td>
                    <td class="auto-style5" colspan="3">
                        <asp:TextBox ID="TextBox3" runat="server" MaxLength="20" Text='<%# Bind("tx") %>'></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7">Módulo: </td>
                    <td class="auto-style5" colspan="3">
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="BopDBModulosFV" DataTextField="Modulo" DataValueField="Modulo" SelectedValue='<%# Bind("Modulo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="BopDBModulosFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Modulo], [Descripción] FROM [Modulos]"></asp:SqlDataSource>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7">Url:</td>
                    <td class="auto-style5" colspan="3">
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("url") %>' Width="295px"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style7">Tipo: </td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="DropDownList6" runat="server" SelectedValue='<%# Bind("tipo") %>'>
                            <asp:ListItem>Pagina</asp:ListItem>
                            <asp:ListItem>Menu</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style5">Estado:</td>
                    <td class="auto-style5">
                        <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("Estado") %>' style="text-align: left">
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
            Opcion:
            <asp:Label ID="OpcionLabel" runat="server" Text='<%# Eval("Opcion") %>' />
            <br />
            Descripción:
            <asp:Label ID="DescripciónLabel" runat="server" Text='<%# Bind("Descripción") %>' />
            <br />
            Modulo:
            <asp:Label ID="ModuloLabel" runat="server" Text='<%# Bind("Modulo") %>' />
            <br />
            Estado:
            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="BopDBOpcionesFV" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Opciones] WHERE [Opcion] = @original_Opcion AND [Descripción] = @original_Descripción AND [Modulo] = @original_Modulo AND [Estado] = @original_Estado" InsertCommand="p_ValidaInsertaOpcion" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Opciones]" UpdateCommand="UPDATE [Opciones] SET [Descripción] = @Descripción, [Modulo] = @Modulo, [Estado] = @Estado WHERE [Opcion] = @original_Opcion AND [Descripción] = @original_Descripción AND [Modulo] = @original_Modulo AND [Estado] = @original_Estado" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="original_Opcion" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Modulo" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Opcion" Type="String" />
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Modulo" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Tipo" />
            <asp:Parameter Name="Url" />
            <asp:Parameter Name="tx" Type="String" />
            <asp:Parameter Name="Done" Type="Boolean" />
            <asp:Parameter Name="Msg" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Modulo" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="original_Opcion" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Modulo" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </p>
<p>
    Módulo:
    <asp:DropDownList ID="DropDownListModulos" runat="server" AutoPostBack="True" DataSourceID="BopDBModulos" DataTextField="Modulo" DataValueField="Modulo">
    </asp:DropDownList>
    <asp:SqlDataSource ID="BopDBModulos" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Modulo] FROM [Modulos]">
    </asp:SqlDataSource>
</p>
<p>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Opcion" DataSourceID="BopDBOpciones" Width="80%">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/StopHS.png" DeleteImageUrl="~/Images/DeleteHS.png" EditImageUrl="~/Images/EditTableHS.png" SelectImageUrl="~/Images/ZoomHS.png" ShowDeleteButton="True" ShowEditButton="True" UpdateImageUrl="~/Images/saveHS.png" CausesValidation="False" />
            <asp:BoundField DataField="Opcion" HeaderText="Opcion" ReadOnly="True" SortExpression="Opcion" />
            <asp:BoundField DataField="Descripción" HeaderText="Descripción" SortExpression="Descripción" />
            <asp:TemplateField HeaderText="Cod.Tx." SortExpression="tx">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" MaxLength="20" Text='<%# Bind("tx") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("tx") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Modulo" SortExpression="Modulo">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBModulosGrilla" DataTextField="Modulo" DataValueField="Modulo" SelectedValue='<%# Bind("Modulo") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BopDBModulosGrilla" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Modulo] FROM [Modulos]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Modulo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="tipo" SortExpression="tipo">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList7" runat="server" SelectedValue='<%# Bind("tipo") %>'>
                        <asp:ListItem>Pagina</asp:ListItem>
                        <asp:ListItem>Menu</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("tipo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="url" SortExpression="url">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" MaxLength="100" Text='<%# Bind("url") %>' Width="120px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("url") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
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
    <asp:SqlDataSource ID="BopDBOpciones" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [Opciones] WHERE [Opcion] = @original_Opcion AND [Descripción] = @original_Descripción AND [Modulo] = @original_Modulo AND [Estado] = @original_Estado" InsertCommand="INSERT INTO [Opciones] ([Opcion], [Descripción], [Modulo], [Estado],[Tipo],[Url]) VALUES (@Opcion, @Descripción, @Modulo, @Estado, @Tipo, @Url)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT Opcion, Descripción, Modulo, Estado, RTRIM(tipo) AS tipo, url,tx FROM Opciones WHERE (Modulo = @Modulo)" UpdateCommand="UPDATE [Opciones] SET [Descripción] = @Descripción, [Modulo] = @Modulo, [tx]=@tx,[Tipo] = @Tipo, [Url] = @Url,  [Estado] = @Estado WHERE [Opcion] = @original_Opcion AND [Descripción] = @original_Descripción AND [Modulo] = @original_Modulo AND [Estado] = @original_Estado ">
        <DeleteParameters>
            <asp:Parameter Name="original_Opcion" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Modulo" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Opcion" Type="String" />
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Modulo" Type="String" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="Tipo" />
            <asp:Parameter Name="Url" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListModulos" Name="Modulo" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descripción" Type="String" />
            <asp:Parameter Name="Modulo" Type="String" />
            <asp:Parameter Name="tx" />
            <asp:Parameter Name="Tipo" />
            <asp:Parameter Name="Url" />
            <asp:Parameter Name="Estado" Type="String" />
            <asp:Parameter Name="original_Opcion" Type="String" />
            <asp:Parameter Name="original_Descripción" Type="String" />
            <asp:Parameter Name="original_Modulo" Type="String" />
            <asp:Parameter Name="original_Estado" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>
