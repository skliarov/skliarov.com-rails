require 'rails_helper'

RSpec.describe ScreencastsController, type: :controller do
  before :all do
    @screencast = FactoryGirl.create(:screencast, published: true)
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
      get :show, id: @screencast.slug
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