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

    # parse params, remove controller and action
    # parse params, extract image_id(instagram_id)
    # create album, if doesn't exist blah blah.
    # album = current_user.albums.create(title: untitled)
    # album.images.create(instagram_id: image_id, image_info: hash_of_stuff(new_hash))

    # album.images.create(image_info: hash(this will have instagram_id in it.))

    # check if the album has an image with that instagram id in the database
    # then we want to remove the image from the database, that will take care of all the relationships
    # else an image with instagram id doesnt exist in database
    # lets create the image
    # then SAVE album and image



    params.delete("controller")
    params.delete("action")
    new_hash = params.symbolize_keys
    binding.pry
    # what will happen to album id params????
    # image_id = params[:image_id]
    album_id = params[:album_id]
    if album_id == "untitled" || !album_id
      binding.pry
      if current_user.albums.find_by(title: 'untitled')
        binding.pry
        album = current_user.albums.find_by(title: 'untitled')
        binding.pry
      else
        binding.pry
        # album = current_user.albums.create(title: 'untitled', images: [])
        album = current_user.albums.new(title: 'untitled', images: [])
        binding.pry
      end
    else
      album = current_user.albums.find_by(id: album_id)
      binding.pry
    end
    # if album_id || album_id != "untitled"
    #   album = current_user.albums.find_by(id: album_id)
    # else
    #   # create new untitled album if it doesn't exist
    #   if current_user.albums.find_by(title: 'untitled')
    #     album = current_user.albums.find_by(title: 'untitled')
    #   else
    #     album = current_user.albums.create(title: 'untitled')
    #   end
    # end
    binding.pry
    if album.images.include? new_hash
    # if album.image_ids.include? image_id
      # remove it
      # album.image_ids -= [image_id]
      album.images -= [new_hash]
    else
      # add it
      album.images += [new_hash]
      # album.image_ids += [image_id]
    end
    binding.pry
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
