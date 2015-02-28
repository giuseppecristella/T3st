<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAngular.master" AutoEventWireup="true" CodeFile="AngularInUserControl.aspx.cs" Inherits="AngularInUserControl" %>

<%@ Register Src="~/UserControls/NewletterUC.ascx" TagPrefix="uc1" TagName="NewletterUC" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="one-half">
            <uc1:NewletterUC runat="server" ID="NewletterUC" />
           <%-- <form ng-app="" ng-controller="newsletterController" name="formNewsletter"
                novalidate>
                <h4>Per iscriversi al nostro servizio di newsletter è necessario compilare i campi sottostanti
                </h4>
                <p>
                    <input style="width: 65%" type="text" name="userName" ng-model="newUser.user" placeholder="Nome Cognome" required>
                    <span class="contact-error" ng-show="formNewsletter.userName.$dirty && formNewsletter.userName.$invalid">
                        <span ng-show="formNewsletter.userName.$error.required">*</span>
                    </span>
                </p>

                <p>
                    <input style="width: 65%" type="email" placeholder="Indirizzo E-Mail" name="email" ng-model="newUser.email" required>
                    <span class="contact-error" ng-show="formNewsletter.email.$dirty && formNewsletter.email.$invalid">
                        <span ng-show="formNewsletter.email.$error.required">*</span>
                        <span ng-show="formNewsletter.email.$error.email">Formato email non corretto</span>
                    </span>
                </p>

                <p>
                    <input style="margin-left: 0" name="cbPrivacy" type="checkbox" ng-model="privacy" required>
                    <label for="cbPrivacy">Dichiarazione di consenso</label>
                    <span style="color: red" ng-show="formNewsletter.cbPrivacy.$dirty && formNewsletter.cbPrivacy.$invalid">
                        <span ng-show="formNewsletter.cbPrivacy.$error.required">E' necessario accettare la dichiarazione di consenso</span>
                    </span>
                </p>
                <p>
                    Letta l'informativa di cui sopra ai sensi dell'art. 13 del D. lgs. 30 giugno 2003, n. 196: per quanto riguarda il trattamento dei dati personali per l'invio, da parte della Newsletter elettronica, l’invio di materiale pubblicitario e promozionale dei propri prodotti e servizi e di quelli di eventuali società partner, per indagini di rilevazione e per la partecipazione a ulteriori operazioni di promozione.
                </p>
                <p ng-model="saveResult" ng-class="resultStyle">
                    {{ saveResult }}
                </p>
                <p>
                    <a href="" ng-show="formNewsletter.$invalid == false"
                        class="button medium grey rounded" ng-click="save()">Iscriviti</a>
                </p>
            </form>--%>
        </div>
</asp:Content>

