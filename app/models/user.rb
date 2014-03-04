class User < ActiveRecord::Base
	has_many :albums

	validates :username, presence: true
	validates :avatar, presence: true
	# validates_format_of :avatar, with: /\A(http(s?):)|([/|.|\w|\s])*\.(?:jpg|gif|png)/i
	# validates_property :format, of: :avatar, in: ['jpeg', 'png']
	# validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
