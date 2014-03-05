// -------------------------------------------------------------
// Document ready
// -------------------------------------------------------------

(function () {

	// -------------------------------------------------------------
	// Check if user is logged into Instagram
	// -------------------------------------------------------------
	var check_login = null;
	var logged_in = false;
	$.ajax({
		url: "http://instagram.com/",
		type: 'get',
		dataType: 'html',
		async: false,
		success: function(data) {
			check_login = data;
		}
	});
	if(check_login){
		if(check_login.indexOf("not-logged-in") >= 0) {
			// set session[:access_token] = nil
			// set session[:client] = nil
			console.log("NOT LOGGED INTO INSTAGRAM");
			logged_in = false;
		}
		else {
			console.log("YOU ARE LOGGED INTO INSTAGRAM");
			logged_in = true;
		}
	}

	// -------------------------------------------------------------
	// Event handler for Instagram logout - does not rely on sly
	// -------------------------------------------------------------
	$('#disconnect').on('click', function() {
		$('#iframe_disconnect').html('<iframe src="https://instagram.com/accounts/logout/">');
	});

	// -------------------------------------------------------------
	// Add image to beam album
	// -------------------------------------------------------------
	// default to more recent album
	var album_id;

	$(document.body).on('click', '.add_to_album' ,function(){
		// send data to add_image controller action
		$.ajax({
			url: "http://localhost:3000/albums/add_image",
			type: "post",
			data: {
				image_id: $(this).data().imageIds,
				album_id: album_id
			},
			success: function(data) {
				if($("#select_album option:contains('untitled')").text() !== "untitled")
					$("#select_album option").first().after('<option id="untitled" value="untitled">untitled</option>');
				console.log("Add image to " + album_id + " album!");
			}
		});
	});

	// drop down album selector
	$("#select_album").change( function() {
		album_id = $(this).find("option:selected").attr("value");
	});

	// -------------------------------------------------------------
	// Set pry variables
	// -------------------------------------------------------------
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
		speed: 250,
		elasticBounds: 1,
		easing: 'swing',
		dragHandle: 1,
		dynamicHandle: 1,
		clickBar: 1,
		cycleBy: 'items',
		cycleInterval: 5000,
		keyboardNavBy: 'items'
	};

	// -------------------------------------------------------------
	// Create and initialize Sly slideshow
	// -------------------------------------------------------------
	var sly = new Sly($frame, options).init();
	sly.pause();
	sly.reload();
	var caption_fs = false;
	var cap_length = 100;
	

	// -------------------------------------------------------------
	// Event listener for fullscreen toggling
	// -------------------------------------------------------------
	if (screenfull.enabled) {
		document.addEventListener(screenfull.raw.fullscreenchange, function () {
			if(screenfull.isFullscreen){
				$('.frame').addClass('frame_fs');
				$('.frame_fs').removeClass('frame');
				if(caption_fs){
					$('.frame_fs').addClass('caption_fs');
				}
				sly.set('speed', 0);
			}
			else {
				$('.frame_fs').addClass('frame');
				$('.frame').removeClass('frame_fs');
				$('.frame').removeClass('caption_fs');
				caption_fs = false;
				cap_length = 100;
				sly.toggle();
				sly.set('speed', 250);
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
							result = instagram_results.data[i];
							var time_ago = $.timeago(result.created_time * 1000);
							if(result.caption){
								var caption = $.trim(result.caption.text).substring(0, cap_length).trim(this);

								if(caption.length == cap_length)
									caption = caption  + "...";
								if(result.videos){
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + '<div class="add_to_album" data-image-ids="'+ result.id +'">Add</div><br><a href="' + result.videos.standard_resolution.url + '" target="_blank">Play Video</a></div><div class="image_footer">'+ caption +'</div></div><img src=' + result.images.standard_resolution.url + '></li>');
								}
								else {
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + ' <div class="add_to_album" data-image-ids="'+ result.id +'">Add</div></div><div class="image_footer">'+ caption +'</div></div><img src=' + result.images.standard_resolution.url + '></li>');
								}
							}
							else{
								if(result.videos)
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + '<div class="add_to_album" data-image-ids="'+ result.id +'">Add</div><br><a href="' + result.videos.standard_resolution.url + '" target="_blank">Play Video</a></div><div class="image_footer"></div></div><img src=' + result.images.standard_resolution.url + '></li>');
								else
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + ' <div class="add_to_album" data-image-ids="'+ result.id +'">Add</div></div><div class="image_footer"></div></div><img src=' + result.images.standard_resolution.url + '></li>');
							}
							
						}
						// update next_url
						next_url = instagram_results.pagination.next_url;
					}
				});
			}
		}
	});

	// -------------------------------------------------------------
	// Event handler for fullscreen button
	// -------------------------------------------------------------
	$('#fullscreen').click(function () {
		if (screenfull.enabled) {
			var frame = $('.frame')[0];
			sly.reload();
			screenfull.request(frame);
			sly.toggle();
		}
	});

	// -------------------------------------------------------------
	// Event handler for fullscreen button with captions
	// -------------------------------------------------------------
	$('#fullscreen_caption').click(function () {
		if (screenfull.enabled) {
			caption_fs = true;
			cap_length = 200;
			var frame = $('.frame')[0];
			sly.reload();
			screenfull.request(frame);
			sly.toggle();
		}
	});
}());







