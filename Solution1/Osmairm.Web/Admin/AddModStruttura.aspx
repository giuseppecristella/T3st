<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="AddModStruttura.aspx.cs" Inherits="AddModStruttura" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
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
                    <h3 class="page-title">Gestione News <small>Osmairm</small>
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
                                    <li><a href="#" data-toggle="tab"></a></li>
                                    <li><a href="#" data-toggle="tab"></a></li>
                                    <li><a href="#" data-toggle="tab"></a></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="portlet_tab1">
                                        <!-- BEGIN FORM-->
                                        <div class="form-horizontal">
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Sede</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtSede" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitolo" runat="server" ControlToValidate="txtSede"
                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> required field.</p></div>"
                                                        Display="Dynamic"> </asp:RequiredFieldValidator>
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Città</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtCitta" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Indirizzo</label>
                                                <div class="controls">
                                                    <CKEditor:CKEditorControl Height="100" ID="CKEditorControlIndirizzo" runat="server"></CKEditor:CKEditorControl>
                                                    <span class="help-inline"></span>
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
                                                    <%--<span class="help-inline">Attenzione se si incolla codice da YouTube aggiungere l'attributo</span>--%>
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
                                                        </div>
                                                        <div>
                                                            <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="default" />
                                                            <asp:LinkButton CausesValidation="false" ID="ButtonUploadFoto" CssClass="btn mini blue"
                                                                runat="server" OnClick="ButtonUploadFoto_Click">
                                                                <i class="icon-plus"></i>
                                                                Aggiungi Foto
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lnkCancFoto" runat="server" CausesValidation="false"
                                                                Visible="false" OnClientClick="window.confirm('Cancellare la foto?')" OnClick="CancellaFoto"
                                                                CssClass="btn mini red" ToolTip="Elimina la Foto">
                                                                <i class="icon-trash"></i> Cancella Foto
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                    <div class="alert">
                                                        <span>Attenzione: </span>è possibile inserire
                                                        foto di dimensione massima di 1Mb
                                                    </div>
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
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Allegato</label>
                                                <div class="controls">
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
                                                    <span class="help-inline"></span>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Nome Referente</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtReferente" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Tel. Referente</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtTelRef" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Mail Referente</label>
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
                                            <!-- ***** START DIV MESSAGGI DI ERRORE ***** -->
                                            <div id="DivSuccess" runat="server" visible="false" class="notification">
                                                <a href="#" class="close" title="Close notification">close</a>
                                                <p>
                                                    <strong>articolo ID:
                                <asp:Label ID="News_ID" runat="server" Text=""> inserito con successo</asp:Label></strong>
                                                </p>
                                            </div>
                                            <div id="DivError" runat="server" visible="false" class="notification note-attention">
                                                <a href="#" class="close" title="Close notification">close</a>
                                                <p>
                                                    <strong>
                                                        <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                                                    </strong>
                                                </p>
                                            </div>
                                            <!-- ***** END DIV MESSAGGI DI ERRORE ***** -->
                                        </div>
                                        <!-- END FORM-->
                                    </div>
                                </div>
                            </div>
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
