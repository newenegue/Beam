class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :instagram_id
      t.hstore :image_info
      t.references :album, index: true

      t.timestamps
    end
  end
end
