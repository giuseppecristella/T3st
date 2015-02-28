jQuery.noConflict();
jQuery(document).ready(function() {
    function get_substr(str, full_class) { var arr_class = new Array(); if (full_class) { if (full_class.indexOf(str) !== -1) { arr_class = full_class.split(' '); if (arr_class) { for (var arr_i in arr_class) { if (arr_class[arr_i].indexOf(str) !== -1) { cat_class = arr_class[arr_i]; return cat_class.slice(str.length); } } } } } }
    var url = document.location.href;
    if (url.indexOf('#') > -1) {
        explode = url.split('#');
        var targetOffset = jQuery('div#' + explode[1]).offset().top;
        jQuery('html,body').animate({ scrollTop: targetOffset - 45 }, { duration: 800, queue: false });
    }
    jQuery('div#nl input[type="submit"]').click(function(e) {
        if (jQuery('div#nl input[name="email"]').val() == 'scrivi qui il tuo indirizzo e-mail') {
            e.preventDefault();
            return false;
        }
        else if (jQuery.trim(jQuery('input[name="email"]').val()) == '') {
            e.preventDefault();
            jQuery('input[name="email"]').addClass('errore');
        }
        else jQuery('input[name="email"]').removeClass('errore');
        var espressione = new RegExp("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+[\.]([a-z0-9-]+)*([a-z]{2,3})$");
        if (!espressione.test(jQuery.trim(jQuery('input[name="email"]').val()))) {
            e.preventDefault();
            jQuery('input[name="email"]').addClass('errore');
        }
        else jQuery('input[name="email"]').removeClass('errore');
    });
    if (jQuery('div#nl div.esito_invio span').hasClass('ok')) {
        alert("Grazie per aver effettuato l'iscrizione alla nostra newsletter!");
        jQuery('div#nl div.esito_invio').remove();
    }
    if (jQuery('div#nl div.esito_invio span').hasClass('err')) {
        alert("La tua e-mail è stata gi�  inserita");
        jQuery('div#nl div.esito_invio').remove();
    }
    if (jQuery('body').hasClass('home') || jQuery('body').hasClass('nomenujs')) {
        jQuery('div#menu a[href^="#"]').click(function(e) {
            var iddiv = jQuery(this).attr('id');
            if (iddiv != 'home') {
                e.preventDefault();
                var targetOffset = jQuery('div#' + iddiv).offset().top;
                jQuery('html,body').animate({ scrollTop: targetOffset - 45 }, { duration: 800, queue: false });
                return false;
            }
        });
    }
    else {
        jQuery('div#menu a').click(function(e) {
            var iddiv = jQuery(this).attr('id');
            if (iddiv != 'home' && jQuery(this).attr('href') == '#') {
                e.preventDefault();
                var targetOffset = jQuery('div#' + iddiv).offset().top;
                jQuery('html,body').animate({ scrollTop: targetOffset }, 1000);
                return false;
            }
        });
    }
    function parseTwitterDate(tdate) {
        var system_date = new Date(Date.parse(tdate));
        var user_date = new Date();
        if (K.ie) {
            system_date = Date.parse(tdate.replace(/( \+)/, ' UTC$1'))
        }
        var diff = Math.floor((user_date - system_date) / 1000);
        if (diff <= 1) { return "proprio ora"; }
        if (diff < 20) { return diff + " secondi fa"; }
        /*if (diff < 40) {return "half a minute ago";}
        if (diff < 60) {return "less than a minute ago";}*/
        if (diff <= 90) { return "1 minuto fa"; }
        if (diff <= 3540) { return Math.round(diff / 60) + " minuti fa"; }
        if (diff <= 5400) { return "1 ora fa"; }
        if (diff <= 86400) { return Math.round(diff / 3600) + " ore fa"; }
        if (diff <= 129600) { return "1 giorno fa"; }
        if (diff < 604800) { return Math.round(diff / 86400) + " giorni fa"; }
        if (diff <= 777600) { return "1 settimana fa"; }
        if (diff > 777600) { return Math.round(diff / (86400 * 7)) + " settimane fa"; }
        return "il " + system_date;
    }
    var K = function() {
        var a = navigator.userAgent;
        return {
            ie: a.match(/MSIE\s([^;]*)/)
        }
    } ();
    function getTweets() {
        jQuery.getJSON(
			'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=NichiVendola&count=3&callback=?',
			{},
			showTweets,
			'jsonp'
		);
    }
    function showTweets(tweets) {
        var str = '';
        var i = 0;
        str += '<ul>';
        jQuery.each(tweets, function(index, value) {
            if (i == 3) return;
            str += '<li>';
            str += '<span><strong>' + parseTwitterDate(value.created_at) + '</strong></span>';
            testo = '';
            var array_text = value.text.split(" ");
            for (var i in array_text) {
                if (get_substr('http://', array_text[i]) || get_substr('https://', array_text[i])) {
                    var link_incorporato = get_substr('http://', array_text[i]);
                    testo += array_text[i].replace('http://' + link_incorporato, '<a href="http://' + link_incorporato + '" target="_blank">http://' + link_incorporato + '</a>') + ' ';
                }
                else testo += array_text[i] + ' ';
            }
            str += '<div class="contenuto">' + testo + '</div>';
            str += '<div class="interazioni_tweet"><a class="tweet_risposta" target="blank" href="https://twitter.com/intent/tweet?in_reply_to=' + value.id_str + '&tw_p=tweetembed&source=tweetembed">Risposta</a> <a class="tweet_retweet" target="blank" href="https://twitter.com/intent/retweet?tweet_id=' + value.id_str + '&tw_p=tweetembed&source=tweetembed">Retweet</a> <a class="tweet_preferiti" target="blank" href="https://twitter.com/intent/favorite?tweet_id=' + value.id_str + '&tw_p=tweetembed&source=tweetembed">Preferiti</a></div>';
            str += '</li>';
            i++;
        });
        str += '</ul>';
        jQuery('#social #tw h2').after(str);
    }
    getTweets();

    jQuery('div.blocco_colore div.apri').click(function(e) {
        if (!jQuery(this).hasClass('attivo')) {
            jQuery('div.blocco_colore div.apri.attivo').removeClass('attivo');
            jQuery(this).addClass('attivo');
            jQuery('div.blocco_colore .infocol').fadeOut(250);
            jQuery(this).parent().find('.infocol').fadeIn(250);
        } else {
            jQuery(this).parent().find('.infocol').fadeOut(250);
        }
    });

    if (jQuery('body').hasClass('home')) {
        jQuery('div#ercolano a.video').click(function(e) {
            e.preventDefault();
            if (jQuery('div#ercolano div.video iframe').length) {
                jQuery('div#ercolano div.video').html('');
                jQuery('div#ercolano div.video').hide();
                jQuery(this).removeClass('attivo');
            }
            else {
                jQuery(this).addClass('attivo');
                jQuery('div#ercolano div.video').show();
                jQuery('div#ercolano div.video').html('<iframe width="450" height="350" src="http://www.streamago.tv/iframe/24422/web-2012-10-06-18-52-08.17912.html" frameborder="0" allowfullscreen></iframe>');
            }
        })
    }

    if (jQuery('div').hasClass('singolomedia')) {
        jQuery('div.gallery a').live('click', function(e) {
            e.preventDefault();
            if (jQuery(this).attr('href').indexOf('?idvideo=') > -1) {
                var idvideo = get_substr('?idvideo=', jQuery(this).attr('href'));
                jQuery(this).parent().parent().parent().parent().parent().find('div.veromedia iframe').attr('src', 'http://www.youtube.com/embed/' + idvideo + '?rel=0&showinfo=0&autoplay=1');
                jQuery(this).parent().parent().parent().parent().parent().find('div.descrizione a.guarda_yt').attr('href', 'http://www.youtube.com/watch?v=' + idvideo);
                jQuery(this).parent().parent().parent().parent().parent().find('div.descrizione h3').text(jQuery(this).attr('title'));
                jQuery(this).parent().parent().parent().parent().parent().find('div.descrizione span.data_media').text(jQuery(this).attr('data-dataora'));
                jQuery(this).parent().parent().parent().parent().parent().find('div.descrizione div.contenuto').text(jQuery(this).attr('data-contenuto'));
            } else {
                jQuery('div.veromedia img').attr('src', jQuery(this).attr('href'));
                jQuery('div#album div.descrizione h3').text(jQuery(this).attr('title'));
                jQuery(this).parent().parent().parent().parent().parent().find('div.descrizione span.data_media').text(jQuery(this).attr('data-dataora'));
            }
        });
        jQuery.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?id=44747446@N08&lang=it-it&format=json&jsoncallback=?",
        function(data) {
            // console.log(data);
            jQuery.each(data.items, function(i, item) {
                var quadrato = (item.media.m).replace("_m.jpg", "_z.jpg");
                var anno = item.published.substr(0, 4);
                var mese = item.published.substr(5, 2);
                if (mese == 10) mese = 'ottobre';
                if (mese == 11) mese = 'novembre';
                if (mese == 12) mese = 'dicembre';
                var giorno = item.published.substr(8, 2);
                var ora = item.published.substr(11, 5);
                if (i == 0) {
                    jQuery('div#album div.descrizione span.data_media').html(giorno + ' ' + mese + ' ' + anno + ', ' + ora);
                    jQuery('div#album div#foto').html('<img src="' + quadrato + '" width="618" alt="' + item.title + '" />');
                    jQuery('div#album div.descrizione h3').text(item.title);
                }
                stringahtml = '<li><a href="' + quadrato + '" title="' + item.title + '" data-dataora="' + giorno + ' ' + mese + ' ' + anno + ', ' + ora + '"><img src="' + quadrato + '" width="138" alt="' + item.title + '" /></a></li>';
                jQuery('div#album div.gallery ul').append(stringahtml);
                //if ( i == 4 ) return false;
            });
            //setTimeout('album_slide();', 1000);
        });
    }

    if (jQuery('#media #multima').length) {
        /*
        jQuery.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?id=44747446@N08&lang=it-it&format=json&jsoncallback=?",
        function(data){
        // console.log(data);
        jQuery.each(data.items, function(i,item){
        var quadrato = (item.media.m).replace("_m.jpg", ".jpg");
        if (i==0) {
        //jQuery('#media #multima div.foto').html('<img src="'+quadrato+'" width="618" alt="'+item.title+'" />');
        jQuery('#media #multima div.foto').css('background-image', 'url('+quadrato+')');
        jQuery('#media #multima h2').text(item.title);
        }
        //stringahtml = '<li><a href="'+quadrato+'" title="'+item.title+'"><img src="'+quadrato+'" width="138" alt="'+item.title+'" /></a></li>';
        //jQuery('div#album div.gallery ul').append(stringahtml);
        if ( i == 1 ) return false;
        });
        // setTimeout('album_slide();', 1000);
        });
        */

        jQuery.getJSON('http://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=c8e40c8ac465c1bf90b917232b7fe459&user_id=44747446@N08&format=json&jsoncallback=?',
		function(data) {
		    jQuery.each(data.photosets.photoset, function(i, photoset) {
		        jQuery('#media #multima h2').text(photoset.title._content);
		        jQuery.getJSON('http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=c8e40c8ac465c1bf90b917232b7fe459&photoset_id=' + photoset.id + '&user_id=44747446@N08&privacy_filter=1&per_page=2&media=photos&page=2&format=json&jsoncallback=?',
				function(data) {
				    jQuery.each(data.photoset.photo, function(i, photo) {
				        //var test = 'url(http://farm'+photo.farm+'.staticflickr.com/'+photo.server+'/'+photo.id+'_'+photo.secret+'.jpg)';
				        //console.log(test);
				        //jQuery('#media #multima div.foto').css('background-image', test);
				        jQuery.getJSON('http://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=c8e40c8ac465c1bf90b917232b7fe459&photo_id=' + photo.id + '&format=json&jsoncallback=?',
						function(data) {
						    var test = 'url(http://farm' + data.photo.farm + '.staticflickr.com/' + data.photo.server + '/' + data.photo.id + '_' + data.photo.secret + '_n.' + data.photo.originalformat + ')';
						    jQuery('#media #multima div.foto').css('background-image', test);
						});
				    });
				});
		        if (i == 0) return false;
		    });
		});
    }

    /*if (jQuery('body').hasClass('nichiboard')) {
    jQuery('div.copri_input input[type="text"]').each(function (){
    jQuery(this).keyup(function(event) {
    console.log(event);
    // �  è é ì ò ù 
    if (event.charCode==222 
    || event.keyCode==222 
    || event.which==222 
    || event.charCode==186 
    || event.keyCode==186 
    || event.which==186
    || event.charCode==16 
    || event.keyCode==16 
    || event.which==16
    || event.charCode==221 
    || event.keyCode==221 
    || event.which==221
    || event.charCode==192 
    || event.keyCode==192 
    || event.which==192
    || event.charCode==191 
    || event.keyCode==191
    || event.which==191) {
    event.preventDefault();
    array_lettere = jQuery(this).val().split('');
    var maxlength = jQuery(this).attr('maxlength');
    maxlengthpiu = parseInt(maxlength) + 1;
    jQuery(this).attr('maxlength',maxlengthpiu);
    console.log(array_lettere);
    stringa = '';
    jQuery.each(array_lettere,function(index,value) {
    if (value=='� ') stringa += "a'";
    else if (value=='è') stringa += "e'";
    else if (value=='é') stringa += "e'";
    else if (value=='ì') stringa += "i'";
    else if (value=='ò') stringa += "o'";
    else if (value=='ù') stringa += "u'";
    else stringa += value;
    });
    jQuery(this).val(stringa);
    }
					
					
				
    });
    }); 
    }*/
    // Media scorrimenti

    jQuery('div.gallery div.prev').click(function(e) {
        if (!jQuery(this).hasClass('prev_off')) {
            jQuery(this).parent().find('div.galleria ul li').last().insertBefore(jQuery(this).parent().find('div.galleria u	l li').first());
        }
    });
    jQuery('div.gallery div.next').click(function(e) {
        if (!jQuery(this).hasClass('next_off')) {
            jQuery(this).parent().find('div.galleria ul li').first().insertAfter(jQuery(this).parent().find('div.galleria ul li').last());
        }
    });

    if (jQuery('#videolettere').length) {
        if (!jQuery('div#videolettere div.galleria ul li.vl_6').length) {
            jQuery('div#videolettere div.prev').addClass('prev_off').removeClass('prev');
            jQuery('div#videolettere div.next').addClass('next_off').removeClass('next');
        }
    }


    // Media -  Album
    //window.album_slide = function() {
    //	if (jQuery('#album').length)
    //	{
    //		jQuery('#album .gallery ul').css('height', jQuery('#album .gallery ul li').height()+'px');
    //		jQuery('#album .gallery').prepend('<div class="prev" style="position:absolute;margin-left:-15px;margin-top:36px;cursor: pointer;cursor: hand;"><div class="arrow1" style="position:absolute;width:0px;height:0px;border-bottom:15px solid transparent;border-top:15px solid transparent;border-right:8px solid #2f2f2f;font-size:0px;line-height:0px;"></div><div class="arrow2" style="position:absolute;margin-top:6px;margin-left:5px;width:0px;height:0px;border-bottom:10px solid transparent;border-top:10px solid transparent;border-right:5px solid #6CA7C5;font-size:0px;line-height:0px;"></div></div><div class="next" style="position:absolute;margin-left:796px;margin-top:36px;cursor: pointer;cursor: hand;"><div class="arrow1" style="position:absolute;width:0px;height:0px;border-bottom:15px solid transparent;border-top:15px solid transparent;border-left:8px solid #2f2f2f;font-size:0px;line-height:0px;"></div><div class="arrow2" style="position:absolute;margin-top:6px;margin-left:-1px;width:0px;height:0px;border-bottom:10px solid transparent;border-top:10px solid transparent;border-left:5px solid #6CA7C5;font-size:0px;line-height:0px;"></div></div>');
    //		jQuery('#album .gallery ul').wrap('<div class="galleria" style="height:'+jQuery('#album .gallery ul li').height()+'px;width:'+((jQuery('#album .gallery ul li').width()+parseInt(jQuery('#album .gallery ul li').css('margin-right')))*5)+'px;overflow:hidden;"></div>');
    //		jQuery('#album .galleria').append('<div class="clearfix"></div>');
    //		//jQuery('#album .gallery ul').html(jQuery('#album .gallery ul').html()+jQuery('#album .gallery ul').html());	// Debug
    //		jQuery('#album .gallery ul').css('width', (jQuery('#album .gallery ul li').length*(jQuery('#album .gallery ul li').width()+parseInt(jQuery('#album .gallery ul li').css('margin-right'))))+'px');
    //		jQuery('#album .gallery .next').click(function(e){
    //			if ((-1*parseInt(jQuery('#album .gallery ul').css('margin-left')))<((jQuery('#album .gallery ul').width()-((jQuery('#album .gallery ul li').width()+parseInt(jQuery('#album .gallery ul li').css('margin-right')))*5))))
    //			jQuery('#album .gallery ul').css('margin-left', (parseInt(jQuery('#album .gallery ul').css('margin-left'))-jQuery('#album .gallery ul li').width()-parseInt(jQuery('#album .gallery ul li').css('margin-right')))+'px');
    //			jQuery('#album .gallery .prev').show();
    //			if ((-1*parseInt(jQuery('#album .gallery ul').css('margin-left')))==((jQuery('#album .gallery ul').width()-((jQuery('#album .gallery ul li').width()+parseInt(jQuery('#album .gallery ul li').css('margin-right')))*5))))
    //			jQuery('#album .gallery .next').hide();
    //		});
    //		jQuery('#album .gallery .prev').click(function(e){
    //			if (parseInt(jQuery('#album .gallery ul').css('margin-left'))<0)
    //			jQuery('#album .gallery ul').css('margin-left', (parseInt(jQuery('#album .gallery ul').css('margin-left'))+jQuery('#album .gallery ul li').width()+parseInt(jQuery('#album .gallery ul li').css('margin-right')))+'px');
    //			jQuery('#album .gallery .next').show();
    //			if (parseInt(jQuery('#album .gallery ul').css('margin-left'))==0)
    //			jQuery('#album .gallery .prev').hide();
    //		});
    //		jQuery('#album .gallery .prev').hide();
    //		if (jQuery('#album .gallery ul li').length<=5) jQuery('#album .gallery .next').hide();
    //	}
    //}
    //	// Fine - Media - Album
    //	// Media -  Video lettere
    //
    //	if (jQuery('#videolettere').length)
    //	{
    //		jQuery('#videolettere .gallery ul').css('height', jQuery('#videolettere .gallery ul li').height()+'px');
    //		jQuery('#videolettere .gallery').prepend('<div class="prev" style="position:absolute;margin-left:-15px;margin-top:36px;cursor: pointer;cursor: hand;"><div class="arrow1" style="position:absolute;width:0px;height:0px;border-bottom:15px solid transparent;border-top:15px solid transparent;border-right:8px solid #2f2f2f;font-size:0px;line-height:0px;"></div><div class="arrow2" style="position:absolute;margin-top:6px;margin-left:5px;width:0px;height:0px;border-bottom:10px solid transparent;border-top:10px solid transparent;border-right:5px solid #6CA7C5;font-size:0px;line-height:0px;"></div></div><div class="next" style="position:absolute;margin-left:796px;margin-top:36px;cursor: pointer;cursor: hand;"><div class="arrow1" style="position:absolute;width:0px;height:0px;border-bottom:15px solid transparent;border-top:15px solid transparent;border-left:8px solid #2f2f2f;font-size:0px;line-height:0px;"></div><div class="arrow2" style="position:absolute;margin-top:6px;margin-left:-1px;width:0px;height:0px;border-bottom:10px solid transparent;border-top:10px solid transparent;border-left:5px solid #6CA7C5;font-size:0px;line-height:0px;"></div></div>');
    //		jQuery('#videolettere .gallery ul').wrap('<div class="galleria" style="height:'+jQuery('#videolettere .gallery ul li').height()+'px;width:'+((jQuery('#videolettere .gallery ul li').width()+parseInt(jQuery('#videolettere .gallery ul li').css('margin-right')))*5)+'px;overflow:hidden;"></div>');
    //		//jQuery('#videolettere .gallery ul').html(jQuery('#videolettere .gallery ul').html()+jQuery('#videolettere .gallery ul').html()+jQuery('#videolettere .gallery ul').html());	// Debug
    //		jQuery('#videolettere .gallery ul').css('width', (jQuery('#videolettere .gallery ul li').length*(jQuery('#videolettere .gallery ul li').width()+parseInt(jQuery('#videolettere .gallery ul li').css('margin-right'))))+'px');
    //		jQuery('#videolettere .gallery .next').click(function(e){
    //			if ((-1*parseInt(jQuery('#videolettere .gallery ul').css('margin-left')))<((jQuery('#videolettere .gallery ul').width()-((jQuery('#videolettere .gallery ul li').width()+parseInt(jQuery('#videolettere .gallery ul li').css('margin-right')))*5))))
    //			jQuery('#videolettere .gallery ul').css('margin-left', (parseInt(jQuery('#videolettere .gallery ul').css('margin-left'))-jQuery('#videolettere .gallery ul li').width()-parseInt(jQuery('#videolettere .gallery ul li').css('margin-right')))+'px');
    //			jQuery('#videolettere .gallery .prev').show();
    //			if ((-1*parseInt(jQuery('#videolettere .gallery ul').css('margin-left')))==((jQuery('#videolettere .gallery ul').width()-((jQuery('#videolettere .gallery ul li').width()+parseInt(jQuery('#videolettere .gallery ul li').css('margin-right')))*5))))
    //			jQuery('#videolettere .gallery .next').hide();
    //		});
    //		jQuery('#videolettere .gallery .prev').click(function(e){
    //			if (parseInt(jQuery('#videolettere .gallery ul').css('margin-left'))<0)
    //			jQuery('#videolettere .gallery ul').css('margin-left', (parseInt(jQuery('#videolettere .gallery ul').css('margin-left'))+jQuery('#videolettere .gallery ul li').width()+parseInt(jQuery('#videolettere .gallery ul li').css('margin-right')))+'px');
    //			jQuery('#videolettere .gallery .next').show();
    //			if (parseInt(jQuery('#videolettere .gallery ul').css('margin-left'))==0)
    //			jQuery('#videolettere .gallery .prev').hide();
    //		});
    //		jQuery('#videolettere .gallery .prev').hide();
    //		if (jQuery('#videolettere .gallery ul li').length<=5) jQuery('#videolettere .gallery .next').hide();
    //	}
    //	// Fine - Media - Video lettere

    jQuery('div#menu a[href*=#]').click(function(e) {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = jQuery(this.hash);
            target = target.length && target || jQuery('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                e.preventDefault();
                var targetOffset = target.offset().top;
                jQuery('html,body').animate({ scrollTop: targetOffset - 45 }, { duration: 800, queue: false });
            }
        };
    });

    if (jQuery('div.ricerca').length) {
        if (!self.getRequestParameter) {
            function getRequestParameter(param) {
                var q = document.location.search || document.location.hash;
                if (q) {
                    var pairs = q.substring(1).split("&");
                    for (var i = 0; i < pairs.length; i++) {
                        if (pairs[i].substring(0, pairs[i].indexOf("=")) == param) {
                            return pairs[i].substring((pairs[i].indexOf("=") + 1));
                        }
                    }
                }
                return "";
            }
        }
        var testo_cerca;
        //testo_cerca = ((window.location.toString().indexOf('/en/')!==-1||getRequestParameter('lang')=='en')?'Site search':'Cerca nel sito');
        testo_cerca = 'inserisci qui una parola';
        // form#searchform input#s
        jQuery('div.ricerca form input[name="search"]').ready(function() {
            var tthis = 'div.ricerca form input[name="search"]';
            if (!jQuery(tthis).val()) jQuery(tthis).val(testo_cerca);
        });
        jQuery('div.ricerca form input[name="search"]').focusout(function() {
            if (!jQuery(this).val()) jQuery(this).val(testo_cerca);
        });
        jQuery('div.ricerca form input[name="search"]').focusin(function() {
            if (jQuery(this).val() == testo_cerca) jQuery(this).val('');
        });
        // form#searchform input#searchformsubmit
        jQuery('div.ricerca form input[type="submit"]').click(function(e) {
            var tthis = 'div.ricerca form input[name="search"]';
            if (jQuery(tthis).val() == testo_cerca) { /*jQuery(tthis).val('');*/e.preventDefault(); alert(((getRequestParameter('lang') == 'en') ? 'Insert key for start your search.' : 'Inserire una parola per eseguire la ricerca.')); } // 'Inserire una o piu\' parole per eseguire la ricerca.'
        });
        if (jQuery('div.ricerca').length)
            jQuery('div.singolo_post').highlight(jQuery('div.h2_ricerca span:first').text());
        if (jQuery('div#archivio_blog').length) {
            jQuery('div#archivio_blog ul li.anno').prepend('<div class="arrow"></div>');
            jQuery('div#archivio_blog ul li.anno ul').slideUp(0, function() {
                jQuery(this).parent().find('div.arrow').addClass('arrow_down');
            });
            jQuery('div#archivio_blog ul li.anno div.arrow').click(function(e) {
                if (jQuery(this).hasClass('arrow_down'))
                    jQuery(this).parent().find('ul').slideDown('swing', function() {
                        jQuery(this).parent().find('div.arrow').removeClass('arrow_down');
                    });
                else
                    jQuery(this).parent().find('ul').slideUp('swing', function() {
                        jQuery(this).parent().find('div.arrow').addClass('arrow_down');
                    });
                //console.log('Click');
                /*jQuery(this).parent().find('ul').animate({"height": "toggle"}, { queue:false, duration:400 }, "swing", function(){
                console.log('Animate');
                /*
                jQuery(this).addClass('arrow_up');
                jQuery(this).css('border', '1px solid red');
                if (parseInt(jQuery(this).css('height')))
                jQuery(this).addClass('arrow_up');
                else
                jQuery(this).addClass('arrow_down');
                */
                /*jQuery('div#archivio_blog ul li.anno ul').each(function(){
                jQuery(this).attr('height');
                });*/
                /*console.log(now);
                console.log(fx);*/
                /*});*/
            });
        }
    }
    if (jQuery('body.programma').length) {
        if (!jQuery('div.articoli div.menu ul li.selected').length) jQuery('div.articoli div.menu ul li:first').addClass('selected');
        jQuery('div.articoli div.singolo_post').hide();
        jQuery('div.articoli div.singolo_post.post-' + get_substr('post-', jQuery('div.articoli div.menu ul li.selected').attr('class'))).show();
        jQuery('div.articoli div.menu ul li').click(function(e) {
            var pid;
            pid = get_substr('post-', jQuery(this).attr('class'));
            jQuery('div.articoli div.menu ul li').removeClass('selected');
            jQuery('div.articoli div.menu ul li.post-' + pid).addClass('selected');
            jQuery('div.articoli div.singolo_post').hide();
            jQuery('div.articoli div.singolo_post.post-' + pid).show();
        });
    }
});