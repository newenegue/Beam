class User < ActiveRecord::Base
	has_many :albums, dependent: :destroy

	validates :username, :avatar, presence: true
end
