require 'instagram'

class Search < ActiveRecord::Base
	# def self.hashtag_results(hashtag, access_token=nil)

	# 	if access_token
	# 		client = Instagram.client(:access_token => access_token)
	# 		client.tag_recent_media(hashtag, {count: 10})
	# 		# @page_2_tag_id = @instagram_results.pagination.next_max_tag_id
	# 		# @page_2 = client.tag_recent_media(params[:search], {count: 10, max_id: @page_2_tag_id}) unless @page_2_tag_id.nil?

	# 		# concat all results into same one
	# 	else
	# 		Instagram.tag_recent_media(hashtag, {count: 10})
	# 	end
	# end

	# def get_user(client)
	# 	client = Instagram.client(:access_token => access_token)
	# 	client.user
	# end

	# def get_access_token(access_token=nil)
	# 	Instagram.client(:access_token => access_token)
	# end
end
