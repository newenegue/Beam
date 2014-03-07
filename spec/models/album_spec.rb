require 'spec_helper'

describe Album do
  before :each do 
	@valid_attr = {
		title: 'beam_tag_team',
		user_id: '12398765'
	}
  end

  describe 'validations' do
  	context 'when all attributes are valid' do
  		it 'is valid' do
  			expect(Album.new(@valid_attr)).to be_valid
  		end
  	end

  	context 'when title is missing' do
  		it 'is not valid' do
  			user = Album.new(@valid_attr.merge(title: ''))
  			expect(user).not_to be_valid
  		end
  	end

  	context 'when user_id is missing' do
  		it 'is not valid' do
  			user = Album.new(@valid_attr.merge(user_id: nil))
  			expect(user).not_to be_valid
  		end
  	end
  	
  end
end
