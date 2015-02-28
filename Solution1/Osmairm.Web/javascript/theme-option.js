jQuery(document).ready(function($) {


$('select#background').change(function () { 
	var b = $(this).children(":selected").val();
	if (b == 'bg0') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg0");
	}
	else if (b == 'bg1') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg1");
	}	
	else if (b == 'bg2') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg2");
	}
	else if (b == 'bg3') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg3");
	}
	else if (b == 'bg4') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg4");
	}
	else if (b == 'bg5') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg5");
	}
	else if (b == 'bg6') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg6");
	}
	else if (b == 'bg7') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg7");
	}
	else if (b == 'bg8') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg8");
	}
	else if (b == 'bg9') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg9");
	}
	else if (b == 'bg10') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg10");
	}
	else if (b == 'bg11') {
		$('body').css('backgroundColor', '#f8f8f8').removeClass().addClass("bg11");
	}
});	



$('select#skin').change(function () { 
	var b = $(this).children(":selected").val();
	if (b == 'light') {
		window.location.href = "http://demo.brankic.net/vertigohtml/light/index.html";
	}	
	else if (b == 'grey') {
		window.location.href = "http://demo.brankic.net/vertigohtml/grey/index.html";
	}	
	else if (b == 'dark') {
		window.location.href = "http://demo.brankic.net/vertigohtml/dark/index.html";
	}
});	

 jQuery("select#colors").change(function(){
  var color = jQuery(this).children(":selected").val();
  if (jQuery("#css_color_style-css").length > 0){
	  jQuery("#css_color_style-css").remove();
  } 
  jQuery("head").append("<link>");
  css = jQuery("head").children(":last");
  css.attr({
    rel:  "stylesheet",
    type: "text/css",
    id: "css_color_style",
    href: "css/colors/color-" + color + ".css"
  });
 })


 $("#panel a.open").click(function(){
  var margin_left = $("#panel").css("margin-left");
  if (margin_left == "-210px"){
  $("#panel").animate({marginLeft: "0px"});
 }
 else{
  $("#panel").animate({marginLeft: "-210px"});
 }

 })

}); 