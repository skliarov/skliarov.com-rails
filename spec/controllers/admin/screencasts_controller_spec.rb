require 'rails_helper'

RSpec.describe Admin::ScreencastsController, type: :controller do
  describe 'POST #sort' do
    before :all do
      # Create user
      @user = FactoryGirl.create(:user)
      chapter = FactoryGirl.create(:chapter)
      
      # Create screencasts
      @screencast1 = FactoryGirl.create(:screencast, user: @user, chapter: chapter)
      @screencast2 = FactoryGirl.create(:screencast, user: @user, chapter: chapter)
      @screencast3 = FactoryGirl.create(:screencast, user: @user, chapter: chapter)
    end
    
    before :each do
      sign_in :user, @user
    end
    
    it 'should not touch timestamps' do
      post :sort, screencast: [@screencast3.id.to_s, @screencast2.id.to_s, @screencast1.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test timestamps
      expect(@screencast1.updated_at).to eq(Screencast.find(@screencast1.id).updated_at)
      expect(@screencast2.updated_at).to eq(Screencast.find(@screencast2.id).updated_at)
      expect(@screencast3.updated_at).to eq(Screencast.find(@screencast3.id).updated_at)
    end
    
    it 'should assign position to screencasts in straight order' do
      post :sort, screencast: [@screencast3.id.to_s, @screencast1.id.to_s, @screencast2.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test positions
      expect(Screencast.find(@screencast1.id).position).to eq(2)
      expect(Screencast.find(@screencast2.id).position).to eq(3)
      expect(Screencast.find(@screencast3.id).position).to eq(1)
    end
  end
end