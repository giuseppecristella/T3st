<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="BlogAngular.aspx.cs" Inherits="Blog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <!-- Masonry Javascript File -->
<%--    <script type="text/javascript" src="javascript/jquery.isotope.min.js"></script>
    <script type="text/javascript" src="javascript/jquery.flexslider.js"></script>
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />--%>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <div class="archive-list">
        <div runat="server" id="months">
        </div>
        <asp:XmlDataSource ID="XmlDataSourceTags" runat="server" DataFile="~/ListaTagsNews.xml"
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
        <script src="javascript/blogController.js"></script>
        <div ng-app="" ng-init="firstName='John'">
            <p>Name:
                <input type="text" ng-model="firstName"></p>
            <p>You wrote: {{ firstName }}</p>
        </div>
        <%-- <div ng-app="" ng-controller="blogController"  ng-init="posts=['Jani','Hege','Kai']" class="blog-holder">
            <div ng-repeat-start="item in posts" class="post">
                <div runat="server" id="divPostMedia" class="post-media">
                  {{ item }}
                </div>
                <div runat="server" id="post_entry" class="post-entry">
                    <div runat="server" id="post_title" class="post-title">
                        <h2 class="title">
                            titolo
                        </h2>
                    </div>
                    <div runat="server" id="post_meta" class="post-meta">
                        <ul>
                            <li><span>Pubblicato da</span> <a href="#">Osmairm</a></li>
                            <li>
                                <span>
                                    data
                                </span>
                                mese giorno anno
                            </li>
                        </ul>
                    </div>
                    <div runat="server" id="post_content" class="post-content">
                        descrizione
                        <p>
                            leggi tutto
                        </p>
                    </div>
                </div>
            </div  ng-repeat-end>


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
        </div>--%>
        <div class="wp-pagenavi">
        </div>
    </div>
</asp:Content>
