<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Albums.aspx.cs" Inherits="Albums" %>

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
                    <asp:Repeater OnItemDataBound="rptTags_OnItemDataBound" ID="rptTags" runat="server">
                        <ItemTemplate>
                            <li runat="server" id="li_tag" class="active"></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul> 
            </div> 
        </div>
        <div class="portfolio-grid">
            <ul id="thumbs">
                <asp:ListView ID="lvAlbums" runat="server" OnItemCreated="lvAlbums_OnItemCreated">
                    <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li class="web">
                            <div class="item">
                                <img src="Handler.ashx?AlbumID=<%#  Eval("AlbumID") %>&W_=300&H_=300" alt='<%#Eval("Caption") %>' />
                                <div class="item-info">
                                    <h3 class="title">
                                        <%#Eval("Titolo") %> </h3>
                                </div>
                                <!--END ITEM-INFO-->
                                <div class="item-info-overlay">
                                    <div>
                                        <%#Eval("TitoloENG") %>
                                        <asp:Repeater OnItemDataBound="rptPhotos_OnDataBound" runat="server" ID="rptPhotos">
                                            <ItemTemplate>
                                                <asp:Panel ID="pnlDettaglio" Visible="false" runat="server">
                                                    <a style="visibility: visible;" href="<%# "Handler.ashx?PhotoID=" + DataBinder.Eval(Container.DataItem, "PhotoID") %>.jpg"
                                                        class="dettaglio" data-rel="prettyPhoto[<%# DataBinder.Eval(Container.DataItem, "AlbumID") %>]">[Vedi Album]</a>
                                                </asp:Panel>
                                                <%-- link per visualizzare gallery in prettyphoto--%>
                                                <a href="<%# "Handler.ashx?PhotoID=" + DataBinder.Eval(Container.DataItem, "PhotoID") %>.jpg"
                                                    class="view-2" data-rel="prettyPhoto[<%# DataBinder.Eval(Container.DataItem, "AlbumID") %>]">Vedi le foto</a>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                                <!--END ITEM-INFO-OVERLAY-->
                            </div>
                            <!--END ITEM-->
                        </li>
                    </ItemTemplate>
                </asp:ListView>
                <asp:DataPager ID="DataPagerlvAlbum" runat="server" OnPreRender="pagerAlbums_PreRender"
                    PagedControlID="lvAlbums" PageSize="9">
                    <Fields>
                        <vscinzPager:FollowingPagerField ButtonCount="10" />
                    </Fields>
                </asp:DataPager>
            </ul>
        </div>
    </div>
</asp:Content>
