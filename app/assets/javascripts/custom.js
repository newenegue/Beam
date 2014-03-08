// -------------------------------------------------------------
// Document ready
// -------------------------------------------------------------

(function () {

	$('select').selectpicker();

	// -------------------------------------------------------------
	// Keypress handlers
	// -------------------------------------------------------------
	$(document).keydown(function(e){
		// toggle captions on fullscreen
		if(e.keyCode == 67) {
			console.log('c');
			caption_fs = !caption_fs;
			if(caption_fs){
				$('.frame_fs').addClass('caption_fs');
			}
			else{
				$('.frame_fs').removeClass('caption_fs');
				$('.frame').removeClass('caption_fs');
			}
			
		}
	});

	// -------------------------------------------------------------
	// Check if user is logged into Instagram
	// -------------------------------------------------------------
	// var check_login = null;
	// $.ajax({
	// 	url: "http://instagram.com/",
	// 	type: 'get',
	// 	dataType: 'html',
	// 	async: false,
	// 	success: function(data) {
	// 		check_login = data;
	// 	}
	// });

	// if(check_login){
	// 	if(check_login.indexOf("not-logged-in") >= 0) {
	// 		if(logged_in==="true") {
	// 			window.location="http://localhost:3000/session/disconnect";
	// 			logged_in = "false";
	// 		}
	// 	}
	// 	else {
	// 		logged_in = "true";
	// 	}
	// }

	// -------------------------------------------------------------
	// Add image to beam album
	// -------------------------------------------------------------
	// default to more recent album
	var album_id;

	$(document.body).on('click', '.remove_from_album' ,function(){
		var result = $(this).data();
		$('.active_sly .remove_from_album').toggleClass('selected');
		$.ajax({
			url: "http://beam-team.herokuapp.com//albums/remove_image",
			type: "post",
			data: {
				image_id: result.imageId,
				album_id: result.albumId
			},
			success: function(data) {
				console.log("Remove image from " + album_id + " album!");
			}
		});
	});

	$(document.body).on('click', '.add_to_album' ,function(){
		var result = $(this).data();
		// console.log($(this).data());
		// send data to add_image controller action
		$('.active_sly .add_to_album').toggleClass('selected');
		$.ajax({
			url: "http://beam-team.herokuapp.com//albums/add_image",
			type: "post",
			data: {
				image_id: result.imageId, //
				image_url: result.imageUrl,
				image_caption: result.imageCaption,
				username: result.username,
				user_avatar: result.userAvatar,
				video_url: result.videoUrl,
				created_time: result.timeAgo,
				album_id: album_id, //
				in_album: result.inAlbum //
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
		activeClass:   'active_sly',
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
				cap_length = 200;
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
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + '<div class="add_to_album" data-image-ids="'+ result.id +'"></div><br><a href="' + result.videos.standard_resolution.url + '" target="_blank">Play Video</a></div><div class="image_footer"><div class="ig_caption">'+ caption +'</div><div><a class="fs" id="fullscreen"><span class="glyphicon glyphicon-fullscreen"></span></a></div></div></div><img src=' + result.images.standard_resolution.url + '></li>');
								}
								else {
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + ' <div class="add_to_album" data-image-ids="'+ result.id +'"></div></div><div class="image_footer"><div class="ig_caption">'+ caption +'</div><div><a class="fs" id="fullscreen"><span class="glyphicon glyphicon-fullscreen"></span></a></div></div></div><img src=' + result.images.standard_resolution.url + '></li>');
								}
							}
							else{
								if(result.videos)
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + '<div class="add_to_album" data-image-ids="'+ result.id +'"></div><br><a href="' + result.videos.standard_resolution.url + '" target="_blank">Play Video</a></div><div class="image_footer"><div><a class="fs" id="fullscreen"><span class="glyphicon glyphicon-fullscreen"></span></a></div></div></div><img src=' + result.images.standard_resolution.url + '></li>');
								else
									sly.add('<li><div class="image_info"><div class="image_header"><img src="' + result.user.profile_picture + '" id="avatar" ></img><cite><a href="http://instagram.com/' + result.user.username + '" target="_blank">' + result.user.username + '</a></cite> ' + time_ago + ' <div class="add_to_album" data-image-ids="'+ result.id +'"></div></div><div class="image_footer"><div><a class="fs" id="fullscreen"><span class="glyphicon glyphicon-fullscreen"></span></a></div></div></div><img src=' + result.images.standard_resolution.url + '></li>');
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
}());







