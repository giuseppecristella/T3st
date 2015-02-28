<%@ Page Language="C#" MasterPageFile="AdminMaster.master" CodeFile="Photos.aspx.cs" Inherits="Admin_Photos_aspx"
    ValidateRequest="false" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a class="active" href="Default.aspx">AZIENDA</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li><a href="ManageFormazione.aspx">FORMAZIONE</a></li>
    <li class="active"><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
    <li><a href="ManageData.aspx?idTipo=0">NEWS</a></li>
    <li><a href="ManageMAGAZINE.aspx?idTipo=5">MAGAZINE</a></li>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
    <script type="text/javascript">
        function DeleteConfirmation() {
            if (!window.confirm('Vuoi eliminare la foto?')) return false;
        }
    </script>
    <script type="text/javascript">
        function pageLoad() {
            $(".dragga").tableDnD({
                onDragClass: "myDragClass",
                onDrop: function (table, row) {
                    var rows = table.tBodies[0].rows;
                    var debugStr = ""; //"Row dropped was " + row.id + ". New order: ";
                    for (var i = 0; i < rows.length; i++) {
                        debugStr += rows[i].id + "&";
                    }
                    var hdfArrPos = document.getElementById("<%=hdfArrPos.ClientID %>");
                     hdfArrPos.value = debugStr;
                 },
                 onDragStart: function (table, row) {
                 }
             });
         }
    </script>
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
                    <h3 class="page-title">Gestione Albums <small>Osmairm</small>
                    </h3>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="portlet box blue tabbable">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i><span class="hidden-phone">Aggiungi una nuovo foto</span> <span
                                    class="visible-phone">Osmairm</span>
                            </h4>
                        </div>
                        <div class="portlet-body form">
                            <div class="tabbable portlet-tabs">
                                <div class="tab-content">
                                    <div class="tab-pane active" id="portlet_tab1">
                                        <div class="form-horizontal">
                                            <div class="control-group">
                                                <label class="control-label">
                                                    File</label>
                                                <div class="controls">
                                                    <asp:FileUpload ID="PhotoFile" runat="server" CssClass="" />
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvPhotoFile" ControlToValidate="PhotoFile"
                                                        ErrorMessage="<div style='width:99.5%; margin-top:5px; margin-bottom:1px;' class='notification note-attention'><p><b>Warning:</b> required field.</p></div>"
                                                        Display="Dynamic" BackColor="LemonChiffon"></asp:RequiredFieldValidator>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Caption</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="PhotoCaption" runat="server" Text='<%# Bind("Caption") %>' CssClass="span6 m-wrap" />
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Caption 2</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="PhotoCaption2" runat="server" Text='<%# Bind("CaptionEN") %>' CssClass="span6 m-wrap" />
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label">
                                                    Caption 3</label>
                                                <div class="controls">
                                                    <asp:TextBox ID="PhotoCaption3" runat="server" Text='<%# Bind("CaptionDE") %>' CssClass="span6 m-wrap" />
                                                </div>
                                            </div>
                                            <div class="form-actions">
                                                <asp:LinkButton ID="ButtonUploadFoto" CssClass="btn blue" runat="server"
                                                    OnClick="btnUploadFoto_Click"> 
                        <i class="icon-plus"></i> Aggiungi Foto
                                                </asp:LinkButton>
                                            </div>
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
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>
                                <asp:Label ID="lblNomeAlb" runat="server" Text=""></asp:Label></h4>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a><a href="#portlet-config" data-toggle="modal"
                                    class="config"></a><a href="javascript:;" class="reload"></a><a href="javascript:;"
                                        class="remove"></a>
                            </div>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel runat="server" ID="updPnlListaNews" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="portlet-body">
                                    <asp:HiddenField runat="server" ID="hdfArrPos" />
                                    <asp:ListView runat="server" ID="lvFoto" OnItemCommand="lvFoto_OnItemCommand" 
                                        DataKeyNames="PhotoID" >
                                        <EmptyDataTemplate>
                                            <div class="notification note-info">
                                                <p>
                                                    <strong>Warning:</strong> No photos in album.
                                                </p>
                                            </div>
                                        </EmptyDataTemplate>
                                        <LayoutTemplate>
                                            <table id="jsDtCorsi" class="dragga style1 table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Foto
                                                        </th>
                                                        <th>Didascalia
                                                        </th>
                                                        <th></th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr runat="server" id="itemPlaceholder" />
                                                </tbody>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr id="<%# Eval("ordine") %>">
                                                <td>
                                                    <a href="Handler.ashx?PhotoID=<%# Eval("PhotoID") %>.jpg" title="Anteprima">
                                                        <img src='Handler.ashx?Size=S&PhotoID=<%# Eval("PhotoID") %>' alt="" class="thumb size64 clickable" />
                                                    </a>
                                                </td>
                                                <td>
                                                    <asp:TextBox CssClass="span6 m-wrap" runat="server" ID="txtCaption" Text='<%# Server.HtmlEncode(Eval("Caption").ToString()) %>'></asp:TextBox>
                                                    <asp:TextBox Visible="false" CssClass="span6 m-wrap" runat="server" ID="txtCaptionEN" Text='<%# Server.HtmlEncode(Eval("CaptionEN").ToString()) %>'></asp:TextBox>
                                                    <asp:TextBox Visible="false" CssClass="span6 m-wrap" runat="server" ID="txtCaptionDE" Text='<%# Server.HtmlEncode(Eval("CaptionDE").ToString()) %>'></asp:TextBox>
                                                </td>
                                                <td>
                                                    <p>
                                                        <asp:LinkButton ID="imgbtnUpCaption" runat="server" Text="rename" CommandName="updateCaption"
                                                            CssClass="btn mini" CausesValidation="false">
                                     <i class="icon-edit"></i> Modifica didascalia    </asp:LinkButton>
                                                        <asp:LinkButton ID="ImageButton3" OnClientClick="return DeleteConfirmation();" runat="server"
                                                            Text="Delete" CommandName="cancella" CssClass="btn mini" CausesValidation="false">
                                    <i class="icon-edit"></i> Cancella
                                                        </asp:LinkButton>
                                                    </p>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="form-actions">
                        <asp:LinkButton ID="lnkBackNews" runat="server" CssClass="btn red" Text="Indietro"
                            OnClick="btnBack_Click" CausesValidation="false" Style="margin-left: 10px;">
                        </asp:LinkButton>
                        <asp:Button ID="btnChangePos" runat="server" CssClass="btn blue"
                            Text="Riordina" OnClick="btnChangePos_Click" CausesValidation="false"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
