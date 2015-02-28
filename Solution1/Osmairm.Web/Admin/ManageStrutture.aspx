<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="ManageStrutture.aspx.cs" Inherits="ManageStrutture" %>

<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a href="Default.aspx">AZIENDA</a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li class="active"><a href="ManageStrutture.aspx">STRUTTURE</a></li>
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
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetListaNews_OrderASC" TypeName="DataSetVepAdminTableAdapters.NewsTableAdapter"
        DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
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
            <asp:Parameter Name="Tags" Type="String" />
            <asp:Parameter Name="Ws_Flag" Type="Boolean" />
            <asp:Parameter Name="Original_News_ID" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="21" Name="Tipo" QueryStringField="idTipo"
                Type="String" />
        </SelectParameters>
        <InsertParameters>
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
            <asp:Parameter Name="Tags" Type="String" />
            <asp:Parameter Name="Ws_Flag" Type="Boolean" />
        </InsertParameters>
    </asp:ObjectDataSource>

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

                    <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                    <h3 class="page-title">Gestione Strutture <small>Osmairm</small>
                    </h3>

                    <div class="form-actions">


                        <asp:LinkButton ID="Nuovo" runat="server" Text="Aggiungi" CssClass="btn blue"
                            OnClick="Nuovo_Click"> <i class="icon-plus"></i> Nuova Struttura
                        </asp:LinkButton>

                    </div>


                    <!-- END PAGE TITLE & BREADCRUMB-->
                </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN SAMPLE TABLE PORTLET-->
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>Archivio dati</h4>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="portlet-body">
                                    <asp:ListView ID="ListViewNews" runat="server" DataKeyNames="News_ID" DataSourceID="ObjectDataSource1"
                                        OnItemCommand="_OnItemCommand" OnItemCreated="_OnCreated">
                                        <EmptyDataTemplate>
                                            <div class="notification note-info">
                                                <p>
                                                    <strong>ATTENZIONE:</strong> nessun dato disponibile.
                                                </p>
                                            </div>
                                        </EmptyDataTemplate>
                                        <LayoutTemplate>
                                            <table id="jsDtCorsi" class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Id.
                                                        </th>
                                                        <th>Sede
                                                        </th>

                                                        <th class="hidden-phone">Città
                                                        </th>
                                                        <th>Indirizzo
                                                        </th>
                                                        <th>Referente
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
                                                <td>
                                                    <%#Eval("News_ID") %>
                                                </td>
                                                <td>
                                                    <%#Eval("Titolo") %>
                                                   
                                                </td>
                                                <td>
                                                    <%# Eval("TestoEng") %>
                                                </td>
                                                <td>
                                                    <%# Eval("Descrizione") %>
                                                </td>
                                                <td>
                                                    <%# Eval("TitoloENG") %>
                                                    <br />
                                                    <%# Eval("AutoreENG") %>
                                                    <br />
                                                    <%# Eval("DescrizioneENG") %>
                                                </td>
                                                <td>
                                                    <p>

                                                        <asp:LinkButton CommandName="modifica" ID="ImageButton1" runat="server" CssClass="btn mini"><i class="icon-edit"></i> Modifica</asp:LinkButton>
                                                        <asp:LinkButton OnClientClick="return DeleteConfirmation();" CommandName="cancella"
                                                            ID="ImageButton2" runat="server" CssClass="btn red mini"><i class="icon-trash"></i> Elimina</asp:LinkButton>
                                                        <asp:LinkButton CommandName="fotoGallery" ID="LinkButton1" runat="server" CssClass="btn blue mini"
                                                            Text="FotoAlbum">
                                                            <i class="icon-camera"></i> Gallery
                                                        </asp:LinkButton>
                                                        <%--  <a class="btn red mini" href="index.html#">Approved</a> <a class="btn blue mini"
                                                    href="index.html#">Approved</a> <a class="btn red mini" href="index.html#">Approved</a>--%>
                                                    </p>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>



                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <!-- END SAMPLE TABLE PORTLET-->


                </div>
            </div>
            <div class="row-fluid">


                <div class="span-12">
                    <div class="pagination pagination-small">
                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewNews" PageSize="9">
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





</asp:Content>
