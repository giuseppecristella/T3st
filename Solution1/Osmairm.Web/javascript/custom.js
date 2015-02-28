jQuery(document).ready(function($) {
    var color = "yellow"; // tealgreen, green, red, pink, purple, orange, navyblue, magenta, cream, blue, yellow
    var css_url = "css/colors/color-" + color + ".css";
    $('head').append('<link rel="stylesheet" href="' + css_url + '" type="text/css" />');
})

function is_touch_device() {
    return !!('ontouchstart' in window);
}

/*--------------------------------------------------
DROPDOWN MENU
---------------------------------------------------*/
/*
* Superfish v1.4.8 - jQuery menu widget
* Copyright (c) 2008 Joel Birch
*
* Dual licensed under the MIT and GPL licenses:
* 	http://www.opensource.org/licenses/mit-license.php
* 	http://www.gnu.org/licenses/gpl.html
*
* CHANGELOG: http://users.tpg.com.au/j_birch/plugins/superfish/changelog.txt
*/
(function($) { $.fn.superfish = function(op) { var sf = $.fn.superfish, c = sf.c, $arrow = $(['<span class="', c.arrowClass, '"> &#187;</span>'].join("")), over = function() { var $$ = $(this), menu = getMenu($$); clearTimeout(menu.sfTimer); $$.showSuperfishUl().siblings().hideSuperfishUl(); }, out = function() { var $$ = $(this), menu = getMenu($$), o = sf.op; clearTimeout(menu.sfTimer); menu.sfTimer = setTimeout(function() { o.retainPath = ($.inArray($$[0], o.$path) > -1); $$.hideSuperfishUl(); if (o.$path.length && $$.parents(["li.", o.hoverClass].join("")).length < 1) { over.call(o.$path); } }, o.delay); }, getMenu = function($menu) { var menu = $menu.parents(["ul.", c.menuClass, ":first"].join(""))[0]; sf.op = sf.o[menu.serial]; return menu; }, addArrow = function($a) { $a.addClass(c.anchorClass).append($arrow.clone()); }; return this.each(function() { var s = this.serial = sf.o.length; var o = $.extend({}, sf.defaults, op); o.$path = $("li." + o.pathClass, this).slice(0, o.pathLevels).each(function() { $(this).addClass([o.hoverClass, c.bcClass].join(" ")).filter("li:has(ul)").removeClass(o.pathClass); }); sf.o[s] = sf.op = o; $("li:has(ul)", this)[($.fn.hoverIntent && !o.disableHI) ? "hoverIntent" : "hover"](over, out).each(function() { if (o.autoArrows) { addArrow($(">a:first-child", this)); } }).not("." + c.bcClass).hideSuperfishUl(); var $a = $("a", this); $a.each(function(i) { var $li = $a.eq(i).parents("li"); $a.eq(i).focus(function() { over.call($li); }).blur(function() { out.call($li); }); }); o.onInit.call(this); }).each(function() { var menuClasses = [c.menuClass]; if (sf.op.dropShadows && !($.browser.msie && $.browser.version < 7)) { menuClasses.push(c.shadowClass); } $(this).addClass(menuClasses.join(" ")); }); }; var sf = $.fn.superfish; sf.o = []; sf.op = {}; sf.IE7fix = function() { var o = sf.op; if ($.browser.msie && $.browser.version > 6 && o.dropShadows && o.animation.opacity != undefined) { this.toggleClass(sf.c.shadowClass + "-off"); } }; sf.c = { bcClass: "sf-breadcrumb", menuClass: "sf-js-enabled", anchorClass: "sf-with-ul", arrowClass: "sf-sub-indicator", shadowClass: "sf-shadow" }; sf.defaults = { hoverClass: "sfHover", pathClass: "overideThisToUse", pathLevels: 1, delay: 800, animation: { opacity: "show" }, speed: "normal", autoArrows: true, dropShadows: true, disableHI: false, onInit: function() { }, onBeforeShow: function() { }, onShow: function() { }, onHide: function() { } }; $.fn.extend({ hideSuperfishUl: function() { var o = sf.op, not = (o.retainPath === true) ? o.$path : ""; o.retainPath = false; var $ul = $(["li.", o.hoverClass].join(""), this).add(this).not(not).removeClass(o.hoverClass).find(">ul").hide().css("visibility", "hidden"); o.onHide.call($ul); return this; }, showSuperfishUl: function() { var o = sf.op, sh = sf.c.shadowClass + "-off", $ul = this.addClass(o.hoverClass).find(">ul:hidden").css("visibility", "visible"); sf.IE7fix.call($ul); o.onBeforeShow.call($ul); $ul.animate(o.animation, o.speed, function() { sf.IE7fix.call($ul); o.onShow.call($ul); }); return this; } }); })(jQuery);

/*--------------------------------------------------
ADDITIONAL CODE FOR DROPDOWN MENU
---------------------------------------------------*/
jQuery(document).ready(function($) {
    $('ul.menu').superfish({
        delay: 100,                            // one second delay on mouseout 
        animation: { opacity: 'show', height: 'show' },  // fade-in and slide-down animation 
        speed: 'fast',                          // faster animation speed 
        autoArrows: false                           // disable generation of arrow mark-up 
    });

});




jQuery(document).ready(function($) {

    $("#primary-menu > ul > li > a").mouseover(function() {
        var selectedElementId = $(this).attr('id');

        var ulElement = $("#primary-menu > ul");

        $("#primary-menu > ul").find('li').each(function() {
            var menuItem = $('> a', this);
            var menuItemId = menuItem.attr('id');



            if (menuItemId != null) {
                if (menuItemId.indexOf('ctl00') >= 0 || menuItemId.indexOf('h') >= 0) {

                    if (menuItemId != selectedElementId) {

                        $(menuItem).css("font-weight", "normal");

                    }
                    else {

                        $(menuItem).css("font-weight", "bold");
                    }
                    if (menuItem.hasClass("current")) {

                        $(menuItem).css("font-weight", "bold");
                    }
                }





            }
        });


    });
    //$("#ctl00_hAzienda").mouseover(function() { $("#ctl00_hAzienda").css("font-weight", "bold"); });
});

/*funzione che riceve in ingresso il nome del selector da attivare e disattiva tutti gli altri*/

/*--------------------------------------------------
SELECT MENU ON SMALL DEVICES
---------------------------------------------------*/
jQuery(document).ready(function($) {
    var $menu_select = $("<select />");
    $("<option />", { "selected": "selected", "value": "", "text": "Menu" }).appendTo($menu_select);
    $menu_select.appendTo("#primary-menu");

    $("#primary-menu ul li a").each(function() {
        var menu_url = $(this).attr("href");
        var menu_text = $(this).text();

        if ($(this).parents("li").length == 2) { menu_text = '- ' + menu_text; }
        if ($(this).parents("li").length == 3) { menu_text = "-- " + menu_text; }
        if ($(this).parents("li").length > 3) { menu_text = "--- " + menu_text; }
        $("<option />", { "value": menu_url, "text": menu_text }).appendTo($menu_select)
    })

    field_id = "#primary-menu select";
    $(field_id).change(function() {
        value = $(this).attr('value');
        window.location = value;
        //go		
    });
})

/*--------------------------------------------------
BACK TO TOP
---------------------------------------------------*/
jQuery(document).ready(function($) {
    $("#back-top").hide();

    $(function() {
        $(window).scroll(function() {
            if ($(this).scrollTop() > 100) {
                $('#back-top').fadeIn();
            } else {
                $('#back-top').fadeOut();
            }
        });

        $('#back-top a').click(function() {
            $('body,html').animate({
                scrollTop: 0
            }, 800);
            return false;
        });
    });
});

/*--------------------------------------------------
CUSTOM MODIFICATIONS
---------------------------------------------------*/
jQuery(document).ready(function($) {
    var win_width = $(window).width();
    if (win_width > 767) {
        var static_content_wrapper_top_margin = $("#header-wrapper").outerHeight();
        $("#content-wrapper").css("margin-top", static_content_wrapper_top_margin + "px");
    }
    else {
        $("#content-wrapper").css("margin-top", "0px");
    }
    $(window).resize(function() {
        win_width = $(window).width();
        if (win_width > 767) {
            var static_content_wrapper_top_margin = $("#header-wrapper").outerHeight();
            $("#content-wrapper").css("margin-top", static_content_wrapper_top_margin + "px");
        }
        else {
            $("#content-wrapper").css("margin-top", "0px");
        }
    });
});

/*--------------------------------------------------
HIDDEN FOOTER CONTENT ADDITIONAL CODE
---------------------------------------------------*/
jQuery(document).ready(function($) {
    $("a.trigger-footer").click(function() {
        if ($("a.trigger-footer").html() == "View more stuff") {
            $("a.trigger-footer").html("Modulo Prenotazioni");
        }
        else {
            $("a.trigger-footer").html("Chiudi Prenotazioni");
        }
        var top_h = parseInt($(".footer").outerHeight() + 0);

        $(".footer-hidden").css("bottom", top_h)

        $(".footer-hidden").slideToggle("fast");
        $(this).toggleClass("active");

        return false;
    });
});



jQuery(document).ready(function($) {
    $("a.trigger-header").click(function() {
        if ($("a.trigger-header").html() == "View more stuff") {
            $("a.trigger-header").html("Modulo Prenotazioni");
        }
        else {
            $("a.trigger-header").html("Chiudi Prenotazioni");
        }
        var top_h = parseInt($("#header-wrapper").outerHeight());

        $(".footer-hidden").css("top", top_h)

        $(".footer-hidden").slideToggle("fast");
        $(".footer-hidden").css("position", "fixed");
        $(".footer-hidden").css("z-index", "100");
        $(this).toggleClass("active");
        return false;
    });
});


/*--------------------------------------------------
DUPLICATE H3 & H4 IN PORTFOLIO
---------------------------------------------------*/
$(window).load(function() {
    $(".item-info").each(function(i) {
        $(this).next().prepend($(this).html())
    });
});

/*--------------------------------------------------
TOGGLE STYLE
---------------------------------------------------*/
jQuery(document).ready(function($) {
    $(".toggle-container").hide();
    $(".trigger").toggle(function() {
        $(this).addClass("active");
    }, function() {
        $(this).removeClass("active");
    });
    $(".trigger").click(function() {
        $(this).next(".toggle-container").slideToggle();
    });
});

/*--------------------------------------------------
ACCORDION
---------------------------------------------------*/
jQuery(document).ready(function($) {
    $('.trigger-button').click(function() {
        $(".trigger-button").removeClass("active")
        $('.accordion').slideUp('normal');
        if ($(this).next().is(':hidden') == true) {
            $(this).next().slideDown('normal');
            $(this).addClass("active");
        }
    });
    $('.accordion').hide();
});

/*--------------------------------------------------
TABS JAVASCRIPT
---------------------------------------------------*/
jQuery(document).ready(function($) {
    $(".tab-content").hide();
    $("ul.tabs li:first").addClass("active").show();
    $(".tab-content:first").show();

    $("ul.tabs li").click(function() {
        $("ul.tabs li").removeClass("active");
        $(this).addClass("active");
        $(".tab-content").hide();
        var activeTab = $(this).find("a").attr("href");
        $(activeTab).fadeIn();
        return false;
    });
});

/*--------------------------------------------------
SLIDING GRAPH
---------------------------------------------------*/
jQuery(document).ready(function($) {
    function isScrolledIntoView(id) {

        var elem = "#" + id;
        var docViewTop = $(window).scrollTop();
        var docViewBottom = docViewTop + $(window).height();

        if ($(elem).length > 0) {
            var elemTop = $(elem).offset().top;
            var elemBottom = elemTop + $(elem).height();
        }

        return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom)
		  && (elemBottom <= docViewBottom) && (elemTop >= docViewTop));
    }
    function sliding_horizontal_graph(id, speed) {
        $("#" + id + " li span").each(function(i) {
            var j = i + 1;
            var cur_li = $("#" + id + " li:nth-child(" + j + ") span");
            var w = cur_li.attr("class");
            cur_li.animate({ width: w + "%" }, speed);
        })
    }
    function graph_init(id, speed) {
        $(window).scroll(function() {
            if (isScrolledIntoView(id)) {
                sliding_horizontal_graph(id, speed);
            }
            else {
            }
        });
        if (isScrolledIntoView(id)) {
            sliding_horizontal_graph(id, speed);
        }
    }

    graph_init("example-1", 1000);
    graph_init("example-2", 1000);

});

/*--------------------------------------------------
ARCHIVE PAGE TABS
---------------------------------------------------*/
jQuery(document).ready(function($) {


    //$('.archive-list div:visible').slideUp();


    $('.chiudi').click(function() {
        $('.archive-list div:visible').slideUp();
        $('#multi').css("display", "none");
        return false;
    })


    $('#multi').css("display", "none");

    $('.archive-list > div').slideUp();
    $('#archive-nav li a').click(function() {
        $('#multi').css("display", "block");
        var li_ord = $(this).parent().prevAll().length;
        var li_ord_plus = li_ord + 1;
        if ($('.archive-list div:nth-child(' + li_ord_plus + ')').css("display") == "none") {
            $('.archive-list div:visible').slideUp();
            $('.archive-list div:nth-child(' + li_ord_plus + ')').slideDown();


        }
        else {

            // nudd
        }
        return false;
    })

});
/*--------------------------------------------------
IFRAME HEIGHT SCRIPT
---------------------------------------------------*/
jQuery(document).ready(function($) {
    var header_height = $("#header-wrapper").outerHeight();
    var window_height = $("html, body").height();
    var iframe_height = window_height - header_height;
    $(".fullwidth iframe").css("height", iframe_height + "px");

    $(window).resize(function() {
        header_height = $("#header-wrapper").outerHeight();
        window_height = $("html, body").height();
        iframe_height = window_height - header_height;
        $(".fullwidth iframe").css("height", iframe_height + "px");
    })

});

/*--------------------------------------------------
GALLERY SCRIPT AUTO WIDTH
---------------------------------------------------*/
jQuery(document).ready(function($) {
    var window_width = $("html, body").width();
    if (window_width >= 1820) num_columns = 6;
    if (window_width < 1820) num_columns = 6;
    if (window_width < 1560) num_columns = 5;
    if (window_width < 1300) num_columns = 4;
    if (window_width < 1040) num_columns = 3;
    if (window_width < 780) num_columns = 2;
    if (window_width < 480) num_columns = 1;
    var dl_width = parseInt(window_width / num_columns);
    $("dl.gallery-item").css("width", dl_width + "px");

    $(window).resize(function() {
        var window_width = $("html, body").width();
        if (window_width >= 1820) num_columns = 6;
        if (window_width < 1820) num_columns = 6;
        if (window_width < 1560) num_columns = 5;
        if (window_width < 1300) num_columns = 4;
        if (window_width < 1040) num_columns = 3;
        if (window_width < 780) num_columns = 2;
        if (window_width < 480) num_columns = 1;
        var dl_width = parseInt(window_width / num_columns);
        $("dl.gallery-item").css("width", dl_width + "px");
    })

});



/*--------------------------------------------------
GALLERY SCROLL
---------------------------------------------------*/
jQuery(document).ready(function($) {

    var url = document.location.href;
    //alert(url);

    if (url.indexOf('#') > -1) {
        var explode = url.split('#');
        var targetOffset = jQuery('div#' + explode[1]).offset().top;
        var altezza = $("#struttura-3").height();
        $('html,body').animate({ scrollTop: targetOffset - 125 }, { duration: 800, queue: false });


    }


    $('.nav-azienda-1').click(function() {
        $('html, body').animate({
            scrollTop: $("#storia").offset().top - 125
        }, 800);
    });


    $('.nav-azienda-2').click(function() {

        $('html, body').animate({
            scrollTop: $("#oggi").offset().top - 125
        }, 800);
    });

    $('.nav-azienda-3').click(function() {
        $('html, body').animate({
            scrollTop: $("#filosofia").offset().top - 125
        }, 800);
    });

    $('.nav-azienda-4').click(function() {
        $('html, body').animate({
            scrollTop: $("#mission").offset().top - 125
        }, 800);
    });

    $('.nav-azienda-5').click(function() {
        $('html, body').animate({
            scrollTop: $("#metodo").offset().top - 125
        }, 800);
    });
    $('.nav-azienda-6').click(function() {
        $('html, body').animate({
            scrollTop: $("#personale").offset().top - 125
        }, 800);
    });



    /* section strutture*/


    $('.nav-struttura-1').click(function() {

        $('html, body').animate({
            scrollTop: 0
        }, 800);

    });

    $('.nav-struttura-2').click(function() {

        $('html, body').animate({
            scrollTop: $("#struttura-2").offset().top - 125
        }, 800, false);

    });

    $('.nav-struttura-3').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-3").offset().top - 125
        }, 800);
    });


    $('.nav-struttura-4').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-4").offset().top - 125
        }, 800);
    });


    $('.nav-struttura-5').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-5").offset().top - 125
        }, 800);
    });
    $('.nav-struttura-6').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-6").offset().top - 125
        }, 800);
    });
    $('.nav-struttura-7').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-7").offset().top - 125
        }, 800);
    });
    $('.nav-struttura-8').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-8").offset().top - 125
        }, 800);
    });

    $('.nav-struttura-9').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-9").offset().top - 125
        }, 800);
    });

    $('.nav-struttura-10').click(function() {
        $('html, body').animate({
            scrollTop: $("#struttura-10").offset().top - 125
        }, 800);
    });

    /* sezioni formazione*/

    $('.nav-formazione-1').click(function() {

        $('html, body').animate({
            scrollTop: $("#formazione-1").offset().top - 125
        }, 800);
    });


    $('.nav-formazione-2').click(function() {
        $('html, body').animate({
            scrollTop: $("#formazione-2").offset().top - 125
        }, 800);

    });

    $('.nav-formazione-3').click(function() {
        $('html, body').animate({
            scrollTop: $("#formazione-3").offset().top - 125
        }, 800);
    });

    $('.nav-formazione-4').click(function() {
        $('html, body').animate({
            scrollTop: $("#formazione-4").offset().top - 125
        }, 800);
    });

    $('.nav-formazione-5').click(function() {
        $('html, body').animate({
            scrollTop: $("#formazione-5").offset().top - 125
        }, 800);
    });



    /*riab*/

    /* sezioni formazione*/

    $('.nav-riab-1').click(function() {

        $('html, body').animate({
            scrollTop: $("#riab-1").offset().top - 125
        }, 800);
    });



    $('.nav-riab-2').click(function() {
        //alert("formazione-2 clicked");
        $('html, body').animate({
            scrollTop: $("#riab-2").offset().top - 125
        }, 800);
    });

    $('.nav-riab-3').click(function() {
        $('html, body').animate({
            scrollTop: $("#riab-3").offset().top - 125
        }, 800);
    });

    $('.nav-riab-4').click(function() {
        $('html, body').animate({
            scrollTop: $("#riab-4").offset().top - 125
        }, 800);
    });

    $('.nav-riab-5').click(function() {
        $('html, body').animate({
            scrollTop: $("#riab-5").offset().top - 125
        }, 800);
    });

    $('.nav-riab-6').click(function() {
        $('html, body').animate({
            scrollTop: $("#riab-6").offset().top - 125
        }, 800);
    });

    $('.nav-riab-7').click(function () {
        $('html, body').animate({
            scrollTop: $("#riab-7").offset().top - 125
        }, 800);
    });

    $('.nav-riab-8').click(function () {
        $('html, body').animate({
            scrollTop: $("#riab-8").offset().top - 125
        }, 800);
    });

});