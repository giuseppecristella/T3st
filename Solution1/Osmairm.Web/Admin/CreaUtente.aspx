<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="CreaUtente.aspx.cs" Inherits="Admin_CreaUtente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphAdminMenu" runat="Server">
    <li><a href="Default.aspx">NEWS</a></li>
    <li><a href="ManagePartners.aspx">PARTNERS</a></li>
     <li>
        <asp:LinkButton CausesValidation="false" OnClick="gotosliderPage" runat="server"
            ID="lnkbtnSlider">SLIDER HOME</asp:LinkButton></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <%--<li><a href="Newsletter.aspx">NEWSLETTER</a></li>--%>
      <li><asp:LinkButton CausesValidation="false" OnClick="gotoSpecial" runat="server"
            ID="lnkbtnSpecial">SPECIAL CONTENT</asp:LinkButton></li>
    <li class="active"><a href="#">MANAGE USER</a></li>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <h2>
                    :: New User</h2>
            </div>
            <div class="box-wrap clear">
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
                <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" RequireEmail="False"
                    OnCreatedUser="CreatedUserRedirect">
                    <WizardSteps>
                        <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                            <ContentTemplate>
                                <table class="style1">
                                    <thead>
                                        <tr>
                                            <th>
                                                Item
                                            </th>
                                            <th class="full">
                                                Value
                                            </th>
                                            <th>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>
                                                Username <span class="required">*</span>
                                            </th>
                                            <td class="edit-field long" colspan="2">
                                                <asp:TextBox ID="UserName" runat="server" CssClass="text required fl" MaxLength="100"></asp:TextBox>
                                                <div class="clear">
                                                </div>
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                    ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                    Display="Dynamic" ValidationGroup="CreateUserWizard1">
                                                </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                Password <span class="required">*</span>
                                            </th>
                                            <td class="edit-field long" colspan="2">
                                                <asp:TextBox ID="Password" runat="server" CssClass="required text fl"></asp:TextBox>
                                                <div class="clear">
                                                </div>
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                                    ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                    Display="Dynamic" BackColor="LemonChiffon" ValidationGroup="CreateUserWizard1">
                                                </asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                Retype Password <span class="required">*</span>
                                            </th>
                                            <td class="edit-field long" colspan="2">
                                                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="required text fl"></asp:TextBox>
                                                <div class="clear">
                                                </div>
                                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                    ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                    Display="Dynamic" BackColor="LemonChiffon" ValidationGroup="CreateUserWizard1">
                                                </asp:RequiredFieldValidator>
                                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password"
                                                    ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> la PassWord e la PassWord di Conferma devono corrispondere.</p></div>"
                                                    ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                                E-mail <span class="required">*</span>
                                            </th>
                                            <td class="edit-field long" colspan="2">
                                                <asp:TextBox ID="Email" runat="server" CssClass="required text fl"></asp:TextBox>
                                                <div class="clear">
                                                </div>
                                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                                    ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> Required field</p></div>"
                                                    ToolTip="Il valore Posta elettronica è obbligatorio." Display="Dynamic" BackColor="LemonChiffon"
                                                    ValidationGroup="CreateUserWizard1"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="Email"
                                                    ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning: il formato Email è errato.</b> Inserire una Email valida.</p></div>"
                                                    ValidationExpression="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
                                                    Display="Dynamic" BackColor="LemonChiffon" ValidationGroup="CreateUserWizard1"></asp:RegularExpressionValidator>
                                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="rule2">
                                </div>
                                <div class="form-field clear">
                                    <asp:Button CausesValidation="false" ID="ButtonAnnulla" CssClass="button red fr"
                                        runat="server" Text="Cancel" OnClick="ButtonAnnulla_Click" Style="margin-left: 10px;" />
                                    <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Create User"
                                        ValidationGroup="CreateUserWizard1" CssClass="button green fr" />
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
</asp:Content>
