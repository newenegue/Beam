class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @user = current_user
    @album = @user.albums.new(album_params)
    if @album.save
      redirect_to albums_path
    else
      render 'new'
    end
        
  end

  def destroy
    # binding.pry
    set_album.destroy
    redirect_to albums_path
  end

  def index
    @albums = current_user.albums
  end

  def edit
    set_album
  end

  def update
    if set_album.user == current_user && set_album.update(album_params)
      redirect_to albums_path
    else
      redirect_to edit_album_path
    end
  end

  def show
    set_album
  end

  # add an image to an album
  # data sent from ajax call
  def add_image

    # clean up params for creating the image and album
    # if params[:album_id]
      album_id = params[:album_id]
      # params.delete("album_id")
      # binding.pry
    # end
    instagram_id = params[:image_id]
    ig_url = params[:image_url]
    ig_caption = params[:image_caption]
    ig_user = params[:username]
    ig_user_avatar = params[:user_avatar]
    ig_video_url = params[:video_url]
    ig_created_time = params[:created_time]

    # params.delete("image_id")
    # params.delete("controller")
    # params.delete("action")
    # new_hash = params.symbolize_keys

    # create or find the album
    if album_id == "untitled" || !album_id
      if current_user.albums.find_by(title: 'untitled')
        album = current_user.albums.find_by(title: 'untitled')
      else
        # album = current_user.albums.create(title: 'untitled', images: [])
        album = current_user.albums.new(title: 'untitled')
      end
    else
      album = current_user.albums.find_by(id: album_id)
    end

    # add or remove the image from album
    if album.images.any? {|image| image.instagram_id == instagram_id}
      remove_image = album.images.find_by(instagram_id: instagram_id)
      remove_image.destroy
    else
      album.images << Image.create(instagram_id: instagram_id, ig_url: ig_url, ig_caption: ig_caption, ig_user: ig_user, ig_user_avatar: ig_user_avatar, ig_video_url: ig_video_url, ig_created_time: ig_created_time)
    end

    album.save
    render nothing: true
  end

private
  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :image_ids)
  end

end
