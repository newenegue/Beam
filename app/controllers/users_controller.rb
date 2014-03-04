class UsersController < ApplicationController
	def new
		
		
	end
	def create
		# uses global 'client' to find the user and username.
		# create beam user from 'client' user
		# redirect to searches index
		# pass user information across
		session[:client] = Instagram.client(:access_token => session[:access_token])
		@user = User.new(username: session[:client].user.username, avatar: session[:client].user.profile_picture)
		binding.pry
		if @user.save
			redirect_to searches_path
		else

		end

	end
end
