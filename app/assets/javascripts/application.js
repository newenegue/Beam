// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require sly
//= require screenfull
//= require_tree .

$(function(){ $(document).foundation(); });

(function () {

	var $frame = $('.frame');
	var $wrap  = $frame.parent();

	// -------------------------------------------------------------
	// Default slideshow options
	// -------------------------------------------------------------
	var options = {
		horizontal: 1,
		itemNav: 'forceCentered',
		smart: 1,
		activateMiddle: 1,
		activateOn: 'click', // sdlkahsg
		mouseDragging: 1,
		touchDragging: 1,
		releaseSwing: 1,
		startAt: 0,
		scrollBar: $wrap.find('.scrollbar'),
		scrollBy: 0,
		moveBy: 500, //alkjsdhg
		speed: 150,
		elasticBounds: 1,
		easing: 'swing',
		dragHandle: 1,
		dynamicHandle: 1,
		clickBar: 1,

		keyboardNavBy: 'items'
		// Buttons
		// prev: $wrap.find('.prev'),
		// next: $wrap.find('.next')
	};

	// -------------------------------------------------------------
	//   Fullscreen one item per page slideshow
	// -------------------------------------------------------------
	// var options_fs = {
	// 	horizontal: 1,
	// 	itemNav: 'forceCentered',
	// 	smart: 1,
	// 	activateMiddle: 1,
	// 	mouseDragging: 1,
	// 	touchDragging: 1,
	// 	releaseSwing: 1,
	// 	startAt: 0,
	// 	scrollBar: $wrap.find('.scrollbar'),
	// 	scrollBy: 0,
	// 	speed: 150,
	// 	elasticBounds: 1,
	// 	easing: 'swing',
	// 	dragHandle: 1,
	// 	dynamicHandle: 1,
	// 	clickBar: 1,
	// 	// cycleBy: 'items',
	// 	// cycleInterval: 1000,
	// 	keyboardNavBy: 'items'
	// };

	// -------------------------------------------------------------
	// Create and initialize Sly slideshow
	// -------------------------------------------------------------
	var sly = new Sly($frame, options).init();

	// -------------------------------------------------------------
	// -------------------------------------------------------------
	sly.on("active", function() {
		if(screenfull.isFullscreen) {
			$('.active-fullscreen').removeClass('active-fullscreen');
			// $('li').addClass('fullscreen');
			$('.active').addClass('active-fullscreen');
			// $('.active').removeClass('fullscreen');
		}
	});

	$('#fullscreen').click(function () {
		if (screenfull.enabled) {
			var frame = $('.frame')[0];
			screenfull.request(frame);
		}
		sly.reload();
	});

	if (screenfull.enabled) {
		document.addEventListener(screenfull.raw.fullscreenchange, function () {
			// console.log('Am I fullscreen? ' + (screenfull.isFullscreen ? 'Yes' : 'No'));
			if(screenfull.isFullscreen){
				// $('li').addClass('fullscreen');
				$('.active').addClass('active-fullscreen');
				$('.active').removeClass('fullscreen');
				$('.frame').addClass('frame_fs');
				$('.frame_fs').removeClass('frame');
			}
			else {
				$('.active').removeClass('active-fullscreen');
				// $('li').removeClass('fullscreen');
				$('.frame_fs').addClass('frame');
				$('.frame').removeClass('frame_fs');
			}
			sly.reload();
		});
	}
}());






