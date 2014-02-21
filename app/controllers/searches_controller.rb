require 'instagram'

class SearchesController < ApplicationController
  def index
  end

  def create
	if session[:access_token]
		client = Instagram.client(:access_token => session[:access_token])
		@user = client.user
		@instagram_results = client.tag_recent_media(params[:search])
	else
		@instagram_results = Instagram.tag_recent_media(params[:search])
	end
  end
end
