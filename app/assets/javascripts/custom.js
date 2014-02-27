// -------------------------------------------------------------
// Document ready
// -------------------------------------------------------------
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
		cycleBy: 'items',
		cycleInterval: 3000,
		keyboardNavBy: 'items'
	};

	// -------------------------------------------------------------
	// Create and initialize Sly slideshow
	// -------------------------------------------------------------
	var sly = new Sly($frame, options).init();
	sly.pause();

	// -------------------------------------------------------------
	// Event handler for fullscreen button
	// -------------------------------------------------------------
	$('#fullscreen').click(function () {
		if (screenfull.enabled) {
			var frame = $('.frame')[0];
			screenfull.request(frame);
			sly.reload();
			sly.toggle();
		}

	});

	$('#reload').click(function () {
		console.log('CLICKED RELOAD');
		// sly.reload();
	});

	// -------------------------------------------------------------
	// Event listener for fullscreen toggling
	// -------------------------------------------------------------
	if (screenfull.enabled) {
		document.addEventListener(screenfull.raw.fullscreenchange, function () {
			if(screenfull.isFullscreen){
				$('.frame').addClass('frame_fs');
				$('.frame_fs').removeClass('frame');
			}
			else {
				$('.frame_fs').addClass('frame');
				$('.frame').removeClass('frame_fs');
				sly.toggle();
			}
			sly.reload();
		});
	}

	// -------------------------------------------------------------
	// Reload on resize
	// -------------------------------------------------------------
	$(window).on('resize', function () {
		sly.reload();
	});

	// -------------------------------------------------------------
	// Infinite scrolling for image slideshow pagination
	// -------------------------------------------------------------
	sly.on('load change', function () {
		// check for sly position
		if (this.pos.dest > this.pos.end - 1800) {
			// check is there is a next_url
			if(next_url) {
				// send get request with pagination next_url
				$.get(next_url, function(instagram_results) {
					// checks next_url for duplicates
					if(next_url == instagram_results.pagination.next_url) {
						next_url = next_url;
					}
					else {
						// add images to sly
						for(var i = 0; i < instagram_results.data.length; i++) {
							sly.add('<li><img src=' + instagram_results.data[i].images.standard_resolution.url + '></li>');
						}
						// update next_url
						next_url = instagram_results.pagination.next_url;	
					}
				});
			}
		}
	});
}());






