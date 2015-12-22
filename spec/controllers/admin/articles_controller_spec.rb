require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do
  before :all do
    # Create User
    @user = FactoryGirl.create(:user)
    # Create test articles
    article1 = FactoryGirl.create(:article, published: true, user: @user)
    article2 = FactoryGirl.create(:article, published: false, user: @user)
    article3 = FactoryGirl.create(:article, published: true, user: @user)
    @articles = [article1, article2, article3]
  end
  
  context 'user is signed in' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, @user
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
        article = @articles[0]
        get :show, id: article.slug
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
    
    describe 'GET #new' do
      before :each do
        get :new
      end
      it 'should have successful response status' do
        expect(response).to be_success
      end
      it 'should have valid content-type' do
        expect(response.content_type).to eq('text/html')
      end
      it 'should render #new view' do
        expect(response).to render_template(:new)
      end
    end
    
    describe 'GET #edit' do
      before :each do
        article = @articles[0]
        get :edit, id: article.slug
      end
      it 'should have successful response status' do
        expect(response).to be_success
      end
      it 'should have valid content-type' do
        expect(response.content_type).to eq('text/html')
      end
      it 'should render #edit view' do
        expect(response).to render_template(:edit)
      end
    end
    
    describe 'POST #sort' do
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
  
  context 'user is not signed in' do
    describe 'GET #index' do
      it 'should redirect to new user session path' do
        # Execute action
        get :index
        # Check result
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #show' do
      it 'should redirect to new user session path' do
        # Get reference to article
        article = @articles[1]
        # Execute request
        get :show, id: article.slug
        # Check results
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #new' do
      it 'should redirect to new user session path' do
        # Execute action
        get :new
        # Check result
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #edit' do
      it 'should redirect to new user session path' do
        # Get reference to article
        article = @articles[1]
        # Execute request
        get :edit, id: article.slug
        # Check results
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #sort' do
      it 'should redirect to new user session path' do
        # Get references to articles
        article1 = @articles[0]
        article2 = @articles[1]
        article3 = @articles[2]
        # Execute action
        post :sort, article: [article3.id.to_s, article2.id.to_s, article1.id.to_s]
        # Check results
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end