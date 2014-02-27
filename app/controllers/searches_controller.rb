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

		# set initial next url for pagination
		@next_url = @instagram_results.pagination.next_url
	else
		@instagram_results = Instagram.tag_recent_media(params[:search], {count: 10}) if params[:search] != nil
		@next_url = @instagram_results.pagination.next_url
	end
  end

  def create
  end
end
