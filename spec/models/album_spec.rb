require 'spec_helper'

describe Album do

  describe 'validations' do
  	context 'when all attributes are valid' do
  		it 'is valid' do
        expect(FactoryGirl.build(:album)).to be_valid
  		end
  	end

  	context 'when title is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:album, title: nil)
        expect(album).to have(1).errors_on(:title)
  		end
  	end

  	context 'when user_id is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:album, user_id: nil)
        expect(album).to have(1).errors_on(:user_id)
  		end
  	end
  end
end
