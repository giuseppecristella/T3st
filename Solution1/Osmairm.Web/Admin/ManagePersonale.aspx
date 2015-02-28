<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="ManagePersonale.aspx.cs" Inherits="ManagePersonale" %>

<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a href="Default.aspx">AZIENDA</a></li>
    <li class="active"><a href="ManagePersonale.aspx">PERSONALE</a></li>
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
    <asp:XmlDataSource ID="XmlDataSourceNewsTipo" runat="server" DataFile="~/Xml/ListaTipPersonale.xml"
        TransformFile="~/Xml/ListaTipPersonale.xslt"></asp:XmlDataSource>
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
                    <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                    <h3 class="page-title">Gestione Personale <small>Osmairm</small>
                    </h3>
                    <!-- END PAGE TITLE & BREADCRUMB-->
                </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
                <div class="span12">
                    <label class="control-label">Filtra per ruolo: </label>
                    <asp:DropDownList Style="width: 200px;" ID="ddlTipo" runat="server" DataSourceID="XmlDataSourceNewsTipo"
                        DataTextField="text" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
                    </asp:DropDownList>
                    <!-- BEGIN SAMPLE TABLE PORTLET-->
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>Archivio dati</h4>
                        </div>
                        <div class="portlet-body">
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <asp:UpdatePanel runat="server" ID="updPnlListaNews" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:ListView ID="ListViewNews" runat="server" DataKeyNames="News_ID" DataSourceID="ObjectDataSource1"
                                        OnItemCommand="_OnItemCommand" OnItemCreated="_OnCreated">
                                        <EmptyDataTemplate>
                                            <div class="notification note-info">
                                                <p>
                                                    <strong>Warning:</strong> no items avalaible.
                                                </p>
                                            </div>
                                        </EmptyDataTemplate>
                                        <LayoutTemplate>
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>#
                                                        </th>
                                                        <th>ID
                                                        </th>
                                                        <th>Nome
                                                        </th>
                                                        <th>Mail
                                                        </th>
                                                        <th>Ruolo
                                                        </th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr runat="server" id="itemPlaceholder" />
                                                </tbody>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblriga" Text=""></asp:Label>
                                                </td>
                                                <td>
                                                    <%#Eval("News_ID") %>
                                                </td>
                                                <td>
                                                    <%# Eval("Titolo") %>
                                                </td>
                                                <td>
                                                    <%# Web.BaseFramework.Utility.CutString(Eval("Descrizione").ToString(),50) %>
                                                </td>
                                                <td>
                                                    <%--Fonte--->website--%>
                                                    <%# Web.BaseFramework.Utility.CutString(Eval("Fonte").ToString(),50) %>
                                                </td>
                                                <td>
                                                    <asp:LinkButton CommandName="modifica" ID="lnkButtonModifica" runat="server" CssClass="btn mini"
                                                        ToolTip="Modifica"><i class="icon-edit"></i> Modifica</asp:LinkButton>
                                                    <asp:LinkButton OnClientClick="return DeleteConfirmation();" CommandName="cancella"
                                                        ID="lnkButtonDelete" runat="server" CssClass="btn mini red" ToolTip="Delete"><i class="icon-trash"></i> Elimina</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <!-- END SAMPLE TABLE PORTLET-->
                    <div class="form-actions">
                        <asp:LinkButton ID="Nuovo" runat="server" CssClass="btn blue"
                            OnClick="Nuovo_Click">
                    <i class="icon-plus"></i> Aggiungi
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span-12">
                    <div class="pagination pagination-small">
                        <asp:DataPager runat="server" ID="pager" PagedControlID="ListViewNews" PageSize="10">
                            <Fields>
                                <vscinzPager:FollowingPagerField ButtonCount="10" liActiveClass="active" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
            <!-- END PAGE CONTENT-->
        </div>
        <!-- END PAGE CONTAINER-->
    </div>
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
</asp:Content>
