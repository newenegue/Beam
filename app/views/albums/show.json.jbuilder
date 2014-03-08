json.album do |json|
	json.extract! @album, :id, :title
	json.images do |json|
		json.array!(@album.images) do |image|
			json.extract! image, :instagram_id, :ig_url, :ig_caption, :ig_user, :ig_user_avatar, :ig_video_url, :ig_created_time 
		end
	end
end