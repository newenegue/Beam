require 'spec_helper'

describe User do
  before :each do 
  	@valid_attr = {
  		username: 'beam_tag_team',
  		avatar: 'http://images.ak.instagram.com/profiles/anonymousUser.jpg',
  		email: 'beam.tag.team@gmail.com'
  	}
  end

  describe 'validations' do
  	context 'when all attributes are valid' do
  		it 'is valid' do
  			expect(User.new(@valid_attr)).to be_valid
  		end
  	end

  	context 'when username is missing' do
  		it 'is not valid' do
  			user = User.new(@valid_attr.merge(username: ''))
  			expect(user).not_to be_valid
  		end
  	end

	context 'when avatar is missing' do
  		it 'is not valid' do
  			user = User.new(@valid_attr.merge(avatar: ''))
  			expect(user).not_to be_valid
  		end
  	end  	

  	context 'when avatar is not a jpg' do
  		# it 'is not valid' do
  		# 	user = User.new(@valid_attr.merge(avatar: 'http://images.ak.instagram.com/profiles/anonymousUser'))
  		# 	expect(user).not_to be_valid
  		# end
  	end

  	context 'when email is not the correct format' do
  		it 'is not valid' do
  			user = User.new(@valid_attr.merge(email: 'blahblah'))
  			expect(user).not_to be_valid
  		end
  	end



  end

end
