require 'rails_helper'

RSpec.describe Admin::ChaptersController, type: :controller do
  before :all do
    # Create User
    @user = FactoryGirl.create(:user)
    # Create test chapters
    chapter1 = FactoryGirl.create(:chapter, user: @user, published: true)
    chapter2 = FactoryGirl.create(:chapter, user: @user, published: false)
    chapter3 = FactoryGirl.create(:chapter, user: @user, published: true)
    @chapters = [chapter1, chapter2, chapter3]
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
        chapter = @chapters[0]
        get :show, id: chapter.slug
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
        chapter = @chapters[0]
        get :edit, id: chapter.slug
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
      context 'with valid chapter params' do
        before :each do
          chapter_params = FactoryGirl.attributes_for(:chapter, user: @user)
          post :create, chapter: chapter_params
          @chapter = Chapter.find_by(chapter_params)
        end
        it 'should create new chapter' do
          expect(@chapter).not_to eq(nil)
        end
        it 'should redirect to #show chapter' do
          expect(response).to redirect_to(admin_chapter_path(@chapter))
        end
      end
      
      context 'with invalid chapter params' do
        before :each do
          chapter_params = FactoryGirl.attributes_for(:chapter, user: @user)
          chapter_params[:title] = nil
          post :create, chapter: chapter_params
          @chapter = Chapter.find_by(chapter_params)
        end
        it 'should not create new chapter' do
          expect(@chapter).to eq(nil)
        end
        it 'should render #new' do
          expect(response).to render_template(:new)
        end
      end
    end
    
    describe 'PATCH #update' do
      context 'with valid chapter params' do
        before :each do
          @chapter = FactoryGirl.create(:chapter)
          patch :update, id: @chapter.slug, chapter: FactoryGirl.attributes_for(:chapter)
        end
        it 'should update fields of chapter' do
          expect(@chapter.title).not_to eq(Chapter.find(@chapter.id).title)
        end
        it 'should redirect to #show chapter' do
          @chapter.reload
          expect(response).to redirect_to(admin_chapter_path(@chapter))
        end
      end
      
      context 'with invalid chapter params' do
        before :each do
          @chapter = FactoryGirl.create(:chapter)
          chapter_params = FactoryGirl.attributes_for(:chapter)
          chapter_params[:title] = nil
          patch :update, id: @chapter.slug, chapter: chapter_params
        end
        it 'should not update chapter' do
          expect(@chapter.updated_at).to eq(Chapter.find(@chapter.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'PUT #update' do
      context 'with valid chapter params' do
        before :each do
          @chapter = FactoryGirl.create(:chapter)
          put :update, id: @chapter.slug, chapter: FactoryGirl.attributes_for(:chapter)
        end
        it 'should update fields of chapter' do
          expect(@chapter.title).not_to eq(Chapter.find(@chapter.id).title)
        end
        it 'should redirect to #show chapter' do
          @chapter.reload
          expect(response).to redirect_to(admin_chapter_path(@chapter))
        end
      end
      
      context 'with invalid chapter params' do
        before :each do
          @chapter = FactoryGirl.create(:chapter)
          chapter_params = FactoryGirl.attributes_for(:chapter)
          chapter_params[:title] = nil
          put :update, id: @chapter.slug, chapter: chapter_params
        end
        it 'should not update chapter' do
          expect(@chapter.updated_at).to eq(Chapter.find(@chapter.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @chapter = FactoryGirl.create(:chapter)
        delete :destroy, id: @chapter.slug
      end
      it 'should destroy the chapter' do
        chapters_count = Chapter.where(id: @chapter.id).count
        expect(chapters_count).to eq(0)
      end
      it 'should redirect to admin/chapters#index' do
        expect(response).to redirect_to(admin_chapters_path)
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @chapter = FactoryGirl.create(:chapter, published: false)
        post :publish, id: @chapter.slug
      end
      it 'should publish the chapter' do
        @chapter.reload
        expect(@chapter.published).to eq(true)
      end
      it 'should redirect to admin/chapters#index' do
        expect(response).to redirect_to(admin_chapters_path)
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @chapter = FactoryGirl.create(:chapter, published: true)
        post :hide, id: @chapter.slug
      end
      it 'should hide the chapter' do
        @chapter.reload
        expect(@chapter.published).to eq(false)
      end
      it 'should redirect to admin/chapters#index' do
        expect(response).to redirect_to(admin_chapters_path)
      end
    end
    
    describe 'POST #sort' do
      it 'should not touch timestamps' do
        # Get references to chapters
        chapter1 = @chapters[0].reload
        chapter2 = @chapters[1].reload
        chapter3 = @chapters[2].reload
        # Execute action
        post :sort, chapter: [chapter3.id.to_s, chapter2.id.to_s, chapter1.id.to_s]
        # Make sure User is signed in
        expect(response).to be_success
        # Test timestamps
        expect(chapter1.updated_at).to eq(Chapter.find(chapter1.id).updated_at)
        expect(chapter2.updated_at).to eq(Chapter.find(chapter2.id).updated_at)
        expect(chapter3.updated_at).to eq(Chapter.find(chapter3.id).updated_at)
      end
      
      it 'should assign position to chapters in straight order' do
        # Get references to chapters
        chapter1 = @chapters[0].reload
        chapter2 = @chapters[1].reload
        chapter3 = @chapters[2].reload
        # Execute action
        post :sort, chapter: [chapter3.id.to_s, chapter1.id.to_s, chapter2.id.to_s]
        # Make sure User is signed in
        expect(response).to be_success
        # Test positions
        expect(Chapter.find(chapter1.id).position).to eq(2)
        expect(Chapter.find(chapter2.id).position).to eq(3)
        expect(Chapter.find(chapter3.id).position).to eq(1)
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
        chapter = @chapters[0]
        get :show, id: chapter.slug
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
        chapter = @chapters[0]
        get :edit, id: chapter.slug
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #create' do
      before :each do
        chapter_params = FactoryGirl.attributes_for(:chapter, user: @user)
        post :create, chapter: chapter_params
        @chapter = Chapter.find_by(chapter_params)
      end
      it 'should not create new chapter' do
        expect(@chapter).to eq(nil)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PATCH #update' do
      before :each do
        @chapter = FactoryGirl.create(:chapter)
        patch :update, id: @chapter.slug, chapter: FactoryGirl.attributes_for(:chapter)
      end
      it 'should not update fields of chapter' do
        expect(@chapter.title).to eq(Chapter.find(@chapter.id).title)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PUT #update' do
      before :each do
        @chapter = FactoryGirl.create(:chapter)
        put :update, id: @chapter.slug, chapter: FactoryGirl.attributes_for(:chapter)
      end
      it 'should not update fields of chapter' do
        expect(@chapter.title).to eq(Chapter.find(@chapter.id).title)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @chapter = FactoryGirl.create(:chapter)
        delete :destroy, id: @chapter.slug
      end
      it 'should not destroy the chapter' do
        chapters_count = Chapter.where(id: @chapter.id).count
        expect(chapters_count).to eq(1)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @chapter = FactoryGirl.create(:chapter, published: false)
        post :publish, id: @chapter.slug
      end
      it 'should not publish the chapter' do
        @chapter.reload
        expect(@chapter.published).to eq(false)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @chapter = FactoryGirl.create(:chapter, published: true)
        post :hide, id: @chapter.slug
      end
      it 'should not hide the chapter' do
        @chapter.reload
        expect(@chapter.published).to eq(true)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #sort' do
      before :each do
        chapter1 = @chapters[0]
        chapter2 = @chapters[1]
        chapter3 = @chapters[2]
        post :sort, chapter: [chapter3.id.to_s, chapter2.id.to_s, chapter1.id.to_s]
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end