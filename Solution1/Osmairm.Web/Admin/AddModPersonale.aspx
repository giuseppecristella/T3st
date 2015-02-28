<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="AddModPersonale.aspx.cs" Inherits="AddModPersonale" %>
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
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
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
    <asp:XmlDataSource ID="XmlDataSourceNewsTipo" runat="server" DataFile="~/xml/ListaTipPersonale.xml"
        TransformFile="~/xml/ListaTipPersonale.xslt"></asp:XmlDataSource>
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
                <h3 class="page-title">Gestione Personale <small>Osmairm</small>
                    </h3>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="portlet box blue tabbable">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i><span class="hidden-phone">Scheda</span> <span
                                    class="visible-phone">Layouts</span>
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
                                        <div class="form-horizontal">
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Tipologia</label>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlTipo" runat="server" DataSourceID="XmlDataSourceNewsTipo"
                                                        DataTextField="text" DataValueField="value">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Data</label>
                                                <div class="controls">
                                                    <div class="input-append date date-picker" data-date="12-02-2012" data-date-format="dd-mm-yyyy"
                                                        data-date-viewmode="years">
                                                        <asp:TextBox ID="txtData" runat="server" size="16" data-date-format="dd-mm-yyyy" class="m-wrap m-ctrl-medium date-picker"></asp:TextBox>
                                                        <span></span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtData"
                                                            ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> required field.</p></div>"
                                                            Display="Dynamic"> </asp:RequiredFieldValidator>
                                                        class="add-on"><i class="icon-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Nome</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtTitoloNews" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTitoloNews"
                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> required field.</p></div>"
                                                        Display="Dynamic"> </asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Ruolo</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtwebsite" class="span6 m-wrap" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Email</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtDescrizione" runat="server" CssClass="span6 m-wrap"> </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Telefono</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="TextBoxTelefono" runat="server"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Foto</label>
                                                <div class="controls">
                                                    <div class="fileupload fileupload-new" data-provides="fileupload">
                                                        <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;">
                                                            <a href="#" runat="server" id="A1" title="preview" rel="group1">
                                                                <asp:Image ID="imgFotoArticolo" runat="server" Visible="true" ImageUrl="" />
                                                            </a>
                                                        </div>
                                                        <div>
                                                            <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="default" />
                                                            <asp:LinkButton CausesValidation="false" ID="ButtonUploadFoto" CssClass="btn mini blue" runat="server"
                                                                Text="Aggiungi Foto" OnClick="ButtonUploadFoto_Click">
                                                                <i class="icon-plus"></i>
                                                                Aggiungi Foto
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="lnkCancFoto" runat="server" CausesValidation="false"
                                                                Visible="false" OnClientClick="window.confirm('Cancellare la foto?')" OnClick="CancellaFoto"
                                                                CssClass="btn mini red" ToolTip="Elimina la Foto">
                                                                <i class="icon-trash"></i>
                                                                Cancella Foto
                                                            </asp:LinkButton>
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
                                                    Allegato</label>
                                                <div class="controls">
                                                    <asp:FileUpload ID="FileUploadAllegati" runat="server" CssClass="default" />
                                                    <asp:LinkButton ID="ButtonUploadAllegati" CssClass="btn mini blue" runat="server"
                                                        OnClick="ButtonUploadAllegati_Click" CausesValidation="false">
                                                        <i class="icon-plus"></i>
                                                                Aggiungi Allegato
                                                    </asp:LinkButton>
                                                    <asp:Label ID="lblpathFileAll" runat="server" Text="Nessun file allegato" CssClass="help-inline"></asp:Label>
                                                    <asp:LinkButton ID="lnkCancAllegato" runat="server" CausesValidation="false" OnClientClick="window.confirm('Eliminare allegato?')"
                                                        OnClick="CancellaAllegato" Text="Elimina" CssClass="btn mini red" ToolTip="Elimina allegato">
                                                         <i class="icon-trash"></i> Cancella Allegato
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <asp:Button CausesValidation="false" ID="ButtonAnnulla" CssClass="btn" runat="server"
                                                    Text="Annulla" OnClick="ButtonAnnulla_Click" />
                                                <asp:Button ID="ButtonInsert" CssClass="btn blue" runat="server" Text="Salva" OnClick="ButtonInsert_Click" />
                                                <asp:Button ID="ButtonAgg" CssClass="btn blue" runat="server" Text="Aggiorna" OnClick="ButtonAgg_Click" />
                                            </div>
                                            <!-- ***** START DIV MESSAGGI DI ERRORE ***** -->
                                            <div id="Div1" runat="server" visible="false" class="notification">
                                                <a href="#" class="close" title="Close notification">close</a>
                                                <p>
                                                    <strong>articolo ID:
                                                        <asp:Label ID="Label1" runat="server" Text=""> inserito con successo</asp:Label></strong>
                                                </p>
                                            </div>
                                            <div id="Div2" runat="server" visible="false" class="notification note-attention">
                                                <a href="#" class="close" title="Close notification">close</a>
                                                <p>
                                                    <strong>
                                                        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                                                    </strong>
                                                </p>
                                            </div>
                                            <!-- ***** END DIV MESSAGGI DI ERRORE ***** -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
