require 'rails_helper'

RSpec.describe Admin::ChaptersController, type: :controller do
  describe 'POST #sort' do
    before :all do
      # Create user
      @user = FactoryGirl.create(:user)
      
      # Create chapters
      @chapter1 = FactoryGirl.create(:chapter, user: @user)
      @chapter2 = FactoryGirl.create(:chapter, user: @user)
      @chapter3 = FactoryGirl.create(:chapter, user: @user)
    end
    
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, @user
    end
    
    it 'should not touch timestamps' do
      post :sort, chapter: [@chapter3.id.to_s, @chapter2.id.to_s, @chapter1.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test timestamps
      expect(@chapter1.updated_at).to eq(Chapter.find(@chapter1.id).updated_at)
      expect(@chapter2.updated_at).to eq(Chapter.find(@chapter2.id).updated_at)
      expect(@chapter3.updated_at).to eq(Chapter.find(@chapter3.id).updated_at)
    end
    
    it 'should assign position to chapters in straight order' do
      post :sort, chapter: [@chapter3.id.to_s, @chapter1.id.to_s, @chapter2.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test positions
      expect(Chapter.find(@chapter1.id).position).to eq(2)
      expect(Chapter.find(@chapter2.id).position).to eq(3)
      expect(Chapter.find(@chapter3.id).position).to eq(1)
    end
  end
end