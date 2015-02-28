<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Azienda.aspx.cs" Inherits="Azienda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <script type="text/javascript" src="javascript/filter-fade-portfolio.js"></script>
</asp:Content>
 
<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <div class="content">
        <div id="inner-content">
            <asp:Literal ID="literalTemplate" runat="server"></asp:Literal>
            <div class="divider-border"></div>
            <h3>Personale</h3>
            <asp:XmlDataSource ID="xmlTags" runat="server" DataFile="~/Xml/ListaTipPersonale.xml"
                TransformFile="~/Xml/ListaTipPersonale.xslt"></asp:XmlDataSource>
            <div id="personale" class="filterable tags">
                <ul>
                    <li class="active"><a class="tag-celeste" href="#" data-filter="all">All</a></li> 
                    <asp:Repeater runat="server" ID="rptTags" DataSourceID="xmlTags">
                        <ItemTemplate>
                            <li><a class="tag-celeste" href="#" data-filter="<%#Eval("text").ToString().Replace("-"," ")%>"><%#Eval("text").ToString().Replace("-"," ").ToUpper()%></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div class="portfolio-grid">
                <ul id="thumbs">
                    <asp:ListView ID="ListViewNews" DataSourceID="objNews" runat="server">
                        <LayoutTemplate>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                        </LayoutTemplate>
                        <ItemTemplate>
      <li class='<%#   Utility.GetDescriptionForTypeFromXml(Eval("Tipo").ToString(),"Xml/ListaTipPersonale")%>'>
                                <div class="item">
                                    <img src='<%# Eval("UrlFotoHome") %>' alt="" />
                      
                                    <div class="item-info">
                                        <h3 class="title"><%# Eval("Titolo") %>
                                            <br />
                                            <span style="font-size: 10px;"><%# Eval("Fonte") %></span>
                                        </h3>
                                    </div>
                                    <!--END ITEM-INFO-->
                                    <div class="item-info-overlay">
                                        <div>
                                            <p>
                                                <%# Eval("Descrizione")%>
                                                <br />
                                                <%# Eval("Testo")%>
                                            </p>
                                            <a runat="server" href='<%#Eval("Allegati") %>' visible='<%# Utility.ShowField(Eval("News_ID").ToString()) %>' class="view"><%# Eval("Descrizione").ToString() %></a>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
            </div>
            <asp:ObjectDataSource ID="objNews" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetDataBetween"
                TypeName="DataSetVepAdminTableAdapters.NewsTableAdapter" DeleteMethod="Delete"
                InsertMethod="Insert" UpdateMethod="Update">
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
                    <asp:Parameter DefaultValue="10" Name="Tipo_BEGIN" Type="Int32" />
                    <asp:Parameter DefaultValue="20" Name="Tipo_END" Type="Int32" />
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
            <asp:ObjectDataSource ID="objLastNews" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetUltimeNews" TypeName="DataSetVepAdminTableAdapters.NewsTableAdapter"
                UpdateMethod="Update">
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
        <div class="border-radius" id="sidebar">
            <div class="widget">
                <br />
                <h3 class="title">Ultime Novità</h3>
                <ul class="bra_recent_entries">
                    <asp:Repeater DataSourceID="objLastNews" runat="server" ID="rptLastNews">
                        <ItemTemplate>
                            <li><span class="date">
                                <%# System.Globalization.DateTimeFormatInfo.CurrentInfo.GetDayName(System.Convert.ToDateTime(Eval("Data").ToString()).DayOfWeek)   %>
                                <%# System.Convert.ToDateTime(Eval("Data")).Day.ToString()  %>
                                <%# System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(System.Convert.ToDateTime(Eval("Data").ToString()).Month)   %></span>
                                <a href="NewsDetail.aspx?Id=<%#Eval("News_ID") %>">
                                    <%# Eval("Titolo") %></a> </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div style="padding-left: 10px;" class="widget">
                <h3 class="title">Archivio</h3>
                <ul class="archive">
                    <asp:Repeater OnItemDataBound="rptArchivioItemDataBound" runat="server" ID="rptArchivio">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div class="widget">
                <h3 class="title">Categorie</h3>
                <ul class="archive">
                    <asp:XmlDataSource ID="xmlTagsNews" runat="server" DataFile="~/Xml/ListaTagsNews.xml" TransformFile="~/Xml/ListaTagsNews.xslt"></asp:XmlDataSource>
                    <asp:Repeater ID="rptTagsNews" DataSourceID="xmlTagsNews" runat="server">
                        <ItemTemplate>
                            <li><a href="Blog.aspx?tag=<%#Eval("text") %>">
                                <%#Eval("text") %></a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div style="padding-left: 10px;" class="widget">
                <h3 class="title">Ultime fotografie</h3>
                <div class="photostream">
                    <ul>
                        <asp:Repeater DataSourceID="objFotoBox" ID="rptFotoBox" runat="server">
                            <ItemTemplate>
                                <li><a rel="prettyPhoto[<%# DataBinder.Eval(Container.DataItem, "AlbumID") %>]" href="<%# "Handler.ashx?PhotoID=" + DataBinder.Eval(Container.DataItem, "PhotoID") %>.jpg">
                                    <img src="Handler.ashx?PhotoID=<%#  Eval("PhotoID") %>&W_=100&H_=50" alt="" />
                                </a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <asp:ObjectDataSource ID="objFotoBox" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetLastPhotos" TypeName="DataSetVepAdminTableAdapters.PhotosTableAdapter"
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_PhotoID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="AlbumID" Type="Int32" />
                        <asp:Parameter Name="Caption" Type="String" />
                        <asp:Parameter Name="BytesOriginal" Type="Object" />
                        <asp:Parameter Name="BytesFull" Type="Object" />
                        <asp:Parameter Name="BytesPoster" Type="Object" />
                        <asp:Parameter Name="BytesThumb" Type="Object" />
                        <asp:Parameter Name="ordine" Type="Int32" />
                        <asp:Parameter Name="CaptionEN" Type="String" />
                        <asp:Parameter Name="CaptionDE" Type="String" />
                        <asp:Parameter Name="Original_PhotoID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="AlbumID" Type="Int32" />
                        <asp:Parameter Name="Caption" Type="String" />
                        <asp:Parameter Name="BytesOriginal" Type="Object" />
                        <asp:Parameter Name="BytesFull" Type="Object" />
                        <asp:Parameter Name="BytesPoster" Type="Object" />
                        <asp:Parameter Name="BytesThumb" Type="Object" />
                        <asp:Parameter Name="ordine" Type="Int32" />
                        <asp:Parameter Name="CaptionEN" Type="String" />
                        <asp:Parameter Name="CaptionDE" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </div>
</asp:Content>
