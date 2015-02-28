<%@ Page MasterPageFile="~/MasterPage.master" Language="C#" AutoEventWireup="true" CodeFile="AngularTestWithMaster.aspx.cs" Inherits="AngularTestWithMaster" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <!-- Masonry Javascript File -->
    <%--<script type="text/javascript" src="javascript/jquery.isotope.min.js"></script>--%>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>
    <script src="javascript/ng-infinite-scroll.min.js"></script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphMain" runat="Server">

    <div ng-controller="blogController" class="content">
        <div class="blog-holder" >
            <%-- <div infinite-scroll='loadMore()' infinite-scroll-disabled='busy' name="test" ng-repeat="item in posts" isotope-item="isotope-item" class="post">--%>
            <div name="test" ng-repeat="item in posts" isotope-item="isotope-item" class="post">
                <div ng-hide="item.isQuote" id="divPostMedia" class="post-media">
                    <div ng-hide="item.IsQuote" id="divPostMedia" class="post-media">

                        <div ng-show="item.Gallery.length" class="flexslider" id="_blog-slider">
                            <ul class="slides">
                                <li ng-repeat="p in item.Gallery">
                                    <img src="{{ p }}" alt="" />
                                </li>
                            </ul>
                        </div>
                    </div>
                    <iframe width="420" height="315" ng-show="item.Video()" src="{{item.Video}}"></iframe>
                    <a ng-show="item.Img()" style="width: 386px; height: 250px; overflow: hidden;">
                        <img src="{{ item.Img }}" alt="" /></a>
                </div>
                <div id="post_entry" class="post-entry">
                    <div ng-hide="item.IsQuote" id="post_title" class="post-title">
                        <h2 class="title">{{ item.Titolo }}
                        </h2>
                    </div>
                    <div ng-hide="item.IsQuote" id="post_meta" class="post-meta">
                        <ul>
                            <li><span>Pubblicato da</span> <a href="#">Osmairm</a></li>
                            <li>{{ item.Data }}
                            </li>
                        </ul>
                    </div>
                    <div ng-class="{'post-content quote': item.IsQuote}">
                        <p ng-bind-html="item.Descrizione"></p>
                        <%-- {{ item.IsQuote == false ? item.Descrizione : ""}}--%>
                        <p>
                            <a ng-hide="item.IsQuote" href="">Leggi tutto</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div style="display: block; float: left;">
            <a href="" class="button medium grey rounded" ng-click="loadMore()">
                <h3>Load More...</h3>
            </a>
        </div>
    </div>
</asp:Content>











