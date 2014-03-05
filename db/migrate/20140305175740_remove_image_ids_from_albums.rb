class RemoveImageIdsFromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :image_ids, :string
  end
end
