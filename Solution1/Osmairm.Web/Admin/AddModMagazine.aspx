<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="AddModMAGAZINE.aspx.cs" Inherits="AddModMagazine" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a href="Default.aspx">AZIENDA</a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li><a href="ManageFormazione.aspx">FORMAZIONE</a></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
    <li><a href="ManageData.aspx?idTipo=0">NEWS</a></li>
    <li class="active"><a href="ManageMAGAZINE.aspx?idTipo=5">MAGAZINE</a></li>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
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
                    <h3 class="page-title">Gestione Magazine <small>Osmairm</small>
                    </h3>
                </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN SAMPLE FORM PORTLET-->
                    <div class="portlet box blue tabbable">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i><span class="hidden-phone">News</span> <span
                                    class="visible-phone">Osmairm</span>
                            </h4>
                        </div>
                        <div class="portlet-body form">
                            <div class="tabbable portlet-tabs">
                                <ul class="nav nav-tabs">
                                    <li><a href="#portlet_tab3" data-toggle="tab">Inline</a></li>
                                    <li><a href="#portlet_tab2" data-toggle="tab">Grid</a></li>
                                    <li class="active"><a href="#portlet_tab1" data-toggle="tab">Basic</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="portlet_tab1">
                                        <!-- BEGIN FORM-->
                                        <div class="form-horizontal">
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Nome Progetto</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtProgetto" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitolo" runat="server" ControlToValidate="txtProgetto"
                                                        CssClass="help-inline" ErrorMessage="Attenzione: campo obbligatorio"
                                                        Display="Dynamic"> </asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Sede</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtCitta" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Responsabile</label>
                                                <div class="controls">
                                                    <CKEditor:CKEditorControl Height="100" ID="CKEditorControlResponsabile" runat="server"></CKEditor:CKEditorControl>
                                                    <%--<span class="help-inline">Some hint here</span>--%>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Descrizione Breve</label>
                                                <div class="controls">
                                                    <CKEditor:CKEditorControl Height="100" ID="txtDescBreve" runat="server"></CKEditor:CKEditorControl>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Descrizione</label>
                                                <div class="controls">
                                                    <CKEditor:CKEditorControl ID="FCKeditorDescrizione" runat="server"></CKEditor:CKEditorControl>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Tags</label>
                                                <div class="controls">
                                                    <input runat="server" name="tags" class="m-wra tags" id="txtTags" value="" />
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Video Embedded</label>
                                                <div class="controls">
                                                    <asp:TextBox runat="server" class="span6 m-wrap" ID="txtVideo" TextMode="MultiLine"
                                                        Rows="3"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Image Upload</label>
                                                <div class="controls">
                                                    <div class="fileupload fileupload-new" data-provides="fileupload">
                                                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">
                                                            <a href="#" runat="server" id="previewFoto" title="preview" rel="group1">
                                                                <asp:Image ID="imgFotoArticolo" runat="server" Visible="true" ImageUrl="" />
                                                            </a>
                                                            <%-- <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image" alt="" />--%>
                                                        </div>
                                                        <div>
                                                            <%--  <span class="btn btn-file"></span>--%>
                                                            <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="default" />
                                                            <%-- <span class="fileupload-new">Select image</span>--%>
                                                            <asp:LinkButton CausesValidation="false" ID="ButtonUploadFoto" CssClass="btn mini blue"
                                                                runat="server" OnClick="ButtonUploadFoto_Click">
                                                                <i class="icon-plus"></i>
                                                                Aggiungi Foto
                                                            </asp:LinkButton>
                                                            <%-- <span class="fileupload-exists">Change</span>--%>
                                                            <%--<input type="file" class="default" />--%>
                                                            <asp:LinkButton ID="lnkCancFoto" runat="server" CausesValidation="false"
                                                                Visible="false" OnClientClick="window.confirm('Cancellare la foto?')" OnClick="CancellaFoto"
                                                                CssClass="btn mini red" ToolTip="Elimina la Foto">
                                                                <i class="icon-trash"></i> Cancella Foto
                                                            </asp:LinkButton>
                                                            <%--<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">Remove</a>--%>
                                                        </div>
                                                    </div>
                                                    <div class="alert">ATTENZIONE: </span> <span>inserire la foto del progetto per visualizzare l'anteprima nel sito. </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Gallery</label>
                                                <div class="controls">
                                                    <asp:LinkButton ID="btnFotoAlbum" CssClass="btn mini blue" runat="server" OnClick="BtnGalleryArt_Click">
                                                    <i class="icon-plus"></i> Aggiungi Gallery
                                                    </asp:LinkButton>
                                                    <asp:LinkButton Visible="false" ID="imgCancFotoG" runat="server"
                                                        CausesValidation="false" OnClientClick="window.confirm('Cancellare il FotoAlbum?')"
                                                        OnClick="CancellaFotoGallery" CssClass="btn mini" ToolTip="Elimina Album">
                                                        <i class="icon-trash"></i> Elimina Album
                                                    </asp:LinkButton>
                                                    <asp:Label CssClass="help-inline" ID="txtFotoGallery" runat="server" Text="Nessuna Gallery"></asp:Label>
                                                    <br />
                                                    <div style="margin-top: 5px;" class="alert alert-info">ATTENZIONE: </span> <span>salvare il progetto prima di aggiungere la gallery. </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Allegato</label>
                                                <div class="controls">
                                                    <%-- <input type="file" class="default" />--%>
                                                    <asp:FileUpload ID="FileUploadAllegati" runat="server" CssClass="default" />
                                                    <asp:LinkButton ID="ButtonUploadAllegati" CssClass="btn mini blue" runat="server"
                                                        OnClick="ButtonUploadAllegati_Click" CausesValidation="false">
                                                        <i class="icon-plus"></i> Aggiungi Allegato
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="lnkCancAllegato" runat="server" CausesValidation="false" OnClientClick="window.confirm('Eliminare allegato?')"
                                                        OnClick="CancellaAllegato" CssClass="btn mini red" ToolTip="Elimina allegato">
                                                        <i class="icon-trash"></i>
                                                        Cancella Allegato
                                                    </asp:LinkButton>
                                                    <asp:Label ID="lblpathFileAll" runat="server" Text="Nessun file allegato" CssClass="help-inline"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Mappa</label>
                                                <div class="controls">
                                                    <asp:TextBox runat="server" class="span6 m-wrap" ID="txtMappa" TextMode="MultiLine"
                                                        Rows="3"></asp:TextBox>
                                                    <%-- <input type="text" placeholder="huge" class="m-wrap huge" />--%>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <div runat="server" visible="false" class="control-group">
                                                <label class="control-label">
                                                    Tel. Responsabile</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtTelRef" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div runat="server" visible="false" class="control-group">
                                                <label class="control-label">
                                                    Mail Responsabile</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtMailRef" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <asp:Button CausesValidation="false" ID="ButtonAnnulla" CssClass="btn"
                                                    runat="server" Text="Annulla" OnClick="ButtonAnnulla_Click" />
                                                <asp:Button ID="ButtonInsert" CssClass="btn blue" runat="server" Text="Salva"
                                                    OnClick="ButtonInsert_Click" />
                                                <asp:Button ID="ButtonAgg" CssClass="btn blue" runat="server" Text="Aggiorna"
                                                    OnClick="ButtonAgg_Click" />
                                            </div>
                                        </div>
                                        <!-- END FORM-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <!-- ***** START DIV MESSAGGI DI ERRORE ***** -->
                            <div id="DivSuccess" runat="server" visible="false" class="alert alert-success">
                                <a href="#" class="close" title="Close notification">close</a>
                                <p>
                                    <strong>articolo ID:
                                <asp:Label ID="News_ID" runat="server" Text=""> inserito con successo</asp:Label></strong>
                                </p>
                            </div>
                            <div id="DivError" runat="server" class="alert alert-error">
                                <button class="close" data-dismiss="alert"></button>
                                <strong>Attenzione: </strong>
                                <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                            </div>
                            <!-- ***** END DIV MESSAGGI DI ERRORE ***** -->
                        </div>
                        <!-- END SAMPLE FORM PORTLET-->
                    </div>
                </div>
                <!-- END PAGE CONTENT-->
            </div>
            <!-- END PAGE CONTAINER-->
        </div>
    </div>
</asp:Content>
