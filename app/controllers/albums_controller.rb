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
    set_post.destroy
    redirect_to posts_path
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
    image_id = params[:image_id]
    album_id = params[:album_id]
    if album_id
      album = current_user.albums.find_by(id: album_id)
    else
      # create new untitled album if it doesn't exist
      if current_user.albums.find_by(title: 'untitled')
        album = current_user.albums.find_by(title: 'untitled')
      else
        album = current_user.albums.create(title: 'untitled')
      end
    end
    if album.image_ids.include? image_id
      # remove it
      album.image_ids -= [image_id]
    else
      # add it
      album.image_ids += [image_id]
    end
    # binding.pry
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
