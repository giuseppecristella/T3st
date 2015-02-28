/*----------------------------------------------------*/
/*	  ISOTOPE (FILTER NAVIGATION AND MASONRY)
/*----------------------------------------------------*/
$(window).load(function () {

    if ($(".blog-holder").length > 0) {

        setTimeout(function () {
           
            $('.blog-holder').isotope({
                itemSelector: '.post'
            });
        }, 4000);

        //var $container_blog = $('.blog-holder');
        //$container_blog.isotope({
        //	itemSelector : '.post'
        //});

        //$(window).resize(function() {
        //	var $container_blog = $('.blog-holder');
        //	$container_blog.isotope({
        //		itemSelector : '.post'
        //	});
        //});
    }


});




var infiniteScroll = angular.module('ngOsmairm', ['infinite-scroll']);

function newsletterController($scope, $http) {

    //$scope.posts = ["one", "two", "three"];

    $scope.saveResult = '';
    $scope.privacy = false;
    $scope.newUser = {};
    $scope.resultStyle = '';

    $scope.save = function () {

        $http({
            method: 'POST',
            url: 'Default.aspx/SubscribeUser',
            data: { user: $scope.newUser },
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            }
        })
            .then(function (result) {
                // success
                if (result.data.d.Result == true) {
                    $scope.resultStyle = 'newsletter-success-message';
                } else {
                    $scope.resultStyle = 'newsletter-error-message';
                }
                $scope.saveResult = result.data.d.Message;
            },
                function () {
                    // error
                });

        // ajax post
        //$.ajax({
        //    type: "POST",
        //    url: "Default.aspx/SubscribeUser",
        //    data: "{}",
        //    contentType: "application/json; charset=utf-8",
        //    dataType: "json",
        //    success: function (result) {
        //        alert(result.d);
        //        $scope.saveResult = result.d;
        //    }
        //});


        // angular http.post 
        //$http.post("Default.aspx/SubscribeUser", $scope.newUser)
        //  .then(function (result) {
        //      // success
        //        alert(result.state);

        //    },
        //  function () {
        //      // error
        //  });

    }
}

function blogController($scope, $http, $sce) {

    angular.element(document).ready(function () {
        $http({
            method: 'POST',
            url: 'AngularTestWithMaster.aspx/GetPostContents',
            data: { startingPageIndex: 0, pageSize: 10 },
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            }
        })
       .then(function (result) {
           // success
           $scope.posts = result.data.d;

           for (var i = 0; i < $scope.posts.length; i++) {
               $scope.posts[i].Descrizione = $sce.trustAsHtml($scope.posts[i].Descrizione);
               $scope.posts[i].Video = $sce.trustAsResourceUrl($scope.posts[i].Video);

               // $container_blog.isotope('appended', $scope.posts).fadeIn();

               setTimeout(function () {

                   $('.blog-holder').isotope({
                       itemSelector: '.post'
                   });
               }, 4000);
           }

       },
       function () {
           // error
       });
    });

    $scope.busy = false;
    var pageIndex = 1;
    $scope.loadMore = function () {

        if ($scope.busy) return;
        $scope.busy = true;

        $http({
            method: 'POST',
            url: 'AngularTestWithMaster.aspx/GetPostContents',
            data: { startingPageIndex: pageIndex, pageSize: 10 },
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            }
        })
         .then(function (result) {
             // success
             var tempPost = result.data.d;

             for (var i = 0; i < tempPost.length; i++) {
                 tempPost[i].Descrizione = $sce.trustAsHtml(tempPost[i].Descrizione);
                 tempPost[i].Video = $sce.trustAsResourceUrl(tempPost[i].Video);
             }

             for (var i = 0; i < tempPost.length; i++) {
                 $scope.posts.push(tempPost[i]);
             }

             pageIndex++;
             // $scope.posts = $scope.posts.concat(tempPost);
             $scope.busy = false;

            // $('.blog-holder').isotope('addItems', $scope.posts);
             $('.blog-holder').isotope('reloadItems').isotope({ sortBy: 'original-order' });
             //setTimeout(function () {
                
             //}, 4000);
         },
             function () {
                 // error
             });

    };

    $scope.testHtml = $sce.trustAsHtml("<h3>Titolo</h3>");
    $scope.trustUrl = $sce.trustAsResourceUrl("http://www.youtube.com/embed/o8IGrTv4l-Q");

    //$scope.posts = [
    //    { "gallery": ["Handler.ashx?PhotoID=130", "Handler.ashx?PhotoID=132"], "isQuote": false, "titolo": "John", "descrizione": "lorem ipsum dole sit amat", "video": "" },
    //    { "isQuote": false, "titolo": "Anna", "descrizione": "lorem ipsum dole sit amat", "video": $sce.trustAsResourceUrl("http://www.youtube.com/embed/o8IGrTv4l-Q") },
    //    { "isQuote": true, "titolo": "Peter", "img": "img/Foto/03.jpg", "descrizione": "<p>Il S&igrave; e l&rsquo;Amen sono il terreno sicuro sul quale poggiamo. Perdiamo continuamente di vista in questo tempo sconvolto la ragione per la quale si merita vivere. Ci &egrave; consentito vivere continuamente vicino a Dio e in sua presenza e allora non c&rsquo;&egrave; pi&ugrave; niente di impossibile per noi non essendoci niente di impossibile per Dio.</p>", "video": "" },
    //    { "gallery": ["Handler.ashx?PhotoID=130", "Handler.ashx?PhotoID=132"], "isQuote": false, "titolo": "John", "descrizione": "lorem ipsum dole sit amat", "video": "" },
    //    { "isQuote": false, "titolo": "Anna", "descrizione": "lorem ipsum dole sit amat", "video": $sce.trustAsResourceUrl("http://www.youtube.com/embed/o8IGrTv4l-Q") },
    //    { "isQuote": true, "titolo": "Peter", "img": "img/Foto/03.jpg", "descrizione": "<p>Il S&igrave; e l&rsquo;Amen sono il terreno sicuro sul quale poggiamo. Perdiamo continuamente di vista in questo tempo sconvolto la ragione per la quale si merita vivere. Ci &egrave; consentito vivere continuamente vicino a Dio e in sua presenza e allora non c&rsquo;&egrave; pi&ugrave; niente di impossibile per noi non essendoci niente di impossibile per Dio.</p>", "video": "" },
    //    { "photo": "img/foto/03.jpg", "isQuote": false, "titolo": "John", "img": "img/Foto/03.jpg", "descrizione": "lorem ipsum dole sit amat", "video": "" },
    //    { "gallery": ["Handler.ashx?PhotoID=130", "Handler.ashx?PhotoID=132"], "isQuote": false, "titolo": "John", "descrizione": "lorem ipsum dole sit amat", "video": "" }
    //];

    $scope.postContent = 'post-content quote';
}