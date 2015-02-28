<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HeaderUC.ascx.cs" Inherits="HeaderUC" %>
<script src="../javascript/menu.js"></script>
<div ng-controller="headerMenuController" name="headerMenu" class="header">
    <div id="logo">
        <a href="Default.aspx">
            <img src="images/logo.png" alt="" /></a>
    </div>
    <div id="primary-menu">
        <ul runat="server" id="Menu" class="menu">
            <li><a runat="server" id="hAzienda" href="../Azienda.aspx">Chi Siamo</a>
                <ul>
                    <li class="nav-azienda-1" id="li_azienda_1"><a id="azienda_1" href="../Azienda.aspx#storia">La nostra Storia</a></li>
                    <li class="nav-azienda-2"><a id="azienda_2" href="../Azienda.aspx#oggi">Osmairm Oggi</a></li>
                    <li class="nav-azienda-3"><a id="azienda_3" href="../Azienda.aspx#filosofia">La nostra
                                    Filosofia</a></li>
                    <li class="nav-azienda-4"><a id="azienda_4" href="../Azienda.aspx#mission">Mission Aziendale</a></li>
                    <li class="nav-azienda-5"><a id="azienda_5" href="../Azienda.aspx#metodo">Metodo</a></li>
                    <li class="nav-azienda-6"><a id="azienda_6" href="../Azienda.aspx#personale">Il personale</a></li>
                </ul>
            </li>
            <li><a runat="server"  id="hStrutture" href="../Strutture.aspx">Strutture</a>
                <asp:Literal ID="ltrl_ul_navigoss" runat="server"></asp:Literal>
                <asp:Literal ID="ltr_li_struttura" runat="server"></asp:Literal>
                <asp:Literal ID="ltrl_ul_navigoss_close" Text="</ul>" runat="server"></asp:Literal>
            </li>
            <li><a runat="server" id="hServizi" href="../Servizi.aspx">Servizi</a>
                <ul>
                    <li id="li1" class="nav-riab-1"><a href="../servizi.aspx#riab-1" id="A1">Riab.Residenziale</a></li>
                    <li id="li2" class="nav-riab-2"><a href="../servizi.aspx#riab-2" id="A2">T.Ri.P. (Post
                                    acuti)</a></li>
                    <li id="li3" class="nav-riab-3"><a href="../servizi.aspx#riab-3" id="A3">Estensivo</a></li>
                    <li id="li4" class="nav-riab-4"><a href="../servizi.aspx#riab-4" id="A4">Riab. Ambulatoriale</a></li>
                    <li id="li5" class="nav-riab-5"><a href="../servizi.aspx#riab-5" id="A5">Riab. Domiciliare</a></li>
                    <li id="li6" class="nav-riab-6"><a href="../servizi.aspx#riab-6" id="A6">Ricoveri Solventi</a></li>
                    <li id="li7" class="nav-riab-7"><a href="../servizi.aspx#riab-7" id="A7">Riab. età evolutiva</a></li>
                    <li id="li8" class="nav-riab-8"><a href="../servizi.aspx#riab-8" id="A8">Turismo Accessibile</a></li>
                </ul>
            </li>
            <li><a runat="server" id="hProgetti" href="../Progetti.aspx">Progetti</a></li>
            <li><a runat="server" id="hFormazione" href="../Formazione.aspx">Formazione</a>
                <ul>
                    <li id="li_formazione_1" class="nav-formazione-1"><a href="../formazione.aspx#formazione-1"
                        id="formazione_1">Info Generali</a></li>
                    <li id="li_formazione_2" class="nav-formazione-2"><a href="../formazione.aspx#formazione-2"
                        id="formazione_2">Corsi Attivi</a></li>
                </ul>
            </li>
            <li><a runat="server"  id="hAlbums" href="../Albums.aspx">Gallery</a></li>
          <%--  <li><a runat="server"  id="hMagazine" href="#">Turismo Accessibile</a></li>--%>
            <li><a runat="server"  id="hR360" href="../R360.aspx">R360</a></li>
            <li><a runat="server" id="hContatti" href="../Contatti.aspx">Contatti</a></li>
        </ul>
    </div>
    <ul class="social-bookmarks">
        <li class="facebook"><a href="#">facebook</a></li>
        <li class="googleLarge"><a href="#">skype</a></li>
        <li class="youtubeLarge"><a href="#">twitter</a></li>
        <li class="prenotazioni">
            <a class="trigger-header" href="#">Newsletter</a> </li>
    </ul>
    <div id="back-top">
        <a href="#">Back to Top</a>
    </div>
</div>
