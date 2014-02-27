require 'instagram'

class SearchesController < ApplicationController
  def index

  	if params[:search] == ""
  		params[:search] = 'wdiproj3'
  	end

  	if session[:access_token]
		client = Instagram.client(:access_token => session[:access_token])
		@user = client.user
		@instagram_results = client.tag_recent_media(params[:search], {count: 10}) if params[:search] != nil
		# @page_2_tag_id = @instagram_results.pagination.next_max_tag_id
		# @page_2 = client.tag_recent_media(params[:search], {count: 10, max_id: @page_2_tag_id}) unless @page_2_tag_id.nil?

		# concat all results into same one
	else
		@instagram_results = Instagram.tag_recent_media(params[:search], {count: 10}) if params[:search] != nil
	end
  end

  def create
  end
end
