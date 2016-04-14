require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before :all do
    @article = FactoryGirl.create(:article, published: true)
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
      get :show, slug: @article.slug
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
  
  describe 'GET #feed' do
    before :each do
      get :feed, { format: 'rss' }
    end
    it 'should have successful response status' do
      expect(response).to be_success
    end
    it 'should have valid content-type' do
      expect(response.content_type).to eq('application/rss+xml')
    end
    it 'should render #feed view' do
      expect(response).to render_template(:feed)
    end
  end
end