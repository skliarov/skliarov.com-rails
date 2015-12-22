require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do
  before :all do
    @user = FactoryGirl.create(:user)
  end
  
  describe 'GET #index' do
    context 'user is signed in' do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in :user, @user
      end
      
      it 'should return valid response' do
        get :index
        expect(response).to be_success
        expect(response).to render_template(:index)
        expect(response.content_type).to eq('text/html')
      end
    end
    
    context 'user is not signed in' do
      it 'should redirect to new user session path' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end
  end
  
  describe 'GET #show' do
    before :all do
      @article = FactoryGirl.create(:article)
      @article.reload # reload article in order to generate slug
    end
    
    context 'user is signed in' do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in :user, @user
      end
      
      it 'should return valid response' do
        get :show, id: @article.slug
        expect(response).to be_success
        expect(response).to render_template(:show)
        expect(response.content_type).to eq('text/html')
      end
    end
    
    context 'user is not signed in' do
      it 'should redirect to new user session path' do
        get :show, id: @article.slug
        expect(response).to redirect_to(new_user_session_path)
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end
  end
  
  describe 'POST #sort' do
    before :all do
      # Create articles
      @article1 = FactoryGirl.create(:article, published: true, user: @user)
      @article2 = FactoryGirl.create(:article, published: true, user: @user)
      @article3 = FactoryGirl.create(:article, published: true, user: @user)
    end
    
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, @user
    end
    
    it 'should not touch timestamps' do
      post :sort, article: [@article3.id.to_s, @article2.id.to_s, @article1.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test timestamps
      expect(@article1.updated_at).to eq(Article.find(@article1.id).updated_at)
      expect(@article2.updated_at).to eq(Article.find(@article2.id).updated_at)
      expect(@article3.updated_at).to eq(Article.find(@article3.id).updated_at)
    end
    
    it 'should assign position to articles in reverse order' do
      post :sort, article: [@article3.id.to_s, @article1.id.to_s, @article2.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test positions
      expect(Article.find(@article1.id).position).to eq(2)
      expect(Article.find(@article2.id).position).to eq(1)
      expect(Article.find(@article3.id).position).to eq(3)
    end
  end
end