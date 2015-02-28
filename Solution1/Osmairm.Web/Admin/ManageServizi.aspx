<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" 
     ValidateRequest="false" CodeFile="ManageServizi.aspx.cs" Inherits="ManageServizi" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li ><a href="Default.aspx">Azienda<span class="selected"></span></a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li class="active"><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li><a href="ManageFormazione.aspx">FORMAZIONE</a></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
      <li><a href="ManageData.aspx?idTipo=0">NEWS</a></li><li><a href="ManageMAGAZINE.aspx?idTipo=5">MAGAZINE</a></li>
</asp:Content>
<asp:Content ID="ContentBody" runat="server" ContentPlaceHolderID="cphAdminBody">

    <script type="text/javascript" language="javascript">
        function DeleteConfirmation() {
            if (!window.confirm('Eliminare?')) return false;
        }
    </script>

    <div class="page-content">
        <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
        <div id="portlet-config" class="modal hide">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">
                </button>
                <h3>
                    portlet Settings</h3>
            </div>
            <div class="modal-body">
                <p>
                    Here will be a configuration form</p>
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
                    <h3 class="page-title">
                        Pannello di Amministrazione <small>Osmairm</small>
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
 
</asp:Content>
