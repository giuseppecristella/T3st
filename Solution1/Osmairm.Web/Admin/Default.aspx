<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="Default.aspx.cs" Inherits="Default" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li class="active"><a href="Default.aspx">Azienda<span class="selected"></span></a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li><a href="ManageFormazione.aspx">FORMAZIONE</a></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
    <li><a href="ManageData.aspx?idTipo=0">NEWS</a></li>
    <li><a href="ManageMAGAZINE.aspx?idTipo=5">MAGAZINE</a></li>
</asp:Content>
<asp:Content ID="ContentBody" runat="server" ContentPlaceHolderID="cphAdminBody">
    <script type="text/javascript" language="javascript">
        function DeleteConfirmation() {
            if (!window.confirm('Confirm delete?')) return false;
        }
    </script>
    <div class="page-content">
        <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
        <div id="portlet-config" class="modal hide">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">
                </button>
                <h3>portlet Settings</h3>
            </div>
            <div class="modal-body">
                <p>
                    Here will be a configuration form
                </p>
            </div>
        </div>
        <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
        <!-- BEGIN PAGE CONTAINER-->
        <div class="container-fluid">
            <!-- BEGIN PAGE HEADER-->
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN STYLE CUSTOMIZER-->
                    
                    <!-- END STYLE CUSTOMIZER-->
                    <h3 class="page-title">Pannello di Amministrazione <small>Osmairm</small>
                    </h3>
                </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN SAMPLE FORM PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>Azienda</h4>
                           <%-- <div class="tools">
                                <a href="javascript:;" class="collapse"></a><a href="#portlet-config" data-toggle="modal"
                                    class="config"></a><a href="javascript:;" class="reload"></a><a href="javascript:;"
                                        class="remove"></a>
                            </div>--%>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <div action="#" class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label">
                                        Html</label>
                                    <div class="controls">
                                        <CKEditor:CKEditorControl CssClass="span12 ckeditor m-wrap" ID="FCKeditor1" runat="server"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <asp:LinkButton CausesValidation="false" CssClass="btn blue" OnClientClick="return confirm('Vuoi salvare la pagina?')"
                                        OnClick="ButtonSave_template" ID="lnkbrnSaveTemplate" runat="server">
                                        <i class="icon-save"></i>
                                         Salva Html</asp:LinkButton>
                                </div>
                            </div>
                            <!-- END FORM-->
                        </div>
                    </div>
                    <!-- END SAMPLE FORM PORTLET-->
                </div>
            </div>
            <!-- END PAGE CONTENT-->
        </div>
        <!-- END PAGE CONTAINER-->
    </div>
    <asp:Panel Visible="false" runat="server" ID="pnlAzienda">
        <asp:DropDownList Style="width: 200px;" ID="ddlTipo" runat="server" DataSourceID="XmlDataSourceNewsTipo"
            DataTextField="text" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:XmlDataSource ID="XmlDataSourceNewsTipo" runat="server" DataFile="~/Xml/ListaTipAzienda.xml"
            TransformFile="~/Xml/ListaTipAzienda.xslt"></asp:XmlDataSource>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server" ID="updPnlListaNews" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:ListView ID="ListViewNews" runat="server" DataKeyNames="News_ID" DataSourceID="ObjectDataSource1"
                    OnItemCommand="_OnItemCommand" OnItemCreated="_OnCreated">
                    <EmptyDataTemplate>
                        <div class="notification note-info">
                            <p>
                                <strong>Attenzione:</strong> nessun dato in archivio.
                            </p>
                        </div>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <table class="style1">
                            <thead>
                                <tr>
                                    <th>#
                                    </th>
                                    <th>ID
                                    </th>
                                    <th>Logo
                                    </th>
                                    <th>Descrizione
                                    </th>
                                    <th>Indirizzo
                                    </th>
                                    <th>Telefono
                                    </th>
                                    <th>Modifica
                                    </th>
                                    <th>Elimina
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceholder" />
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="width: 35px;">
                                <asp:Label runat="server" ID="lblriga" Text=""></asp:Label>
                            </td>
                            <td style="width: 35px;">
                                <%#Eval("News_ID") %>
                            </td>
                            <td style="width: 80px;">
                                <a href="<%# Utility.GetPhotoUrl(Eval("UrlFotoHome").ToString()) %>" title="Preview">
                                    <img src="<%# Utility.GetPhotoUrl(Eval("UrlFotoHome").ToString()) %>" alt="" class="thumb  size64 clickable" />
                                </a>
                            </td>
                            <td>
                                <%# Eval("Titolo") %>
                            </td>
                            <td>
                                <%# Web.BaseFramework.Utility.CutString(Eval("Descrizione").ToString(),50).ToString() %>
                            </td>
                            <td>
                                <%--Fonte--->telefono--%>
                                <%# Web.BaseFramework.Utility.CutString(Eval("Fonte").ToString(),50).ToString() %>
                            </td>
                            <td style="width: 25px;">
                                <asp:ImageButton ImageUrl="images/ico_edit_16.png" CommandName="modifica" ID="lnkButtonModifica"
                                    runat="server" CssClass="icon16 fl-space2" Text="Modifica" ToolTip="Modifica"></asp:ImageButton>
                            </td>
                            <td style="width: 35px;">
                                <asp:ImageButton OnClientClick="return DeleteConfirmation();" CommandName="cancella"
                                    ImageUrl="images/ico_delete_16.png" ID="lnkButtonDelete" runat="server" CssClass="icon16 fl-space2"
                                    Text="Delete" ToolTip="Delete"></asp:ImageButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
                <div class="tab-footer clear">
                    <asp:DataPager runat="server" ID="pager" PagedControlID="ListViewNews" PageSize="10">
                        <Fields>
                            <peppPager:FollowingPagerField ButtonCount="10" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetListaNews" TypeName="DataSetVepAdminTableAdapters.NewsTableAdapter"
            DeleteMethod="Delete" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_News_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Fonte" Type="String" />
                <asp:Parameter Name="Titolo" Type="String" />
                <asp:Parameter Name="Testo" Type="String" />
                <asp:Parameter Name="Data" Type="DateTime" />
                <asp:Parameter Name="Visibile" Type="Boolean" />
                <asp:Parameter Name="Descrizione" Type="String" />
                <asp:Parameter Name="Tipo" Type="String" />
                <asp:Parameter Name="UrlFotoHome" Type="String" />
                <asp:Parameter Name="Allegati" Type="String" />
                <asp:Parameter Name="Video" Type="String" />
                <asp:Parameter Name="TitoloENG" Type="String" />
                <asp:Parameter Name="AutoreENG" Type="String" />
                <asp:Parameter Name="DescrizioneENG" Type="String" />
                <asp:Parameter Name="TestoENG" Type="String" />
                <asp:Parameter Name="TitoloTED" Type="String" />
                <asp:Parameter Name="DescrizioneTED" Type="String" />
                <asp:Parameter Name="TestoTED" Type="String" />
                <asp:Parameter Name="IdScuola" Type="Int32" />
                <asp:Parameter Name="Original_News_ID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlTipo" Name="Tipo" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </asp:Panel>
</asp:Content>
