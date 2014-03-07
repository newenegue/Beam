require 'instagram'

class SessionsController < ApplicationController
  def connect
    # binding.pry
    # send instagram users to login page
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  def disconnect
    # allow Instagram logout through jQuery time to process
    # sleep 5
    # render nothing: true
    # reset token and redirect
  	session[:access_token] = nil
    # binding.pry
  	redirect_to searches_path
    # redirect_to "https://instagram.com/accounts/logout/"
  end

  def callback
    # if the user denied authorization
    if params[:error]
    	flash[:error] = 'You did not authorize Beam to use your Instagram account'
      redirect_to :controller => 'searches', :action => 'index'
    else
      # retrieve access_token
      response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
      session[:access_token] = response.access_token
      session[:client] = Instagram.client(:access_token => session[:access_token])
      
      # create user account for first time users
      # THIS SHOULD BE DONE IN THE USERS CONTROLLER
      if User.find_by(username: session[:client].user.username) == nil
        user = User.new(username: session[:client].user.username, avatar: session[:client].user.profile_picture)
        if user.save
          redirect_to :controller => 'searches', :action => 'index'
        else
          flash[:error] = "User account could not be created"
        end
      else
        # user account already exists
        redirect_to :controller => 'searches', :action => 'index'
      end
    end
  end
end