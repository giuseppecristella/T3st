<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="AddModData.aspx.cs" Inherits="AddModData" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a href="Default.aspx">AZIENDA</a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li runat="server" id="li_prog"><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li runat="server" id="li_form"><a href="ManageData.aspx?idTipo=9">FORMAZIONE</a></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li> 
    <li runat="server" id="li_news"><a href="ManageData.aspx?idTipo=0">NEWS</a></li>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
    <script>
        $(function () {
            var hdfTagAutoComplete = document.getElementById("<%=hdfTagAutoComplete.ClientID %>");
            var strFromHdf = hdfTagAutoComplete.value;
            var arr = strFromHdf.split(",");
            //-------------------------------
            // Single field
            //-------------------------------
            $('.tags__').tagit({
                availableTags: arr,
                allowSpaces: true
            });
            //-------------------------------
            // Tag events
            //-------------------------------
            var eventTags = $('#eventTags');
            eventTags.tagit({
                availableTags: sampleTags,
                onTagRemoved: function (evt, tag) {
                    console.log(evt);
                    alert('This tag is being removed: ' + eventTags.tagit('tagLabel', tag));
                },
                onTagClicked: function (evt, tag) {
                    console.log(tag);
                    alert('This tag was clicked: ' + eventTags.tagit('tagLabel', tag));
                }
            }).tagit('option', 'onTagAdded', function (evt, tag) {
                // Add this callbackafter we initialize the widget,
                // so that onTagAdded doesn't get called on page load.
                alert('This tag is being added: ' + eventTags.tagit('tagLabel', tag));
            });
            //-------------------------------
            // Tag-it methods
            //-------------------------------
            $('#methodTags').tagit({
                availableTags: sampleTags
            });
            //-------------------------------
            // Allow spaces without quotes.
            //-------------------------------
            $('#allowSpacesTags').tagit({
                availableTags: sampleTags,
                allowSpaces: true
            });
            //-------------------------------
            // Remove confirmation
            //-------------------------------
            $('#removeConfirmationTags').tagit({
                availableTags: sampleTags,
                removeConfirmation: true
            });
        });
    </script>
    <asp:HiddenField ID="hdfTagAutoComplete" runat="server" Value="" />
    <div class="page-content">
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
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <h3 class="page-title">Gestione News <small>Osmairm</small>
                    </h3>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
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
                                    <li><a  href="#" data-toggle="tab"> </a></li>
                                    <li><a  href="#" data-toggle="tab"> </a></li>
                                    <li ><a href="#" data-toggle="tab"> </a></li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="portlet_tab1">
                                        <div class="form-horizontal">
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Citazione</label>
                                                <div class="controls">
                                                    <asp:CheckBox Visible="false" ID="chkboxPrjHome" runat="server" Text=" Select to show news in homepage." />
                                                    <asp:CheckBox ID="chkboxCitazione" runat="server" />
                                                    visualizza solo citazione?
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Data</label>
                                                <div class="controls">
                                                    <div class="input-append date date-picker" data-date="12-02-2012" data-date-format="dd-mm-yyyy"
                                                        data-date-viewmode="years">
                                                        <asp:TextBox ID="txtData" data-date-format="dd-mm-yyyy" runat="server" size="16" class="m-wrap m-ctrl-medium date-picker"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorData" runat="server" ControlToValidate="txtData"
                                                            ErrorMessage="Attenzione: campo obbligatorio"
                                                            Display="Dynamic"> </asp:RequiredFieldValidator>
                                                            class="add-on"><i class="icon-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Titolo</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtTitoloNews" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitolo" runat="server" ControlToValidate="txtTitoloNews"
                                                        ErrorMessage="Attenzione: campo obbligatorio"
                                                        Display="Dynamic"> </asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Descrizione Breve / Citazione</label>
                                                <div class="controls">
                                                    <CKEditor:CKEditorControl Height="100" ID="txtDescrizione" runat="server"></CKEditor:CKEditorControl>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Testo</label>
                                                <div class="controls">
                                                    <CKEditor:CKEditorControl ID="FCKeditor1" runat="server"></CKEditor:CKEditorControl>
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
                                                        </div>
                                                        <div>
                                                            <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="default" />
                                                            <asp:LinkButton CausesValidation="false" ID="ButtonUploadFoto" CssClass="btn mini blue"
                                                                runat="server" OnClick="btnUploadFoto_Click">
                                                                <i class="icon-plus"></i>
                                                                Aggiungi Foto
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lnkCancFoto" runat="server" CausesValidation="false"
                                                                Visible="false" OnClientClick="window.confirm('Cancellare la foto?')" OnClick="CancellaFoto"
                                                                CssClass="btn mini red" ToolTip="Elimina la Foto">
                                                                <i class="icon-trash"></i> Cancella Foto
                                                            </asp:LinkButton>
                                                            <%--<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">Remove</a>--%>
                                                        </div>
                                                    </div>
                                                    <div class="alert">
                                                       <span> Attenzione: </span> è possibile inserire
                                                        foto di dimensione massima di 1Mb
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Gallery</label>
                                                <div class="controls">
                                                    <asp:LinkButton ID="btnFotoAlbum" CssClass="btn mini blue" runat="server" OnClick="btnGalleryArt_Click">
                                                    <i class="icon-plus"></i> Aggiungi Gallery
                                                    </asp:LinkButton>
                                                    <asp:LinkButton Visible="false" ID="imgCancFotoG" runat="server"
                                                        CausesValidation="false" OnClientClick="window.confirm('Cancellare il FotoAlbum?')"
                                                        OnClick="CancellaFotoGallery" CssClass="btn mini" ToolTip="Elimina Album">
                                                        <i class="icon-trash"></i> Elimina Album
                                                    </asp:LinkButton>
                                                    <asp:Label CssClass="help-inline" ID="txtFotoGallery" runat="server" Text="Nessuna Gallery"></asp:Label>
                                                    <br />
                                                    <div style="margin-top: 5px;" class="alert alert-info">ATTENZIONE: salvare il progetto prima di aggiungere la gallery. </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Allegato</label>
                                                <div class="controls">
                                                    <asp:FileUpload ID="FileUploadAllegati" runat="server" CssClass="default" />
                                                    <asp:LinkButton ID="ButtonUploadAllegati" CssClass="btn mini blue" runat="server"
                                                        OnClick="btnUploadAllegati_Click" CausesValidation="false">
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
                                            <div class="form-actions">
                                                <asp:Button CausesValidation="false" ID="ButtonAnnulla" CssClass="btn"
                                                    runat="server" Text="Annulla" OnClick="btnAnnulla_Click" />
                                                <asp:Button ID="ButtonInsert" CssClass="btn blue" runat="server" Text="Salva"
                                                    OnClick="btnInsert_Click" />
                                                <asp:Button ID="ButtonAgg" CssClass="btn blue" runat="server" Text="Aggiorna"
                                                    OnClick="btnUpdate_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="DivSuccess" runat="server" visible="false" class="alert alert-success">
                                <a href="#" class="close" title="Close notification">close</a>
                                <p>
                                    <strong>articolo ID:
                                <asp:Label ID="News_ID" runat="server" Text=""> inserito con successo</asp:Label></strong>
                                </p>
                            </div>
                            <div id="DivError" runat="server" visible="false" class="alert alert-error">
                                <a href="#" class="close" title="Close notification">close</a>
                                <p>
                                    <strong>
                                        <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                                    </strong>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
