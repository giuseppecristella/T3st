<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="R360.aspx.cs" Inherits="Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <!-- Masonry Javascript File -->
    <script type="text/javascript" src="javascript/jquery.isotope.min.js"></script>
    <script type="text/javascript" src="javascript/jquery.flexslider.js"></script>
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <div class="archive-list">
        <div runat="server" id="months">
        </div>
        <asp:XmlDataSource ID="XmlDataSourceTags" runat="server" DataFile="~/Xml/ListaTagsNews.xml"
            XPath="//News//TipoNews//TipoNews_Item"></asp:XmlDataSource>
        <div runat="server" id="categories">
        </div>
        <div id="tags" class="tags">
            <asp:Literal runat="server" ID="ltrNewsType"></asp:Literal>
        </div>
        <span id="multi" class="peppe">
            <a href="#" class="chiudi">x</a>
        </span> 
    </div>
    <div class="content">
        <div class="section-title">
            <div class="filterable tags">
                <ul id="archive-nav">
                    <li><a class="tag-celeste" href="#">Archivio Mesi</a></li>
                    <li><a class="tag-celeste" href="#">Archivio Categorie</a></li>
                    <li><a class="tag-celeste" href="#">Archivio Media</a></li>
                </ul>
            </div>
        </div>
        <div class="blog-holder">
            <asp:ListView ID="lvBlogPost" OnItemDataBound="lvBlogPost_OnItemDataBound" runat="server">
                <LayoutTemplate>
                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                </LayoutTemplate>
                <ItemTemplate>
                    <div class="post">
                        <div runat="server" id="divPostMedia" class="post-media">
                            <asp:Literal ID="ltrMedia" runat="server"></asp:Literal>
                        </div>
                        <div runat="server" id="post_entry" class="post-entry">
                            <div runat="server" id="post_title" class="post-title">
                                <h2 class="title">
                                    <asp:Literal ID="ltrTitolo" runat="server"></asp:Literal>
                                </h2>
                            </div>
                            <div runat="server" id="post_meta" class="post-meta">
                                <ul>
                                    <li><span>Pubblicato da</span> <a href="#">Osmairm</a></li>
                                    <li>
                                        <span><%# System.Globalization.DateTimeFormatInfo.CurrentInfo.GetDayName(System.Convert.ToDateTime(Eval("Data").ToString()).DayOfWeek)   %></span>
                                        <%# System.Convert.ToDateTime(Eval("Data")).Day.ToString()  %>
                                        <%# System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(System.Convert.ToDateTime(Eval("Data").ToString()).Month)   %>
                                    </li>
                                </ul>
                            </div>
                            <div runat="server" id="post_content" class="post-content">
                                <%# Eval("Descrizione").ToString() %>
                                <p>
                                    <asp:Literal ID="ltrLeggiTutto" runat="server"></asp:Literal>
                                </p>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <asp:ObjectDataSource ID="objNews" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetListaNews"
                TypeName="DataSetVepAdminTableAdapters.NewsTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_News_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Fonte" Type="String" />
                    <asp:Parameter Name="Titolo" Type="String" />
                    <asp:Parameter Name="Testo" Type="String" />
                    <asp:Parameter Name="Data" Type="DateTime" />
                    <asp:Parameter Name="Visibile" Type="Boolean" />
                    <asp:Parameter Name="Descrizione" Type="String" />
                    <asp:Parameter Name="Tipo" Type="String" />
                    <asp:Parameter Name="UrlFotoHome" Type="String" />
                    <asp:Parameter Name="Allegati" Type="String" />
                    <asp:Parameter Name="Video" Type="String" />
                    <asp:Parameter Name="TitoloENG" Type="String" />
                    <asp:Parameter Name="AutoreENG" Type="String" />
                    <asp:Parameter Name="DescrizioneENG" Type="String" />
                    <asp:Parameter Name="TestoENG" Type="String" />
                    <asp:Parameter Name="TitoloTED" Type="String" />
                    <asp:Parameter Name="DescrizioneTED" Type="String" />
                    <asp:Parameter Name="TestoTED" Type="String" />
                    <asp:Parameter Name="Tags" Type="String" />
                    <asp:Parameter Name="Ws_Flag" Type="Boolean" />
                    <asp:Parameter Name="Original_News_ID" Type="Int32" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="Tipo" Type="String" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="Fonte" Type="String" />
                    <asp:Parameter Name="Titolo" Type="String" />
                    <asp:Parameter Name="Testo" Type="String" />
                    <asp:Parameter Name="Data" Type="DateTime" />
                    <asp:Parameter Name="Visibile" Type="Boolean" />
                    <asp:Parameter Name="Descrizione" Type="String" />
                    <asp:Parameter Name="Tipo" Type="String" />
                    <asp:Parameter Name="UrlFotoHome" Type="String" />
                    <asp:Parameter Name="Allegati" Type="String" />
                    <asp:Parameter Name="Video" Type="String" />
                    <asp:Parameter Name="TitoloENG" Type="String" />
                    <asp:Parameter Name="AutoreENG" Type="String" />
                    <asp:Parameter Name="DescrizioneENG" Type="String" />
                    <asp:Parameter Name="TestoENG" Type="String" />
                    <asp:Parameter Name="TitoloTED" Type="String" />
                    <asp:Parameter Name="DescrizioneTED" Type="String" />
                    <asp:Parameter Name="TestoTED" Type="String" />
                    <asp:Parameter Name="Tags" Type="String" />
                    <asp:Parameter Name="Ws_Flag" Type="Boolean" />
                </InsertParameters>
            </asp:ObjectDataSource>
        </div>
        <div class="wp-pagenavi">
            <form runat="server">
                <asp:DataPager PagedControlID="lvBlogPost" OnPreRender="DataPagegBlogPreRender" PageSize="12" ID="DataPagerBlog" runat="server">
                    <Fields>
                        <asp:NumericPagerField CurrentPageLabelCssClass="wp-pagenavi-selected" ButtonCount="12" />
                    </Fields>
                </asp:DataPager>
            </form>
        </div>
    </div>
</asp:Content>
