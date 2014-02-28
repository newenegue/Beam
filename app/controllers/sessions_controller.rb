require 'instagram'

class SessionsController < ApplicationController
  def connect
    # send instagram users to login page
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  def disconnect
    # allow Instagram logout through jQuery time to process
    sleep 0.5
    # reset token and redirect
  	session[:access_token] = nil
  	redirect_to searches_path
  end

  def callback
  	# if the user denied authorization
  	if params[:error]
  		flash[:error] = 'You did not authorize Beam to use your Instagram account'
  	else
      # retrieve access_token
	    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
	    session[:access_token] = response.access_token
	end
	  redirect_to :controller => 'searches', :action => 'index'
  end
end