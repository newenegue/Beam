json.albums do |json|
	json.array! @albums do |album|
		json.extract! album, :id, :title
		json.url album_url(album, format: :json)
		json.images do |json|
			json.count album.images.count
		end
	end
end