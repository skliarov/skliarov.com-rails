require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do
  before :all do
    # Create User
    @user = FactoryGirl.create(:user)
    # Create demo Articles
    article1 = FactoryGirl.create(:article, published: true, user: @user)
    article2 = FactoryGirl.create(:article, published: false, user: @user)
    article3 = FactoryGirl.create(:article, published: true, user: @user)
    @articles = [article1, article2, article3]
  end
  
  describe 'GET #index' do
    context 'user is signed in' do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in :user, @user
      end
      
      it 'should return valid response' do
        # Execute action
        get :index
        # Check results
        expect(response).to be_success
        expect(response).to render_template(:index)
        expect(response.content_type).to eq('text/html')
      end
    end
    
    context 'user is not signed in' do
      it 'should redirect to new user session path' do
        # Execute action
        get :index
        # Check result
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  describe 'GET #show' do
    context 'user is signed in' do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in :user, @user
      end
      
      it 'should return valid response' do
        # Get reference to article
        article = @articles[0]
        # Execute request
        get :show, id: article.slug
        # Check results
        expect(response).to be_success
        expect(response).to render_template(:show)
        expect(response.content_type).to eq('text/html')
      end
    end
    
    context 'user is not signed in' do
      it 'should redirect to new user session path' do
        # Get reference to article
        article = @articles[1]
        # Execute request
        get :show, id: article.slug
        # Check results
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  describe 'POST #sort' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, @user
    end
    
    it 'should not touch timestamps' do
      # Get references to articles
      article1 = @articles[0]
      article2 = @articles[1]
      article3 = @articles[2]
      # Execute action
      post :sort, article: [article3.id.to_s, article2.id.to_s, article1.id.to_s]
      # Make sure User is signed in
      expect(response).to be_success
      # Test timestamps
      expect(article1.updated_at).to eq(Article.find(article1.id).updated_at)
      expect(article2.updated_at).to eq(Article.find(article2.id).updated_at)
      expect(article3.updated_at).to eq(Article.find(article3.id).updated_at)
    end
    
    it 'should assign position to articles in reverse order' do
      # Get references to articles
      article1 = @articles[0]
      article2 = @articles[1]
      article3 = @articles[2]
      # Execute action
      post :sort, article: [article3.id.to_s, article1.id.to_s, article2.id.to_s]
      # Make sure User is signed in
      expect(response).to be_success
      # Test positions
      expect(Article.find(article1.id).position).to eq(2)
      expect(Article.find(article2.id).position).to eq(1)
      expect(Article.find(article3.id).position).to eq(3)
    end
  end
end