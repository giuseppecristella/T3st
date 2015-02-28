<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Progetti.aspx.cs" Inherits="Progetti" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <script type="text/javascript" src="javascript/jquery.isotope.min.js"></script>
</asp:Content>
 
<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">

    <div class="content">
        <div class="section-title">
            <div class="filterable_p tags">
                <ul>
                    <asp:Repeater ID="rptTags" OnItemDataBound="_itemDataBound" runat="server">
                        <ItemTemplate>
                            <asp:Literal runat="server" ID="li_FirstTag"></asp:Literal>
                            <li runat="server" id="li_tag" class="active"></li>

                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <!--END UL-->
            </div>
            <!--END FILTERABLE-->
        </div>
        <!--END SECTION TITLE-->
        <div class="portfolio-grid">
            <ul id="thumbs">
                <asp:ListView ID="ListViewProgetti" runat="server">
                    <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li class="web">
                            <div class="item">
                                <img src='<%#Eval("UrlFotoHome") %>' alt='<%#Eval("Titolo") %>' />
                                <div class="item-info">
                                    <h3 class="title"><a href="#"><%#Eval("Titolo") %></a></h3>
                                </div>
                                <!--END ITEM-INFO-->
                                <div class="item-info-overlay">
                                    <div>
                                        <%#Eval("DescrizioneENG") %> <%--descrizione breve--%>
                                        <a href='ProgettoDett.aspx?Id=<%#Eval("News_ID") %>' class="dettaglio">[Leggi Tutto]</a>
                                        <a href='ProgettoDett.aspx?Id=<%#Eval("News_ID") %>' class="view">dettaglio</a>
                                        <a href='<%#Eval("UrlFotoHome") %>' class="preview" data-rel="prettyPhoto">Documenti</a>
                                    </div>
                                </div>
                                <!--END ITEM-INFO-OVERLAY-->
                            </div>
                            <!--END ITEM-->
                        </li>
                    </ItemTemplate>
                </asp:ListView>
            </ul>
            <!--END THUMBS-->
        </div>
        <!--END PORTFOLIO-GRID-->
    </div>
    <!--END CONTENT-->
    <!--END CONTENT-->
</asp:Content>
