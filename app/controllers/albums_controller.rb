class AlbumsController < ApplicationController
  before_action :remove_orphans, only: [:show]

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
    album_id = params[:album_id]
    instagram_id = params[:image_id]
    ig_url = params[:image_url]
    ig_caption = params[:image_caption]
    ig_user = params[:username]
    ig_user_avatar = params[:user_avatar]
    ig_video_url = params[:video_url]
    ig_created_time = params[:created_time]

    # binding.pry

    # create or find the album
    if album_id == "untitled" || !album_id
      # binding.pry
      if current_user.albums.find_by(title: 'untitled')
        # binding.pry
        album = current_user.albums.find_by(title: 'untitled')
        # binding.pry
      else
        # binding.pry
        # album = current_user.albums.create(title: 'untitled', images: [])
        album = current_user.albums.new(title: 'untitled')
        # binding.pry
      end
    else
      # binding.pry
      album = current_user.albums.find_by(id: album_id)
      # binding.pry
    end
# binding.pry
    # add or remove the image from album
    if album.images.any? {|image| image.instagram_id == instagram_id}
      # binding.pry
      remove_image = album.images.find_by(instagram_id: instagram_id)
      # binding.pry
      remove_image.destroy
      # binding.pry
    else
      # binding.pry
      album.images << Image.create(instagram_id: instagram_id, ig_url: ig_url, ig_caption: ig_caption, ig_user: ig_user, ig_user_avatar: ig_user_avatar, ig_video_url: ig_video_url, ig_created_time: ig_created_time)
      # binding.pry
    end
# binding.pry
    album.save
    # binding.pry
    render nothing: true
  end

  def remove_image
    image_id = params[:image_id]
    album_id = params[:album_id]

    image_to_remove = Image.find_by(id: image_id)
    album = Album.find_by(id: album_id)
    if album.images.any? {|img| img.id == image_id.to_i}
      image_to_remove.album_id = nil
      image_to_remove.save
    else
      album.images << image_to_remove
      album.save
    end
    
    render nothing: true
  end

private
  def remove_orphans
    images_to_delete = Image.all.where(album_id: nil)
    images_to_delete.each do |image|
      image.destroy
    end
  end
  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :image_ids)
  end

end
