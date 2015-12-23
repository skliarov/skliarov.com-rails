require 'rails_helper'

RSpec.describe ScreencastsController, type: :controller do
  before :all do
    @user = FactoryGirl.create(:user)
    @chapter = FactoryGirl.create(:chapter, user: @user)
    # Create test articles
    screencast1 = FactoryGirl.create(:screencast, user: @user, chapter: @chapter, published: true)
    screencast2 = FactoryGirl.create(:screencast, user: @user, chapter: @chapter, published: false)
    screencast3 = FactoryGirl.create(:screencast, user: @user, chapter: @chapter, published: true)
    @screencasts = [screencast1, screencast2, screencast3]
  end
  
  describe 'GET #index' do
    before :each do
      get :index
    end
    it 'should have successful response status' do
      expect(response).to be_success
    end
    it 'should have valid content-type' do
      expect(response.content_type).to eq('text/html')
    end
    it 'should render #index view' do
      expect(response).to render_template(:index)
    end
  end
  
  describe 'GET #show' do
    before :each do
      screencast = @screencasts[0]
      get :show, id: screencast.slug
    end
    it 'should have successful response status' do
      expect(response).to be_success
    end
    it 'should have valid content-type' do
      expect(response.content_type).to eq('text/html')
    end
    it 'should render #show view' do
      expect(response).to render_template(:show)
    end
  end
end