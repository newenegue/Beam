require 'spec_helper'

describe User do

  describe 'validations' do
  	context 'when all attributes are valid' do
  		it 'is valid' do
        expect(FactoryGirl.build(:user)).to be_valid
  		end
  	end

  	context 'when username is missing' do
  		it 'is not valid' do
  			user = FactoryGirl.build(:user, username: nil)
  			expect(user).to have(1).errors_on(:username)
  		end
  	end
    
    context 'when avatar is missing' do
  		it 'is not valid' do
        user = FactoryGirl.build(:user, avatar: nil)
        expect(user).to have(1).errors_on(:avatar)
  		end
  	end  	

  end

end
