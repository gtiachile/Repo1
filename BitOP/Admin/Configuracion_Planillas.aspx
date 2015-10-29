<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Configuracion_Planillas.aspx.cs" Inherits="BitOp.Admin.Configuracion_Planillas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style11 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        CONFIGURACION PLANILLAS CONDICION DE PROCESO</p>
    <p>
        <asp:Label ID="lblNroPlanillaSel" runat="server" Visible="False"></asp:Label>
    </p>
    <p>
        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <asp:FormView ID="FormView1" runat="server" BorderStyle="Solid" BorderWidth="1px" Caption="Nueva Planilla" DataKeyNames="NroPlanilla" DataSourceID="BopDBPlanillasMedicionEnc" DefaultMode="Insert" OnItemInserted="FormView1_ItemInserted" OnItemInserting="FormView1_ItemInserting" Width="70%">
                    <EditItemTemplate>
                        NroPlanilla:
                        <asp:Label ID="NroPlanillaLabel2" runat="server" Text='<%# Eval("NroPlanilla") %>' />
                        <br />
                        Titulo:
                        <asp:TextBox ID="TituloTextBox" runat="server" Text='<%# Bind("Titulo") %>' />
                        <br />
                        Planta:
                        <asp:TextBox ID="PlantaTextBox" runat="server" Text='<%# Bind("Planta") %>' />
                        <br />
                        Area:
                        <asp:TextBox ID="AreaTextBox" runat="server" Text='<%# Bind("Area") %>' />
                        <br />
                        Proceso:
                        <asp:TextBox ID="ProcesoTextBox" runat="server" Text='<%# Bind("Proceso") %>' />
                        <br />
                        Equipo:
                        <asp:TextBox ID="EquipoTextBox" runat="server" Text='<%# Bind("Equipo") %>' />
                        <br />
                        DiasToleranciaIng:
                        <asp:TextBox ID="DiasToleranciaIngTextBox" runat="server" Text='<%# Bind("DiasToleranciaIng") %>' />
                        <br />
                        Estado:
                        <asp:TextBox ID="EstadoTextBox" runat="server" Text='<%# Bind("Estado") %>' />
                        <br />
                        <asp:LinkButton ID="UpdateButton0" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton0" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <table style="width:100%;">
                            <tr>
                                <td>Titulo:</td>
                                <td colspan="7">
                                    <asp:TextBox ID="TituloTextBox0" runat="server" Text='<%# Bind("Titulo") %>' ValidationGroup="VG_Encabezado" Width="100%" />
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TituloTextBox0" ErrorMessage="*Obligatorio" ForeColor="Red" ValidationGroup="VG_Encabezado"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Planta:</td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="BopDBPlantasFV" DataTextField="Descripción" DataValueField="Planta" SelectedValue='<%# Bind("Planta") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBPlantasFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Planta], [Descripción] FROM [Plantas] Where Estado='Activo'"></asp:SqlDataSource>
                                </td>
                                <td>Area;</td>
                                <td>
                                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="BopDBAreaFV" DataTextField="Descripción" DataValueField="Area" SelectedValue='<%# Bind("Area") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBAreaFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT '' AS Area, 'N/A' as [Descripción]
UNION
SELECT [Area], [Descripción] FROM [Areas] where Estado='Activo'"></asp:SqlDataSource>
                                </td>
                                <td>Proceso:</td>
                                <td>
                                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="BopDBProcesosFV" DataTextField="Descripción" DataValueField="Proceso" SelectedValue='<%# Bind("Proceso") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBProcesosFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT '' AS [Proceso], 'N/A' AS [Descripción]
union
SELECT [Proceso], [Descripción] FROM [Procesos] where Estado='Activo'"></asp:SqlDataSource>
                                </td>
                                <td>Equipo:</td>
                                <td>
                                    <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="BopDBEquipoFV" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="BopDBEquipoFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT '' as [Equipo], 'N/A' as [Descripción] 
union
SELECT [Equipo], [Descripción] FROM [Equipos] where Estado='Activo'"></asp:SqlDataSource>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="auto-style11">Días correción</td>
                                <td class="auto-style11">
                                    <asp:TextBox ID="DiasToleranciaIngTextBox0" runat="server" Text='<%# Bind("DiasToleranciaIng") %>' TextMode="Number" />
                                </td>
                                <td class="auto-style11">Estado:</td>
                                <td class="auto-style11">
                                    <asp:DropDownList ID="DropDownList5" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                        <asp:ListItem>Activo</asp:ListItem>
                                        <asp:ListItem>Inactivo</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td class="auto-style11"></td>
                                <td class="auto-style11"></td>
                                <td class="auto-style11"></td>
                                <td class="auto-style11"></td>
                                <td class="auto-style11"></td>
                            </tr>
                        </table>
                        <asp:LinkButton ID="InsertButton0" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" ValidationGroup="VG_Encabezado" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton0" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        NroPlanilla:
                        <asp:Label ID="NroPlanillaLabel3" runat="server" Text='<%# Eval("NroPlanilla") %>' />
                        <br />
                        Titulo:
                        <asp:Label ID="TituloLabel" runat="server" Text='<%# Bind("Titulo") %>' />
                        <br />
                        Planta:
                        <asp:Label ID="PlantaLabel" runat="server" Text='<%# Bind("Planta") %>' />
                        <br />
                        Area:
                        <asp:Label ID="AreaLabel" runat="server" Text='<%# Bind("Area") %>' />
                        <br />
                        Proceso:
                        <asp:Label ID="ProcesoLabel" runat="server" Text='<%# Bind("Proceso") %>' />
                        <br />
                        Equipo:
                        <asp:Label ID="EquipoLabel" runat="server" Text='<%# Bind("Equipo") %>' />
                        <br />
                        DiasToleranciaIng:
                        <asp:Label ID="DiasToleranciaIngLabel" runat="server" Text='<%# Bind("DiasToleranciaIng") %>' />
                        <br />
                        Estado:
                        <asp:Label ID="EstadoLabel" runat="server" Text='<%# Bind("Estado") %>' />
                        <br />
                        <asp:LinkButton ID="EditButton0" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        &nbsp;<asp:LinkButton ID="DeleteButton0" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                        &nbsp;<asp:LinkButton ID="NewButton0" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="BopDBPlanillasMedicionEnc" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [PlanillasMedicionEnc] WHERE [NroPlanilla] = @NroPlanilla" InsertCommand="p_ValidaInsertaPLANILLASMEDICIONENC" InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [PlanillasMedicionEnc]" UpdateCommand="UPDATE [PlanillasMedicionEnc] SET [Titulo] = @Titulo, [Planta] = @Planta, [Area] = @Area, [Proceso] = @Proceso, [Equipo] = @Equipo, [DiasToleranciaIng] = @DiasToleranciaIng, [Estado] = @Estado WHERE [NroPlanilla] = @NroPlanilla">
                    <DeleteParameters>
                        <asp:Parameter Name="NroPlanilla" Type="Int64" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="NroPlanilla" Type="Int64" />
                        <asp:Parameter Name="Titulo" Type="String" />
                        <asp:Parameter Name="Planta" Type="String" />
                        <asp:Parameter Name="Area" Type="String" />
                        <asp:Parameter Name="Proceso" Type="String" />
                        <asp:Parameter Name="Equipo" Type="String" />
                        <asp:Parameter Name="DiasToleranciaIng" Type="Int32" />
                        <asp:Parameter Name="Estado" Type="String" />
                        <asp:Parameter Name="Done" Type="Boolean" />
                        <asp:Parameter Name="Msg" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Titulo" Type="String" />
                        <asp:Parameter Name="Planta" Type="String" />
                        <asp:Parameter Name="Area" Type="String" />
                        <asp:Parameter Name="Proceso" Type="String" />
                        <asp:Parameter Name="Equipo" Type="String" />
                        <asp:Parameter Name="DiasToleranciaIng" Type="Int32" />
                        <asp:Parameter Name="Estado" Type="String" />
                        <asp:Parameter Name="NroPlanilla" Type="Int64" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" Caption="Planillas Disponibles" DataKeyNames="NroPlanilla" DataSourceID="BopDBPlanillasMedicionEnc" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton4" runat="server" CausesValidation="True" CommandName="Update" ImageUrl="~/Images/saveHS.png" Text="Update" />
                                &nbsp;<asp:ImageButton ID="ImageButton5" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/Images/Cancel(build)_194_32.bmp" Text="Cancel" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton6" runat="server" CausesValidation="False" CommandName="Select" ImageUrl="~/Images/Select.png" Text="Select" />
                                <asp:ImageButton ID="ImageButton7" runat="server" CausesValidation="False" CommandName="Edit" ImageUrl="~/Images/EditTableHS.png" Text="Edit" />
                                &nbsp;&nbsp;<asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/Images/DeleteHS.png" Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="N°" SortExpression="NroPlanilla">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("NroPlanilla") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="NroPlanilla" runat="server" Text='<%# Bind("NroPlanilla") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Titulo" SortExpression="Titulo">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Titulo") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Titulo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Planta" SortExpression="Planta">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList8" runat="server" DataSourceID="BopDBPlantasGVE" DataTextField="Descripción" DataValueField="Planta" SelectedValue='<%# Bind("Planta") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBPlantasGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Planta], 'N/A' as [Descripción] 
union
SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList13" runat="server" DataSourceID="BopDBPlantasGVI" DataTextField="Descripción" DataValueField="Planta" Enabled="False" SelectedValue='<%# Bind("Planta") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBPlantasGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Planta], 'N/A' as [Descripción] 
union
SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Area" SortExpression="Area">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList9" runat="server" DataSourceID="BopDBAreasGVE" DataTextField="Descripción" DataValueField="Area" SelectedValue='<%# Bind("Area") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBAreasGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Area], 'N/A' as [Descripción] 
union
SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList14" runat="server" DataSourceID="BopDBAreasGVI" DataTextField="Descripción" DataValueField="Area" Enabled="False" SelectedValue='<%# Bind("Area") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBAreasGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Area], 'N/A' as [Descripción] 
union
SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Proceso" SortExpression="Proceso">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList10" runat="server" DataSourceID="BopDBProcesosGVE" DataTextField="Descripción" DataValueField="Proceso" SelectedValue='<%# Bind("Proceso") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBProcesosGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Proceso], 'N/A' as [Descripción] 
union
SELECT [Proceso], [Descripción] FROM [Procesos]
"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList15" runat="server" DataSourceID="BopDBProcesosGVI" DataTextField="Descripción" DataValueField="Proceso" Enabled="False" SelectedValue='<%# Bind("Proceso") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBProcesosGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Proceso], 'N/A' as [Descripción] 
union
SELECT [Proceso], [Descripción] FROM [Procesos]
"></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList11" runat="server" DataSourceID="BopDBEquiposGVE" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBEquiposGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Equipo], 'N/A' as [Descripción] 
union
SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList16" runat="server" DataSourceID="BopDBEquiposGVI" DataTextField="Descripción" DataValueField="Equipo" Enabled="False" SelectedValue='<%# Bind("Equipo") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="BopDBEquiposGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Equipo], 'N/A' as [Descripción] 
union
SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dias Ingreso" SortExpression="DiasToleranciaIng">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("DiasToleranciaIng") %>' TextMode="Number"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("DiasToleranciaIng") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList12" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                    <asp:ListItem>Activo</asp:ListItem>
                                    <asp:ListItem>Inactivo</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle Font-Bold="True" />
                </asp:GridView>
                <br />
            </asp:View>
                        <asp:View ID="View2" runat="server">
                            <asp:SqlDataSource ID="BopDBPlanillasMedicionEncDisplay" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT * FROM [PlanillasMedicionEnc] WHERE ([NroPlanilla] = @NroPlanilla)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblNroPlanillaSel" Name="NroPlanilla" PropertyName="Text" Type="Int64" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" Caption="Planilla Activa" DataKeyNames="NroPlanilla" DataSourceID="BopDBPlanillasMedicionEncDisplay" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" Width="75%">
                                <Columns>
                                    <asp:TemplateField HeaderText="N°" SortExpression="NroPlanilla">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("NroPlanilla") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="NroPlanilla0" runat="server" Text='<%# Bind("NroPlanilla") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Titulo" SortExpression="Titulo">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("Titulo") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label9" runat="server" Text='<%# Bind("Titulo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Planta" SortExpression="Planta">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList19" runat="server" DataSourceID="BopDBPlantasGVI0" DataTextField="Descripción" DataValueField="Planta" SelectedValue='<%# Bind("Planta") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBPlantasGVE0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Planta], 'N/A' as [Descripción] 
union
SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList20" runat="server" DataSourceID="BopDBPlantasGVI0" DataTextField="Descripción" DataValueField="Planta" Enabled="False" SelectedValue='<%# Bind("Planta") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBPlantasGVI0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Planta], 'N/A' as [Descripción] 
union
SELECT [Planta], [Descripción] FROM [Plantas]"></asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Area" SortExpression="Area">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList21" runat="server" DataSourceID="BopDBAreasGVI0" DataTextField="Descripción" DataValueField="Area" SelectedValue='<%# Bind("Area") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBAreasGVE0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Area], 'N/A' as [Descripción] 
union
SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList22" runat="server" DataSourceID="BopDBAreasGVI0" DataTextField="Descripción" DataValueField="Area" Enabled="False" SelectedValue='<%# Bind("Area") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBAreasGVI0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Area], 'N/A' as [Descripción] 
union
SELECT [Area], [Descripción] FROM [Areas]"></asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Proceso" SortExpression="Proceso">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList23" runat="server" DataSourceID="BopDBProcesosGVI0" DataTextField="Descripción" DataValueField="Proceso" SelectedValue='<%# Bind("Proceso") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBProcesosGVE0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Proceso], 'N/A' as [Descripción] 
union
SELECT [Proceso], [Descripción] FROM [Procesos]
"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList24" runat="server" DataSourceID="BopDBProcesosGVI0" DataTextField="Descripción" DataValueField="Proceso" Enabled="False" SelectedValue='<%# Bind("Proceso") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBProcesosGVI0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Proceso], 'N/A' as [Descripción] 
union
SELECT [Proceso], [Descripción] FROM [Procesos]
"></asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Equipo" SortExpression="Equipo">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList25" runat="server" DataSourceID="BopDBEquiposGVI0" DataTextField="Descripción" DataValueField="Equipo" SelectedValue='<%# Bind("Equipo") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBEquiposGVE0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Equipo], 'N/A' as [Descripción] 
union
SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList26" runat="server" DataSourceID="BopDBEquiposGVI0" DataTextField="Descripción" DataValueField="Equipo" Enabled="False" SelectedValue='<%# Bind("Equipo") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBEquiposGVI0" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Equipo], 'N/A' as [Descripción] 
union
SELECT [Equipo], [Descripción] FROM [Equipos]"></asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Dias Ingreso" SortExpression="DiasToleranciaIng">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("DiasToleranciaIng") %>' TextMode="Number"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("DiasToleranciaIng") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Estado" SortExpression="Estado">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList27" runat="server" SelectedValue='<%# Bind("Estado") %>'>
                                                <asp:ListItem>Activo</asp:ListItem>
                                                <asp:ListItem>Inactivo</asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("Estado") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle Font-Bold="True" />
                            </asp:GridView>
                            <asp:FormView ID="FormView2" runat="server" BorderStyle="Solid" BorderWidth="1px" Caption="Nueva Linea" DataKeyNames="NroPlanilla,Linea" DataSourceID="BopDBPlanillasMedicionDet" DefaultMode="Insert" OnItemInserting="FormView2_ItemInserting">
                                <EditItemTemplate>
                                    NroPlanilla:
                                    <asp:Label ID="NroPlanillaLabel1" runat="server" Text='<%# Eval("NroPlanilla") %>' />
                                    <br />
                                    Linea:
                                    <asp:Label ID="LineaLabel1" runat="server" Text='<%# Eval("Linea") %>' />
                                    <br />
                                    Variable:
                                    <asp:TextBox ID="VariableTextBox" runat="server" Text='<%# Bind("Variable") %>' />
                                    <br />
                                    Obligatorio:
                                    <asp:CheckBox ID="ObligatorioCheckBox" runat="server" Checked='<%# Bind("Obligatorio") %>' />
                                    <br />
                                    Lote:
                                    <asp:CheckBox ID="LoteCheckBox" runat="server" Checked='<%# Bind("Lote") %>' />
                                    <br />
                                    Producto:
                                    <asp:CheckBox ID="ProductoCheckBox" runat="server" Checked='<%# Bind("Producto") %>' />
                                    <br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table style="width:100%;">
                                        <tr>
                                            <td>Variable:</td>
                                            <td>
                                                <asp:DropDownList ID="DropDownList18" runat="server" DataSourceID="BopDBVariablesFV" DataTextField="Descripcion" DataValueField="Variable" SelectedValue='<%# Bind("Variable") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="BopDBVariablesFV" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Variable], [Descripcion] FROM [Variables] where estado='Activo'"></asp:SqlDataSource>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Obligatorio:</td>
                                            <td>
                                                <asp:CheckBox ID="ObligatorioCheckBox" runat="server" Checked='<%# Bind("Obligatorio") %>' />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Lote:</td>
                                            <td>
                                                <asp:CheckBox ID="LoteCheckBox" runat="server" Checked='<%# Bind("Lote") %>' />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Producto:</td>
                                            <td>
                                                <asp:CheckBox ID="ProductoCheckBox" runat="server" Checked='<%# Bind("Producto") %>' />
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    NroPlanilla:
                                    <asp:Label ID="NroPlanillaLabel" runat="server" Text='<%# Eval("NroPlanilla") %>' />
                                    <br />
                                    Linea:
                                    <asp:Label ID="LineaLabel" runat="server" Text='<%# Eval("Linea") %>' />
                                    <br />
                                    Variable:
                                    <asp:Label ID="VariableLabel" runat="server" Text='<%# Bind("Variable") %>' />
                                    <br />
                                    Obligatorio:
                                    <asp:CheckBox ID="ObligatorioCheckBox" runat="server" Checked='<%# Bind("Obligatorio") %>' Enabled="false" />
                                    <br />
                                    Lote:
                                    <asp:CheckBox ID="LoteCheckBox" runat="server" Checked='<%# Bind("Lote") %>' Enabled="false" />
                                    <br />
                                    Producto:
                                    <asp:CheckBox ID="ProductoCheckBox" runat="server" Checked='<%# Bind("Producto") %>' Enabled="false" />
                                    <br />
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" Caption="Lineas Planilla" DataKeyNames="NroPlanilla,Linea" DataSourceID="BopDBPlanillasMedicionDet" Width="75%">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update" ImageUrl="~/Images/saveHS.png" Text="Update" />
                                            &nbsp;<asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/Images/Cancel(build)_194_32.bmp" Text="Cancel" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton9" runat="server" CausesValidation="False" CommandName="Edit" ImageUrl="~/Images/EditTableHS.png" Text="Edit" />
                                            &nbsp;<asp:ImageButton ID="ImageButton10" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/Images/DeleteHS.png" Text="Delete" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="NroPlanilla" HeaderText="NroPlanilla" ReadOnly="True" SortExpression="NroPlanilla" Visible="False" />
                                    <asp:BoundField DataField="Linea" HeaderText="Linea" ReadOnly="True" SortExpression="Linea" />
                                    <asp:TemplateField HeaderText="Variable" SortExpression="Variable">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="BopDBVariablesGVE" DataTextField="Descripcion" DataValueField="Variable" SelectedValue='<%# Bind("Variable") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBVariablesGVE" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT [Variable], [Descripcion] FROM [Variables]"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:DropDownList ID="DropDownList17" runat="server" DataSourceID="BopDBVariablesGVI" DataTextField="Descripcion" DataValueField="Variable" SelectedValue='<%# Bind("Variable") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="BopDBVariablesGVI" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" SelectCommand="SELECT null as [Variable], '' as [Descripcion] 
union
SELECT [Variable], [Descripcion] FROM [Variables]"></asp:SqlDataSource>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Obligatorio" SortExpression="Obligatorio">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Obligatorio") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox5" runat="server" Checked='<%# Bind("Obligatorio") %>' Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Lote" SortExpression="Lote">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("Lote") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox7" runat="server" Checked='<%# Bind("Lote") %>' Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Producto" SortExpression="Producto">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%# Bind("Producto") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox9" runat="server" Checked='<%# Bind("Producto") %>' Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="BopDBPlanillasMedicionDet" runat="server" ConnectionString="<%$ ConnectionStrings:BopDBConnectionString %>" DeleteCommand="DELETE FROM [PlanillasMedicionDet] WHERE [NroPlanilla] = @NroPlanilla AND [Linea] = @Linea" InsertCommand="INSERT INTO [PlanillasMedicionDet] ([NroPlanilla], [Linea], [Variable], [Obligatorio], [Lote], [Producto]) VALUES (@NroPlanilla, @Linea, @Variable, @Obligatorio, @Lote, @Producto)" SelectCommand="SELECT * FROM [PlanillasMedicionDet] WHERE ([NroPlanilla] = @NroPlanilla)" UpdateCommand="UPDATE [PlanillasMedicionDet] SET [Variable] = @Variable, [Obligatorio] = @Obligatorio, [Lote] = @Lote, [Producto] = @Producto WHERE [NroPlanilla] = @NroPlanilla AND [Linea] = @Linea">
                                <DeleteParameters>
                                    <asp:Parameter Name="NroPlanilla" Type="Int64" />
                                    <asp:Parameter Name="Linea" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="NroPlanilla" Type="Int64" />
                                    <asp:Parameter Name="Linea" Type="Int32" />
                                    <asp:Parameter Name="Variable" Type="String" />
                                    <asp:Parameter Name="Obligatorio" Type="Boolean" />
                                    <asp:Parameter Name="Lote" Type="Boolean" />
                                    <asp:Parameter Name="Producto" Type="Boolean" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblNroPlanillaSel" Name="NroPlanilla" PropertyName="Text" Type="Int64" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Variable" Type="String" />
                                    <asp:Parameter Name="Obligatorio" Type="Boolean" />
                                    <asp:Parameter Name="Lote" Type="Boolean" />
                                    <asp:Parameter Name="Producto" Type="Boolean" />
                                    <asp:Parameter Name="NroPlanilla" Type="Int64" />
                                    <asp:Parameter Name="Linea" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Volver" />
            </asp:View>
        </asp:MultiView>
    </p>
    <p>
        &nbsp;</p>
    </asp:Content>
