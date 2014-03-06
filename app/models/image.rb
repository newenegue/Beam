class Image < ActiveRecord::Base
	belongs_to :album

	validates :instagram_id, :ig_url, :ig_user, :ig_created_time, presence: true
end
