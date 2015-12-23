require 'rails_helper'

RSpec.describe Admin::ScreencastsController, type: :controller do
  before :all do
    # Create User
    @user = FactoryGirl.create(:user)
    @chapter = FactoryGirl.create(:chapter, user: @user)
    # Create test screencasts
    screencast1 = FactoryGirl.create(:screencast, user: @user, chapter: @chapter, published: true)
    screencast2 = FactoryGirl.create(:screencast, user: @user, chapter: @chapter, published: false)
    screencast3 = FactoryGirl.create(:screencast, user: @user, chapter: @chapter, published: true)
    @screencasts = [screencast1, screencast2, screencast3]
  end
  
  context 'user is signed in' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, @user
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
    
    describe 'GET #new' do
      before :each do
        get :new, chapter_id: @chapter.id
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
        screencast = @screencasts[0]
        get :edit, id: screencast.slug
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
      context 'with valid screencast params' do
        before :each do
          screencast_params = FactoryGirl.attributes_for(:screencast)
          screencast_params[:chapter_id] = @chapter.id
          post :create, screencast: screencast_params
          @screencast = Screencast.find_by(slug: screencast_params[:slug])
        end
        it 'should create new screencast' do
          expect(@screencast).not_to eq(nil)
        end
        it 'should redirect to #show screencast' do
          expect(response).to redirect_to(admin_screencast_path(@screencast))
        end
      end
      
      context 'with invalid screencast params' do
        before :each do
          screencast_params = FactoryGirl.attributes_for(:screencast, user: @user, chapter: @chapter)
          screencast_params[:title] = nil
          post :create, screencast: screencast_params
          @screencast = Screencast.find_by(screencast_params)
        end
        it 'should not create new screencast' do
          expect(@screencast).to eq(nil)
        end
        it 'should render #new' do
          expect(response).to render_template(:new)
        end
      end
    end
    
    describe 'PATCH #update' do
      context 'with valid screencast params' do
        before :each do
          @screencast = FactoryGirl.create(:screencast, user: @user, chapter: @chapter)
          patch :update, id: @screencast.slug, screencast: FactoryGirl.attributes_for(:screencast)
        end
        it 'should update fields of screencast' do
          expect(@screencast.title).not_to eq(Screencast.find(@screencast.id).title)
          expect(@screencast.slug).not_to eq(Screencast.find(@screencast.id).slug)
        end
        it 'should redirect to #show screencast' do
          @screencast.reload
          expect(response).to redirect_to(admin_screencast_path(@screencast))
        end
      end
      
      context 'with invalid screencast params' do
        before :each do
          @screencast = FactoryGirl.create(:screencast)
          screencast_params = FactoryGirl.attributes_for(:screencast)
          screencast_params[:title] = nil
          patch :update, id: @screencast.slug, screencast: screencast_params
        end
        it 'should not update screencast' do
          expect(@screencast.updated_at).to eq(Screencast.find(@screencast.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'PUT #update' do
      context 'with valid screencast params' do
        before :each do
          @screencast = FactoryGirl.create(:screencast, user: @user, chapter: @chapter)
          put :update, id: @screencast.slug, screencast: FactoryGirl.attributes_for(:screencast)
        end
        it 'should update fields of screencast' do
          expect(@screencast.title).not_to eq(Screencast.find(@screencast.id).title)
          expect(@screencast.slug).not_to eq(Screencast.find(@screencast.id).slug)
        end
        it 'should redirect to #show screencast' do
          @screencast.reload
          expect(response).to redirect_to(admin_screencast_path(@screencast))
        end
      end
      
      context 'with invalid screencast params' do
        before :each do
          @screencast = FactoryGirl.create(:screencast)
          screencast_params = FactoryGirl.attributes_for(:screencast)
          screencast_params[:title] = nil
          put :update, id: @screencast.slug, screencast: screencast_params
        end
        it 'should not update screencast' do
          expect(@screencast.updated_at).to eq(Screencast.find(@screencast.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @screencast = FactoryGirl.create(:screencast, chapter: @chapter)
        delete :destroy, id: @screencast.slug
      end
      it 'should destroy the screencast' do
        screencasts_count = Screencast.where(id: @screencast.id).count
        expect(screencasts_count).to eq(0)
      end
      it 'should redirect to admin/screencasts#index' do
        expect(response).to redirect_to(admin_chapter_path(@chapter))
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @screencast = FactoryGirl.create(:screencast, chapter: @chapter, published: false)
        post :publish, id: @screencast.slug
      end
      it 'should publish the screencast' do
        @screencast.reload
        expect(@screencast.published).to eq(true)
      end
      it 'should redirect to admin/screencasts#index' do
        expect(response).to redirect_to(admin_chapter_path(@chapter))
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @screencast = FactoryGirl.create(:screencast, chapter: @chapter, published: true)
        post :hide, id: @screencast.slug
      end
      it 'should hide the screencast' do
        @screencast.reload
        expect(@screencast.published).to eq(false)
      end
      it 'should redirect to admin/screencasts#index' do
        expect(response).to redirect_to(admin_chapter_path(@chapter))
      end
    end
    
    describe 'POST #sort' do
      before :each do
        @screencast1 = @screencasts[0].reload
        @screencast2 = @screencasts[1].reload
        @screencast3 = @screencasts[2].reload
      end
      it 'should not touch timestamps' do
        post :sort, screencast: [@screencast3.id.to_s, @screencast2.id.to_s, @screencast1.id.to_s]
        # Make sure User is signed in
        expect(response).to be_success
        # Test timestamps
        expect(@screencast1.updated_at).to eq(Screencast.find(@screencast1.id).updated_at)
        expect(@screencast2.updated_at).to eq(Screencast.find(@screencast2.id).updated_at)
        expect(@screencast3.updated_at).to eq(Screencast.find(@screencast3.id).updated_at)
      end
      it 'should assign position to screencasts in straight order' do
        post :sort, screencast: [@screencast3.id.to_s, @screencast1.id.to_s, @screencast2.id.to_s]
        # Make sure User is signed in
        expect(response).to be_success
        # Test positions
        expect(Screencast.find(@screencast1.id).position).to eq(2)
        expect(Screencast.find(@screencast2.id).position).to eq(3)
        expect(Screencast.find(@screencast3.id).position).to eq(1)
      end
    end
  end
  
  context 'user is not signed in' do
    describe 'GET #show' do
      it 'should redirect to new user session path' do
        screencast = @screencasts[0]
        get :show, id: screencast.slug
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #new' do
      it 'should redirect to new user session path' do
        get :new, chapter_id: @chapter.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #edit' do
      before :each do
        screencast = @screencasts[0]
        get :edit, id: screencast.slug
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #create' do
      before :each do
        screencast_params = FactoryGirl.attributes_for(:screencast, user: @user)
        post :create, screencast: screencast_params
        @screencast = Screencast.find_by(screencast_params)
      end
      it 'should not create new screencast' do
        expect(@screencast).to eq(nil)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PATCH #update' do
      before :each do
        @screencast = FactoryGirl.create(:screencast)
        patch :update, id: @screencast.slug, screencast: FactoryGirl.attributes_for(:screencast)
      end
      it 'should not update fields of screencast' do
        expect(@screencast.title).to eq(Screencast.find(@screencast.id).title)
        expect(@screencast.body).to eq(Screencast.find(@screencast.id).body)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PUT #update' do
      before :each do
        @screencast = FactoryGirl.create(:screencast)
        put :update, id: @screencast.slug, screencast: FactoryGirl.attributes_for(:screencast)
      end
      it 'should not update fields of screencast' do
        expect(@screencast.title).to eq(Screencast.find(@screencast.id).title)
        expect(@screencast.body).to eq(Screencast.find(@screencast.id).body)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @screencast = FactoryGirl.create(:screencast)
        delete :destroy, id: @screencast.slug
      end
      it 'should not destroy the screencast' do
        screencasts_count = Screencast.where(id: @screencast.id).count
        expect(screencasts_count).to eq(1)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @screencast = FactoryGirl.create(:screencast, published: false)
        post :publish, id: @screencast.slug
      end
      it 'should not publish the screencast' do
        @screencast.reload
        expect(@screencast.published).to eq(false)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @screencast = FactoryGirl.create(:screencast, published: true)
        post :hide, id: @screencast.slug
      end
      it 'should not hide the screencast' do
        @screencast.reload
        expect(@screencast.published).to eq(true)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #sort' do
      before :each do
        screencast1 = @screencasts[0]
        screencast2 = @screencasts[1]
        screencast3 = @screencasts[2]
        post :sort, screencast: [screencast3.id.to_s, screencast2.id.to_s, screencast1.id.to_s]
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end