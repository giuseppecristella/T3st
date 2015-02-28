<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="CreaAdmin.aspx.cs" Inherits="Admin_CreaAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphAdminMenu" runat="Server">
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
    <div class="page-content">
        <div id="portlet-config" class="modal hide">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">
                </button>
                <h3>Titolo</h3>
            </div>
            <div class="modal-body">
                <p>
                </p>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <h3 class="page-title">Creazione Nuovo Utente <small>Osmairm</small>
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
                                            <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" RequireEmail="False"
                                                OnCreatedUser="CreatedUserRedirect">
                                                <WizardSteps>
                                                    <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                                                        <ContentTemplate>
                                                            <div class="control-group">
                                                                <label class="control-label">
                                                                    Username</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="UserName" runat="server" CssClass="span16 m-wrap"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                                        Display="Dynamic" ValidationGroup="CreateUserWizard1">
                                                                    </asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label">
                                                                    Password</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="Password" runat="server" CssClass="span16 m-wrap"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                                        Display="Dynamic" BackColor="LemonChiffon" ValidationGroup="CreateUserWizard1">
                                                                    </asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label">
                                                                    Conferma Password</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="span16 m-wrap"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                                        Display="Dynamic" BackColor="LemonChiffon" ValidationGroup="CreateUserWizard1">
                                                                    </asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                                                        ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> la PassWord e la PassWord di Conferma devono corrispondere.</p></div>"
                                                                        ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                                                </div>
                                                            </div>
                                                            <div class="control-group">
                                                                <label class="control-label">
                                                                    e-mail</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="Email" runat="server" CssClass="span16 m-wrap"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                                        ToolTip="Il valore Posta elettronica è obbligatorio." Display="Dynamic" BackColor="LemonChiffon"
                                                                        ValidationGroup="CreateUserWizard1"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="Email"
                                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning: il formato Email è errato.</b> Inserire una Email valida.</p></div>"
                                                                        ValidationExpression="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
                                                                        Display="Dynamic" BackColor="LemonChiffon" ValidationGroup="CreateUserWizard1"></asp:RegularExpressionValidator>
                                                                    <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <asp:Button CausesValidation="false" ID="ButtonAnnulla" CssClass="btn blue"
                                                                    runat="server" Text="Annulla" OnClick="ButtonAnnulla_Click" Style="margin-left: 10px;" />
                                                                <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Crea Utente"
                                                                    ValidationGroup="CreateUserWizard1" CssClass="btn red" />
                                                            </div>
                                                        </ContentTemplate>
                                                        <CustomNavigationTemplate>
                                                        </CustomNavigationTemplate>
                                                    </asp:CreateUserWizardStep>
                                                    <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                                                    </asp:CompleteWizardStep>
                                                </WizardSteps>
                                            </asp:CreateUserWizard>
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
