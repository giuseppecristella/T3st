/*----------------------------------------------------*/
/*    			FILTERABLE / FADE PLUGIN
/*----------------------------------------------------*/
(function($){
    $.fn.extend({
        bra_filter_fade: function(options) {
 
            var defaults = {
                nav: '.filterable',
				thumbs: '#thumbs'
            };

            var options = $.extend(defaults, options);
			
/*----------------------------------------------------*/
/*    				FILTER PORTFOLIO
/*----------------------------------------------------*/

			return this.each(function() {
				var o = options;
			  	var obj = $(this);
				
				$(o.nav + ' a').click(function() {
					$(this).parents("ul").find("li").removeClass("active");
					$(this).parent().addClass("active");
					var filter = $(this).attr("data-filter");
					
					if (filter == "all"){
						$(o.thumbs + " li").fadeTo(500, 1);	
					} else {
						$(o.thumbs + " li").each(function(){
							if ($(this).hasClass(filter)){
								$(this).fadeTo(500, 1);
							} else {
								$(this).fadeTo(500, 0.2);
							}
						})
					}
					return false;
				});
				
/*--------------------------------------------------
	 PORTFOLIO ITEM IMAGE HOVER
---------------------------------------------------*/
				
				if( is_touch_device() ){
				  $(o.thumbs + " li").click(function(){
							  
				   var count_before = $(this).closest("li").prevAll("li").length;
				   
				   var this_opacity = $(this).find(".item-info-overlay").css("opacity");
				   var this_display = $(this).find(".item-info-overlay").css("display");   
				   
				   if ((this_opacity == 0) || (this_display == "none")) {
					if ($(this).css("opacity") == 1){
					 $(this).find(".item-info-overlay").fadeTo(250, 1);
					}
				   } else {
					if ($(this).css("opacity") == 1){
					 $(this).find(".item-info-overlay").fadeTo(250, 0);
					}
				   }
				   
				   $(this).closest("ul").find("li:lt(" + count_before + ") .item-info-overlay").fadeTo(250, 0);
				   $(this).closest("ul").find("li:gt(" + count_before + ") .item-info-overlay").fadeTo(250, 0); 
				
				  }); 
				
				 } else { 
				   $(o.thumbs + " li").hover(function(){
					if ($(this).css("opacity") == 1){
					 $(this).find(".item-info-overlay").fadeTo(250, 1);
					}
					}, function() {
					 if ($(this).css("opacity") == 1){
					  $(this).find(".item-info-overlay").fadeTo(250, 0);
					 }
					});               
				  
				 }
			}); // return this.each

        }
    });
})(jQuery);

/*----------------------------------------------------*/
/*    		DEFINE WRAPPER, NAV, THUMBS
/*----------------------------------------------------*/
jQuery(document).ready(function($){
  $('.content').bra_filter_fade({nav: '.filterable', thumbs: '#thumbs'});
});


