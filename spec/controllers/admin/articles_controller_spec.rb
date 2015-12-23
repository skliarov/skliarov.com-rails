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
    
    describe 'POST #create' do
      context 'with valid article params' do
        before :each do
          article_params = FactoryGirl.attributes_for(:article, user: @user)
          post :create, article: article_params
          @article = Article.find_by(article_params)
        end
        it 'should create new article' do
          expect(@article).not_to eq(nil)
        end
        it 'should redirect to #show article' do
          expect(response).to redirect_to(admin_article_path(@article))
        end
      end
      
      context 'with invalid article params' do
        before :each do
          article_params = FactoryGirl.attributes_for(:article, user: @user)
          article_params[:title] = nil
          post :create, article: article_params
          @article = Article.find_by(article_params)
        end
        it 'should not create new article' do
          expect(@article).to eq(nil)
        end
        it 'should render #new' do
          expect(response).to render_template(:new)
        end
      end
    end
    
    describe 'PATCH #update' do
      context 'with valid article params' do
        before :each do
          @article = FactoryGirl.create(:article)
          patch :update, id: @article.slug, article: FactoryGirl.attributes_for(:article)
        end
        it 'should update fields of article' do
          expect(@article.title).not_to eq(Article.find(@article.id).title)
          expect(@article.body).not_to eq(Article.find(@article.id).body)
          expect(@article.preview).not_to eq(Article.find(@article.id).preview)
        end
        it 'should redirect to #show article' do
          @article.reload
          expect(response).to redirect_to(admin_article_path(@article))
        end
      end
      
      context 'with invalid article params' do
        before :each do
          @article = FactoryGirl.create(:article)
          article_params = FactoryGirl.attributes_for(:article)
          article_params[:title] = nil
          patch :update, id: @article.slug, article: article_params
        end
        it 'should not update article' do
          expect(@article.updated_at).to eq(Article.find(@article.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'PUT #update' do
      context 'with valid article params' do
        before :each do
          @article = FactoryGirl.create(:article)
          put :update, id: @article.slug, article: FactoryGirl.attributes_for(:article)
        end
        it 'should update fields of article' do
          expect(@article.title).not_to eq(Article.find(@article.id).title)
          expect(@article.body).not_to eq(Article.find(@article.id).body)
          expect(@article.preview).not_to eq(Article.find(@article.id).preview)
        end
        it 'should redirect to #show article' do
          @article.reload
          expect(response).to redirect_to(admin_article_path(@article))
        end
      end
      
      context 'with invalid article params' do
        before :each do
          @article = FactoryGirl.create(:article)
          article_params = FactoryGirl.attributes_for(:article)
          article_params[:title] = nil
          put :update, id: @article.slug, article: article_params
        end
        it 'should not update article' do
          expect(@article.updated_at).to eq(Article.find(@article.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @article = FactoryGirl.create(:article)
        delete :destroy, id: @article.slug
      end
      it 'should destroy the article' do
        articles_count = Article.where(id: @article.id).count
        expect(articles_count).to eq(0)
      end
      it 'should redirect to admin/articles#index' do
        expect(response).to redirect_to(admin_articles_path)
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @article = FactoryGirl.create(:article, published: false)
        post :publish, id: @article.slug
      end
      it 'should publish the article' do
        @article.reload
        expect(@article.published).to eq(true)
      end
      it 'should redirect to admin/articles#index' do
        expect(response).to redirect_to(admin_articles_path)
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @article = FactoryGirl.create(:article, published: true)
        post :hide, id: @article.slug
      end
      it 'should hide the article' do
        @article.reload
        expect(@article.published).to eq(false)
      end
      it 'should redirect to admin/articles#index' do
        expect(response).to redirect_to(admin_articles_path)
      end
    end
    
    describe 'POST #sort' do
      before :each do
        @article1 = @articles[0].reload
        @article2 = @articles[1].reload
        @article3 = @articles[2].reload
      end
      it 'should not touch timestamps' do
        post :sort, article: [@article3.id.to_s, @article2.id.to_s, @article1.id.to_s]
        # Make sure User is signed in
        expect(response).to be_success
        # Test timestamps
        expect(@article1.updated_at).to eq(Article.find(@article1.id).updated_at)
        expect(@article2.updated_at).to eq(Article.find(@article2.id).updated_at)
        expect(@article3.updated_at).to eq(Article.find(@article3.id).updated_at)
      end
      
      it 'should assign position to articles in reverse order' do
        post :sort, article: [@article3.id.to_s, @article1.id.to_s, @article2.id.to_s]
        # Make sure User is signed in
        expect(response).to be_success
        # Test positions
        expect(Article.find(@article1.id).position).to eq(2)
        expect(Article.find(@article2.id).position).to eq(1)
        expect(Article.find(@article3.id).position).to eq(3)
      end
    end
  end
  
  context 'user is not signed in' do
    describe 'GET #index' do
      it 'should redirect to new user session path' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #show' do
      it 'should redirect to new user session path' do
        article = @articles[0]
        get :show, id: article.slug
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #new' do
      it 'should redirect to new user session path' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #edit' do
      before :each do
        article = @articles[0]
        get :edit, id: article.slug
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #create' do
      before :each do
        article_params = FactoryGirl.attributes_for(:article, user: @user)
        post :create, article: article_params
        @article = Article.find_by(article_params)
      end
      it 'should not create new article' do
        expect(@article).to eq(nil)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PATCH #update' do
      before :each do
        @article = FactoryGirl.create(:article)
        patch :update, id: @article.slug, article: FactoryGirl.attributes_for(:article)
      end
      it 'should not update fields of article' do
        expect(@article.title).to eq(Article.find(@article.id).title)
        expect(@article.body).to eq(Article.find(@article.id).body)
        expect(@article.preview).to eq(Article.find(@article.id).preview)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PUT #update' do
      before :each do
        @article = FactoryGirl.create(:article)
        put :update, id: @article.slug, article: FactoryGirl.attributes_for(:article)
      end
      it 'should not update fields of article' do
        expect(@article.title).to eq(Article.find(@article.id).title)
        expect(@article.body).to eq(Article.find(@article.id).body)
        expect(@article.preview).to eq(Article.find(@article.id).preview)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @article = FactoryGirl.create(:article)
        delete :destroy, id: @article.slug
      end
      it 'should not destroy the article' do
        articles_count = Article.where(id: @article.id).count
        expect(articles_count).to eq(1)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @article = FactoryGirl.create(:article, published: false)
        post :publish, id: @article.slug
      end
      it 'should not publish the article' do
        @article.reload
        expect(@article.published).to eq(false)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @article = FactoryGirl.create(:article, published: true)
        post :hide, id: @article.slug
      end
      it 'should not hide the article' do
        @article.reload
        expect(@article.published).to eq(true)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #sort' do
      before :each do
        article1 = @articles[0]
        article2 = @articles[1]
        article3 = @articles[2]
        post :sort, article: [article3.id.to_s, article2.id.to_s, article1.id.to_s]
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end