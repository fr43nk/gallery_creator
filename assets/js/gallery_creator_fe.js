/**
 * Class GalleryCreatorFe
 *
 * Provide methods to handle GalleryCreator-output.
 * @copyright  Marko Cupic 2011
 * @author     Marko Cupic <m.cupic@gmx.ch>
 */

// Dollar Safe Mode
(function ($) {
		if (typeof(window.event) != "undefined")
		{
			window.attachEvent("onDOMContentLoaded", function () {
        //Create the global GalleryCreatorFe-object
        objGalleryCreator = new GalleryCreatorFe();
    	});
		}
		else
		{
    	window.addEventListener('DOMContentLoaded', function () {
        //Create the global GalleryCreatorFe-object
        objGalleryCreator = new GalleryCreatorFe();
    	});
		}

		GalleryCreatorFe = function(){
			var s_self = this;
		};
    GalleryCreatorFe.prototype = {
				s_self : this,
        initialize: function () {
            //constructor
            s_self.thumbOpacity = 1;
        },

        initThumbSlide: function (el, albumId, countPictures) {
            var self = this;
           
            //set some class-vars
            this.s_self.currentDiv = jQuery(el);
            this.s_self.thumb = this.s_self.currentDiv.find('img.thumb');
            this.s_self.albumId = albumId;
            this.s_self.countPictures = countPictures;
            this.s_self.currentPic = 0;
            this.s_self.defaultThumbSrc = this.s_self.thumb.attr('src');
            var currentTime = new Date();
            this.s_self.eventId = currentTime.getTime();
            this.s_self.lastSlide = currentTime.getTime();
            //add the onmouseout-event
            this.s_self.currentDiv.bind('mouseout', function () {
                self.stopThumbSlide();
            });

            //slide thumbs after a delay of xxx milliseconds
            this.startThumbSlide(this.s_self.eventId);
        },

        stopThumbSlide: function () {
            this.s_self.eventId = null;
            if (this.s_self.thumb.attr('src') != this.s_self.defaultThumbSrc) {
                this.s_self.thumb.fadeTo(this.s_self.thumbOpacity);
                this.s_self.thumb.attr('src', this.s_self.defaultThumbSrc);
            }
            this.s_self.thumb.fadeTo(this.s_self.thumbOpacity);
        },

        startThumbSlide: function (eventId) {
            var self = this;
            //next pic
            this.s_self.currentPic++;
            var myRequest = new jQuery.ajax({
                url: document.URL,
                type: 'get',
								dataType: "json",
								data: 'isAjax=1&thumbSlider=1&AlbumId=' + this.s_self.albumId + '&limit=' + this.s_self.currentPic + '&eventId=' + eventId,

                success: function (responseText) {
                    if (!responseText) return;
                    if (responseText.eventId != self.s_self.eventId) return;
                    if (responseText.eventId == null || self.s_self.eventId == null) return;
                    if (responseText.thumbPath != "" && responseText.thumbPath != self.s_self.thumb.attr('src')) {
                        var currentTime = new Date();
                        if (currentTime.getTime() - self.lastSlide < 1200) {
                            self.startThumbSlide(eventId);
                            return;
                        }

                        self.lastSlide = currentTime.getTime();
                        var thumb = self.s_self.thumb;
                        thumb.attr('src', responseText.thumbPath);

                    }
                    self.startThumbSlide(responseText.eventId);
                }
            });
            if (self.currentPic == self.countPictures - 1) {
                self.currentPic = 0;
            }
            //myRequest.ajaxSend();
        }
    };
})(document.id);
