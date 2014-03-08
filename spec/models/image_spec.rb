require 'spec_helper'

describe Image do
  describe 'validations' do
  	context 'when all attributes are valid' do
  		it 'is valid' do
        expect(FactoryGirl.build(:image)).to be_valid
  		end
  	end

  	context 'when instagram_id is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, instagram_id: nil)
        	expect(album).to have(1).errors_on(:instagram_id)
  		end
  	end

  	context 'when instagram_id is empty string' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, instagram_id: "")
        	expect(album).to have(1).errors_on(:instagram_id)
  		end
  	end

  	context 'when ig_url is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_url: nil)
        	expect(album).to have(1).errors_on(:ig_url)
  		end
  	end

  	context 'when ig_url is empty string' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_url: "")
        	expect(album).to have(1).errors_on(:ig_url)
  		end
  	end

  	context 'when ig_user is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_user: nil)
        	expect(album).to have(1).errors_on(:ig_user)
  		end
  	end

  	context 'when ig_user is empty string' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_user: "")
        	expect(album).to have(1).errors_on(:ig_user)
  		end
  	end

  	context 'when ig_user_avatar is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_user_avatar: nil)
        	expect(album).to have(1).errors_on(:ig_user_avatar)
  		end
  	end

  	context 'when ig_user_avatar is empty string' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_user_avatar: "")
        	expect(album).to have(1).errors_on(:ig_user_avatar)
  		end
  	end

  	context 'when ig_created_time is missing' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_created_time: nil)
        	expect(album).to have(1).errors_on(:ig_created_time)
  		end
  	end

  	context 'when ig_created_time is empty string' do
  		it 'is not valid' do
  			album = FactoryGirl.build(:image, ig_created_time: "")
        	expect(album).to have(1).errors_on(:ig_created_time)
  		end
  	end
  end
end
