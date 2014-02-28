require 'instagram'

class SearchesController < ApplicationController
	#  handle revoked access from Instagram
	rescue_from Instagram::BadRequest, with: :default_user

  def index
  	# check is the search field is empty
  	if params[:search] == ""
  		# flash[:notice] = "You did not search for a hashtag so we search puppies for you!"
  		# params[:search] = 'puppies'
  		params[:search] = 'wdiproj3'
  	end

  	# when user logs out of instagram we need to check when our app gets refreshed or live update it?
  	if session[:access_token]
  		# create new client from user access_token
		client = Instagram.client(:access_token => session[:access_token])
		# get user
		@user = client.user
		# double check search params
		if params[:search] != nil
			# use new client to search
			@instagram_results = client.tag_recent_media(params[:search], {count: 10})
			# set initial next url for pagination
			@next_url = @instagram_results.pagination.next_url
		end
	else
		# for visitors
		if params[:search] != nil
			@instagram_results = Instagram.tag_recent_media(params[:search], {count: 10})
			@next_url = @instagram_results.pagination.next_url
		end
	end
  end

  def create
  end

protected

  #  handle revoked access from Instagram
  def default_user
  	# reset access_token
  	session[:access_token] = nil
  	# notify users
  	flash[:error] = 'access token revoked through instagram'
  	redirect_to searches_path
  end
end
