class RemoveImageInfoFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :image_info, :string
  end
end
