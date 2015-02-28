



function mappa_piccola(var_lat, var_lng, var_zoom, var_marker, var_titolo) {
    var laterza = new google.maps.LatLng(var_lat, var_lng);
    var act_zoom = var_zoom;
    var myOptions = {
        scrollwheel: false,
        zoom: act_zoom,
        center: laterza,
        mapTypeControl: false,
        overviewMapControl: false,
        streetViewControl: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        zoomControl: true,
        zoomControlOptions: {
            style: google.maps.ZoomControlStyle.SMALL
        }
    }

    var map = new google.maps.Map(document.getElementById("mappa_piccola"), myOptions);
    overlay = new google.maps.OverlayView();

    var markerImg = new google.maps.MarkerImage(
		'/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/' + var_marker + '.png',
		null,
		null,
		new google.maps.Point(20, 48),
		new google.maps.Size(40, 48)
	);
    var markerShadow = new google.maps.MarkerImage(
		'/export/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/ombra_marker.png',
		null,
		null,
		new google.maps.Point(20, 8),
		new google.maps.Size(40, 16)
	);

    var markerUImg = new google.maps.MarkerImage(
		'/export/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/icona_pedone.png',
		null,
		null,
		new google.maps.Point(11, 20),
		new google.maps.Size(12, 20)
	);
    var markerUImgF = new google.maps.MarkerImage(
		'/export/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/freccia_pedone.png',
		null,
		null,
		new google.maps.Point(10, 32),
		new google.maps.Size(9, 11)
	);
    var markerUShadow = new google.maps.MarkerImage(
		'/export/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/ombra_pedone.png',
		null,
		null,
		new google.maps.Point(15, 4),
		new google.maps.Size(20, 8)
	);

    $('#mappa_piccola').gmap('getCurrentPosition', function (position, status) {
        if (status === 'OK') {
            var clientPosition = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            $('#mappa_piccola').gmap('addMarker', {
                'position': clientPosition,
                'bounds': true,
                'icon': markerUImgF,
                'animation': google.maps.Animation.BOUNCE
            });
            $('#mappa_piccola').gmap('addMarker', {
                'position': clientPosition,
                'bounds': true,
                'icon': markerUImg,
                'shadow': markerUShadow,
            });
        }
    });
    $('#mappa_piccola').gmap('addMarker', {
        'position': new google.maps.LatLng(var_lat, var_lng),
        'bounds': true,
        'icon': markerImg,
        'shadow': markerShadow,
    });
}

function initialize(var_lat_m, var_long_m, var_zoom, pagina, var_tipo) {
    var laterza;
    var str_posizione = 200;
    var controllers = true;
    //var clientPosition = google.maps.LatLng(43.716698, 10.399611); 
    var clientPosition = google.maps.LatLng(40.619132, 16.798954);

    if (var_tipo == "1") {
        var controllers = false;

        $('#mappa').gmap('getCurrentPosition', function (position, status) {
            if (status === 'OK') {
                clientPosition = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            }
        });
    }
    if (pagina != "1") {
        str_posizione = 150;
    }

    if (var_lat_m != "" && var_long_m != "") {
        laterza = new google.maps.LatLng(var_lat_m, var_long_m);
    } else {
        // per centrare la mappa impostare le coordinate del punto
        laterza = new google.maps.LatLng(40.591085, 17.118406);

    }
    var act_zoom = 30;
    if (var_zoom != "") {
        act_zoom = parseInt(var_zoom);
    }
    var myOptions = {
        scrollwheel: false,
        zoom: 10,
        center: laterza,
        scaleControl: controllers,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeControl: controllers,
        overviewMapControl: controllers,
        streetViewControl: controllers,
    }
    var map = new google.maps.Map(document.getElementById("mappa"), myOptions);
    overlay = new google.maps.OverlayView();
    overlay.setMap(map);
    overlay.draw = function () { }

    if (var_tipo == "1") {
        var markerUImg = new google.maps.MarkerImage(
			'/images/bandiera_it.png',
			null,
			null,
			new google.maps.Point(11, 20),
			new google.maps.Size(12, 20)
		);
        var markerUImgF = new google.maps.MarkerImage(
			'/images/bandiera_it.png',
			null,
			null,
			new google.maps.Point(10, 32),
			new google.maps.Size(9, 11)
		);
        var markerUShadow = new google.maps.MarkerImage(
			'/images/bandiera_it.png',
			null,
			null,
			new google.maps.Point(15, 4),
			new google.maps.Size(20, 8)
		);
        $('#mappa_piccola').gmap('addMarker', {
            'position': clientPosition,
            'bounds': true,
            'icon': markerUImgF,
            'animation': google.maps.Animation.BOUNCE
        });
        $('#mappa').gmap('addMarker', {
            'position': clientPosition,
            'bounds': true,
            'icon': markerUImg,
            'shadow': markerUShadow,
        });
    }

    var infoBubbleKML = new InfoBubble({
        shadowStyle: 1,
        padding: 5,
        backgroundColor: 'rgb(57,57,57)',
        borderRadius: 0,
        arrowSize: 10,
        borderWidth: 1,
        borderColor: '#00A9DE',
        arrowPosition: 0,
        disableAutoPan: true,
        arrowStyle: 2,
    });

    function layers2(xmlFile) {

        $.get(xmlFile, {}, function (xml) {
            $(xml).find('percorso').each(function () {
                var strKmlFile = $.trim($(this).find('kml_file').text());
                var strLink = $.trim($(this).find('link').text());
                var strImg = $.trim($(this).find('imgMappa').text());
                var strName = $.trim($(this).find('name').text());
                var strDescr = $.trim($(this).find('descr').text());



                //var kmlUrl = 'http://www.turismo.pisa.it' + strKmlFile + "?data=" + $.now();
                var kmlUrl = 'http://184.72.253.11' + strKmlFile + "?data=" + $.now();
                //var kmlUrl = 'http://localhost:52028/Osmairm/'+ strKmlFile + "?data=" + $.now();

                var ctaLayer = new google.maps.KmlLayer(kmlUrl, {
                    preserveViewport: true,
                    suppressInfoWindows: true,
                    map: map,
                });

                var infoStringKML = "<div class=\"info_itinerario\"><a href=\"" + strLink + "\">" + strImg + "</a><div class=\"testo\"><div class=\"titolo_info\"><a href=\"" + strLink + "\"><h3>" +
								strName + "</h3></a></div>" + strDescr + "</div><a href=\"" + strLink + "\" class=\"leggi\">leggilo tutto</a></div>";

                if (var_tipo != "1") {
                    google.maps.event.addListener(ctaLayer, 'click', function (kmlEvent) {
                        var str_latLng = kmlEvent.latLng;
                        infoBubbleKML["position"] = str_latLng;
                        infoBubbleKML["content"] = infoStringKML;
                        infoBubbleKML.open(map);
                        if (typeof infoBubble != 'undefined') {
                            infoBubble.close();
                        };
                        scrollPoint(str_latLng);
                    });
                }
            });
        });
    }

    function layers(kmlFile, link_itinerario, img_itinerario, titolo_itinerario, descrizione_itinerario) {
        var kmlUrl = 'http://www.turismo.pisa.it' + kmlFile + "?data=" + $.now();
        var ctaLayer = new google.maps.KmlLayer(kmlUrl, {
            preserveViewport: true,
            suppressInfoWindows: true,
            map: map,
        });

        var infoStringKML = "<div class=\"info_itinerario\"><a href=\"" + link_itinerario + "\">" + img_itinerario + "</a><div class=\"testo\"><div class=\"titolo_info\"><a href=\"" + link_itinerario + "\"><h3>" +
						titolo_itinerario + "</h3></a></div>" + descrizione_itinerario + "</div></div>";

        infoBubbleKML = new InfoBubble({
            content: infoStringKML,
            shadowStyle: 1,
            padding: 5,
            backgroundColor: 'rgb(57,57,57)',
            borderRadius: 0,
            arrowSize: 10,
            borderWidth: 1,
            borderColor: '#00A9DE',
            arrowPosition: 0,
            disableAutoPan: true,
            arrowStyle: 2
        });

        if (var_tipo != "1") {
            google.maps.event.addListener(ctaLayer, 'click', function (kmlEvent) {
                var str_latLng = kmlEvent.latLng;
                infoBubbleKML["position"] = str_latLng;
                infoBubbleKML.open(map);
                scrollPoint(str_latLng);
                if (typeof infoBubble != 'undefined') {
                    infoBubble.close();
                };
            });
        }
    }

    function scrollPoint(laLngValue) {
        var newpoint_px = overlay.getProjection().fromLatLngToDivPixel(laLngValue);
        newpoint_px.x = newpoint_px.x + str_posizione;
        var newpoint = overlay.getProjection().fromDivPixelToLatLng(new google.maps.Point(newpoint_px.x, newpoint_px.y));
        map.panTo(new google.maps.LatLng(newpoint.lat(), newpoint.lng()));
    }

    function markers(id_nodo, xml_file) {
        $.get(xml_file, {}, function (xml) {
            $(xml).find('itinerario').each(function () {
                if ($.trim($(this).attr("id")) == id_nodo || id_nodo == "") {
                    $(this).find('marker').each(function () {

                        var var_lat = $.trim($(this).find('lat').text());
                        var var_long = $.trim($(this).find('long').text());
                        var titolo = $.trim($(this).find('title').text());
                        var img = $.trim($(this).find('imgMappa').text());
                        var descrizione_breve = $.trim($(this).find('descr').text());
                        var link = $.trim($(this).find('link').text());
                        var color = $.trim($(this).find('color').text());
                        var tipo = $.trim($(this).find('type').text());


                        var markerImg = new google.maps.MarkerImage(
						//	'/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/' + tipo + '.png',
							'images/bandiera_it.png',

							null,
							null,
							new google.maps.Point(20, 20),
							new google.maps.Size(20, 24)
						);

                        var markerImgS = 'images/bandiera_it.png';//'/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/' + tipo + '.png';

                        var markerShadow = new google.maps.MarkerImage(
							'/export/system/modules/it.inera.opencms.piuss.sito/resources/img/marker/ombra_marker.png',
							null,
							null,
							new google.maps.Point(10, 5),
							new google.maps.Size(20, 8)
						);

                        var marker = new google.maps.Marker({
                            position: new google.maps.LatLng(var_lat, var_long),
                            title: titolo, //GC questo è il titolo in tooltip
                            map: map,
                            icon: markerImgS,
                            shadow: markerShadow,
                        });
                        //GC tool tip informativo 
                        //						var infoString = "<div class=\"info_itinerario\"><a href=\"" +
                        //										link + "\">" + img +
                        //										"</a><div class=\"testo\"><div class=\"titolo_info\"><a href=\"" +
                        //										link + "\"><h3>" + titolo + "</h3></a></div>" + descrizione_breve + "</div></div>";


                        var infoString = "<div class=\"info_itinerario\"><div class=\"testo\"><div class=\"titolo_info\"><a href=\"" + link + "\">" +
                        titolo + "</a></div>" + descrizione_breve + "</div></div>";

                        infoBubble = new InfoBubble({
                            content: infoString,
                            shadowStyle: 1,
                            padding: 5,
                            backgroundColor: 'rgb(255,255,255)',
                            borderRadius: 0,
                            arrowSize: 10,
                            borderWidth: 1,
                            borderColor: '#fff',
                            arrowPosition: 0,
                            disableAutoPan: true,
                            arrowStyle: 2
                        });

                        if (var_tipo != "1") {
                            google.maps.event.addListener(marker, 'click', function (kmlEvent) {
                                var str_latLng = kmlEvent.latLng;
                                infoBubble["content"] = infoString;
                                infoBubble["top"] = 10;
                                scrollPoint(str_latLng);
                                infoBubble.open(map, marker);
                                if (typeof infoBubbleKML != 'undefined') {
                                    infoBubbleKML.close();
                                };
                            });
                        } else {
                            google.maps.event.addListener(marker, 'click', function () {
                                window.location.href = link;
                            });
                        }
                    });
                }
            });
        });
    }

    var newObj = new Object()

    newObj.markers = markers;
    newObj.layers = layers;
    newObj.layers2 = layers2;
    return newObj;
}
