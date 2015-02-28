<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Servizi.aspx.cs" Inherits="Servizi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <div class="content">  
        <div id="inner-content">
            <asp:Literal ID="literalTemplate" runat="server"></asp:Literal>
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
        <!--END INNER-CONTENT-->
        <div class="border-radius" id="sidebar">
            <div class="widget">
                <br />
                <h3 class="title">Ultime Novità</h3>
                <ul class="bra_recent_entries">
                    <asp:Repeater DataSourceID="objLastNews" runat="server" ID="rptLastNews">
                        <ItemTemplate>
                            <li><span class="date">
                                <%# System.Globalization.DateTimeFormatInfo.CurrentInfo.GetDayName(Convert.ToDateTime(Eval("Data").ToString()).DayOfWeek)   %>
                                <%# Convert.ToDateTime(Eval("Data")).Day.ToString()  %>
                                <%# System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(System.Convert.ToDateTime(Eval("Data").ToString()).Month)   %></span>
                                <a href="NewsDetail.aspx?Id=<%#Eval("News_ID") %>">
                                    <%# Eval("Titolo") %></a> </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <!--END UL-->
            </div>
            <!--END WIDGET-->
            <div style="padding-left: 10px;" class="widget">
                <h3 class="title">Archivio</h3>
                <ul class="archive">
                    <asp:Repeater OnItemDataBound="rptArchivioOnItemDataBound" runat="server" ID="rptArchivio">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <!--END UL-->
            </div>
            <!--END WIDGET-->
            <div class="widget">
                <h3 class="title">Categorie</h3>
                <ul class="archive">
                    <asp:XmlDataSource ID="xmlTags" runat="server" DataFile="~/Xml/ListaTagsNews.xml" TransformFile="~/Xml/ListaTagsNews.xslt"></asp:XmlDataSource>
                    <asp:Repeater ID="rptTags" DataSourceID="xmlTags" runat="server">
                        <ItemTemplate>
                            <li><a href="Blog.aspx?tag=<%#Eval("text") %>">
                                <%#Eval("text") %></a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <!--END WIDGET-->
            </div>
            <!--END WIDGET-->
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
                <!--END PHOTOSTREAM FLICKR_LIST-->
            </div>
            <!--END WIDGET-->
        </div>
        <!--END SIDEBAR-->
    </div>
    <!--END CONTENT-->
</asp:Content>
