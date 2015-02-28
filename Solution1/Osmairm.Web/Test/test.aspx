<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <div ng-app="" ng-init="names=['Jani','Hege','Kai','1','2','3']" class="blog-holder">
            <div ng-repeat="x in names" class="post">
                {{ x }}
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
            </div>
        </div>
        
     <%--   <div ng-app="" ng-init="names=['Jani','Hege','Kai']">
            <ul>
                <li ng-repeat="x in names">
                </li>
            </ul>
          <div>--%>
                <%-- <div ng-app=""    ng-init="posts=['Jani','Hege','Kai']" class="blog-holder">
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

        </div>--%>
    </form>
</body>
</html>
