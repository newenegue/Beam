require 'spec_helper'

describe AlbumsController do
  let (:album) { FactoryGirl.build :album }
  subject { album }

  let(:current_user) { FactoryGirl.create :user}
  before :each do
    controller.stub(:current_user).and_return(current_user) 
  end
  subject {current_user}

  describe "GET 'new'" do

    context "user not signed in" do
      it "does not create a new album" do
        Album.stub(:new).and_return("A new Album")
        get 'new'
        expect(assigns(:album)).to eq "A new Album"
      end
    end

  end

  describe "GET 'destroy'" do
    context "user not signed in" do
      it "does not destroy specified album" do
        controller.stub(:current_user).and_return(nil)
        album.save 
        delete 'destroy', { id: album.id }
        expect(album).to be_persisted
      end
    end

    context "user signed in" do
      it "Destroys specified album" do
        album.save
        delete :destroy, { id: album.id }
        expect(Album.count).to eq 0
      end
    end
  end

  describe "GET 'index'" do
    context "user signed in" do
      it "returns http success" do
        album.save
        album2 = FactoryGirl.create :album
        current_user.albums = [album, album2]
        get 'index'
        expect(assigns(:albums)).to eq [album, album2]
        response.should be_success
      end
    end
  end

  describe "GET 'edit'" do
    context "user not signed in" do
      it "does not find specified album" do
        controller.stub(:current_user).and_return(nil)
        album.save 
        get 'edit', { id: album.id }
        expect(album).to be_persisted
      end
    end

    context "user not signed in" do
      it "Finds specified album" do
        Album.stub(:find).and_return("An Album")
        get 'edit', { id: 123}
        expect(assigns(:album)).to eq "An Album"
      end
    end
  end

  describe "GET 'show'" do
    context "user not signed in" do
      it "does not show specified album" do
        controller.stub(:current_user).and_return(nil)
        album.save 
        get 'show', { id: album.id }
        expect(album).to be_persisted
      end
    end

    context "user signed in" do
      it "Finds specified album" do
        Album.stub(:find).and_return("An Album")
        get 'show', { id: 123 }
        expect(assigns(:album)).to eq "An Album"
      end
    end
    
  end

end
