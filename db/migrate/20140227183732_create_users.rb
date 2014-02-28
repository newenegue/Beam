class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :avatar
      t.string :email

      t.timestamps
    end
  end
end
