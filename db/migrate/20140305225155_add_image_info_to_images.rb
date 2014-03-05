class AddImageInfoToImages < ActiveRecord::Migration
  def change
    add_column :images, :ig_url, :string
    add_column :images, :ig_caption, :string
    add_column :images, :ig_user, :string
    add_column :images, :ig_user_avatar, :string
    add_column :images, :ig_video_url, :string
    add_column :images, :ig_created_time, :string
  end
end
