<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Contatti.aspx.cs" Inherits="Contatti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <link href="css/map/space.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?v=3.4&amp;sensor=false"></script>
    <script src="javascript/map/mappa_jquery.js" type="text/javascript"></script>
    <script src="javascript/map/infobubble_min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var func_Obj = new initialize("", "", "17", "1");
            func_Obj.markers("strutture-osmairm", "xml/marker.xml");
        });
    </script>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <div id="content-wrapper">
        <div class="fullwidth">
            <div id="mappa" class="google-map" style="position: relative; background-color: rgb(229, 227, 223); overflow: hidden;">
            </div>
            <div class="content">
                <div class="one-half">
                    <h3>Mandaci un messaggio</h3>
                    <form runat="server">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>

                        <asp:UpdatePanel ID="UpdatePanelContatti" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <div class="form" id="contact-form">
                                    <p class="comment-form-author">
                                        <label>Nome <span class="required">*</span></label>
                                        <input runat="server" id="ContattiTxtNome" class="requiredField" type="text"></input>
                                    </p>
                                    <p class="comment-form-email">
                                        <label>Indirizzo e-mail <span class="required">*</span></label>
                                        <input runat="server" id="ContattiTxtEmail" class="requiredField email" type="text"></input>
                                    </p>
                                    <p class="comment-form-url">
                                        <label>Oggetto</label>
                                        <input runat="server" id="ContattiTxtOggetto" class="text" type="text"></input>
                                    </p>
                                    <p class="comment-form-comment">
                                        <label>Messaggio</label>
                                        <textarea runat="server" rows="20" cols="30" id="ContattiTxtMessage" class="requiredField"></textarea>
                                    </p>
                                    <p class="form-submit">
                                        <asp:LinkButton ID="ButtonInvia" runat="server" CssClass="button medium rounded grey" type="submit"
                                            OnClick="ButtonInvia_Click">
                                            <asp:Literal ID="lblInviaMail" runat="server" Text="<%$ Resources:Res , lblInviaMail %>" />
                                        </asp:LinkButton>
                                    </p>
                                    <p id="MailNotification" class="comment-form-comment">
                                        <asp:Label runat="server" ID="MailStatus" Text=""></asp:Label>
                                    </p>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </form>
                </div>
                <!--END ONE-HALF-->
                <div class="one-half last">
                    <h3>Contatti</h3>
                    <p>
                        <strong>Dove siamo</strong><br />
                        Via Cappuccini, 9 - 74014 Laterza (Ta)<br />
                        Telefono: +39 099 821 62 16<br />
                        Fax: +39 099 821 61 83<br />
                        Mail: <a href="mailto:info@osmairm.it">info@osmairm.it</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>




