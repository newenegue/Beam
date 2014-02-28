class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :image_ids, array: true, default: []
      t.references :user, index: true

      t.timestamps
    end
  end
end
