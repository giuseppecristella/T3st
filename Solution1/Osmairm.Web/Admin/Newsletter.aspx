<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" ValidateRequest="false" EnableEventValidation="true"
    CodeFile="Newsletter.aspx.cs" Inherits="Admin_ManageLinks" %>
  <%@ Register TagPrefix="CKEditor" Namespace="CKEditor.NET" Assembly="CKEditor.NET, Version=3.6.2.0, Culture=neutral, PublicKeyToken=e379cdf2f8354999" %>
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
    <li><a href="ManageMAGAZINE.aspx?idTipo=5">MAGAZINE</a></li>
</asp:Content>
<asp:Content ID="ContentBody" runat="server" ContentPlaceHolderID="cphAdminBody">
    <script type="text/javascript">
        function DeleteConfirmation() {
            if (!window.confirm('Confirm delete?')) return false;
        }
    </script>
      <div class="page-content">
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <h3 class="page-title">Gestione Newsletter <small>Osmairm</small>
                    </h3>
                    <div class="_form-actions">
                        <asp:TextBox ID="txtEmail" runat="server" Style="background: #ffffff;" class="span6 m-wrap"></asp:TextBox>
                        <asp:LinkButton ID="btnInsert" CssClass="btn blue" runat="server" Text="Aggiungi email"
                            OnClick="btnInsert_Click"><i class="icon-plus"></i> Aggiungi email</asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>Utenti Registrati</h4>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel runat="server" ID="updPnlSubscribedUsers" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="portlet-body">
                                    <asp:ObjectDataSource ID="ObjectDataSourceMail" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetListaMailNewsLetter" TypeName="DataSetVepAdminTableAdapters.NewsLetterTableAdapter"
                                        DeleteMethod="Delete">
                                        <DeleteParameters>
                                            <asp:Parameter Name="email" Type="String" />
                                        </DeleteParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ListView ID="lvUsersSubscribed" runat="server" DataKeyNames="idUtente" DataSourceID="ObjectDataSourceMail"
                                        OnItemCommand="lvUsersSubscribed_OnItemCommand" OnItemCreated="lvUsersSubscribed_OnCreated">
                                        <EmptyDataTemplate>
                                            <div class="notification note-info">
                                                <p>
                                                    <strong>Attenzione:</strong> nessun utente iscritto.
                                                </p>
                                            </div>
                                        </EmptyDataTemplate>
                                        <LayoutTemplate>
                                            <table id="jsDtCorsi" class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>#
                                                        </th>
                                                        <th>Id
                                                        </th>
                                                        <th>e-mail
                                                        </th>
                                                        <th class="hidden-phone"></th>
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
                                                    <asp:Label runat="server" ID="lblRiga" Text=""></asp:Label>
                                                </td>
                                                <td>
                                                    <%#Eval("idUtente")%>
                                                </td>
                                                <td></td>
                                                <td class="hidden-phone">
                                                    <%# Eval("email")%>
                                                </td>
                                                <td>
                                                    <p>
                                                        <asp:LinkButton CommandName="modifica" ID="lnkbtnUpdateSubscribedUser" runat="server" CssClass="btn mini"><i class="icon-edit"></i> Modifica</asp:LinkButton>
                                                        <asp:LinkButton OnClientClick="return DeleteConfirmation();" CommandName="cancella"
                                                            ID="lnkbtnDeleteSubscribedUser" runat="server" CssClass="btn red mini"><i class="icon-trash"></i> Elimina</asp:LinkButton>
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
              <div class="portlet-body">
                <!-- ***** START DIV MESSAGGI DI ERRORE ***** -->
                <div id="DivSuccess" runat="server" visible="false" class="alert alert-success">
                    <p>
                        <asp:Label ID="LabelSuccess" runat="server" Text=""></asp:Label>
                    </p>
                </div>
                <div id="DivError" runat="server" visible="false" class="alert alert-error">
                    <p>
                        <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                    </p>
                </div>
                <!-- ***** END DIV MESSAGGI DI ERRORE ***** -->
            </div>
              <div class="row-fluid">
                <div class="span-12">
                    <div class="pagination pagination-small">
                        <asp:DataPager runat="server" ID="pager" PagedControlID="lvUsersSubscribed" PageSize="9">
                            <Fields>
                                <vscinzPager:FollowingPagerField ButtonCount="10" liActiveClass="active" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN SAMPLE FORM PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>Layout</h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <div action="#" class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label">
                                        Html</label>
                                    <div class="controls">
                                        <CKEditor:CKEditorControl EnableViewState="false" CssClass="span12 ckeditor m-wrap" ID="fckEdtTemplateNewsLetter" runat="server"></CKEditor:CKEditorControl>
                                    </div>
                                </div>
                                <div class="form-actions">
                                        <asp:LinkButton CausesValidation="false" CssClass="btn blue" OnClientClick="return confirm('Confirm?')" OnClick="lnkbtnSaveTemplate_OnClick" ID="lnkbtnSaveTemplate" runat="server"> <i class="icon-save"></i> Save Template</asp:LinkButton>
                                    <asp:LinkButton CausesValidation="false" CssClass="btn green" OnClientClick="return confirm('Confirm?')" OnClick="lnkbtnSendNewsletter_Click" ID="lnkbtnSendNewsletter" runat="server"><i class="icon-reply"></i> Send NewsLetter</asp:LinkButton>
                                  </div>
                            </div>
                            <!-- END FORM-->
                        </div>
                    </div>
                    <!-- END SAMPLE FORM PORTLET-->
                </div>
            </div>
        </div>
      </div>
        <asp:HiddenField runat="server" ID="hdnmailID" />
        <asp:Button ID="btnUpdate" Visible="false" CssClass="button blue fr" runat="server"
        Text="Update" OnClick="btnUpdate_Click" />
        </asp:Content>
