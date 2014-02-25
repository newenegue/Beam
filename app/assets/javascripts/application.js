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
// require turbolinks
//= require sly
//= require_tree .

$(function(){ $(document).foundation(); });

(function () {
	var $frame = $('.frame');
	var $wrap  = $frame.parent();

	// Call Sly on frame
	$frame.sly({
		horizontal: 1,
		itemNav: 'forceCentered',
		smart: 1,
		activateMiddle: 1,
		activateOn: 'click',
		mouseDragging: 1,
		touchDragging: 1,
		releaseSwing: 1,

		startAt: 0,
		scrollBar: $wrap.find('.scrollbar'),
		scrollBy: 0,

		moveBy: 500,
		speed: 150,
		elasticBounds: 1,
		easing: 'swing',
		dragHandle: 1,
		dynamicHandle: 1,
		clickBar: 1,
		keyboardNavBy: 'items',

		// cycleBy: 'items',
		// cycleInterval: 5000,

		// Buttons
		prev: $wrap.find('.prev'),
		next: $wrap.find('.next')
	});
}());