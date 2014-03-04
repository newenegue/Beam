class Album < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  def add_to_album(id)
  	self.image_ids << id
  	self.save 
  end
end
