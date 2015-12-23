require 'rails_helper'

RSpec.describe Admin::LessonsController, type: :controller do
  before :all do
    # Create User
    @user = FactoryGirl.create(:user)
    @screencast = FactoryGirl.create(:screencast, user: @user)
    # Create test screencasts
    lesson1 = FactoryGirl.create(:lesson, user: @user, screencast: @screencast, published: true)
    lesson2 = FactoryGirl.create(:lesson, user: @user, screencast: @screencast, published: false)
    lesson3 = FactoryGirl.create(:lesson, user: @user, screencast: @screencast, published: true)
    @lessons = [lesson1, lesson2, lesson3]
  end
  
  context 'user is signed in' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, @user
    end
    
    describe 'GET #show' do
      before :each do
        lesson = @lessons[0]
        get :show, id: lesson.slug
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
        get :new, screencast_id: @screencast.id
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
        lesson = @lessons[0]
        get :edit, id: lesson.slug
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
      context 'with valid lesson params' do
        before :each do
          lesson_params = FactoryGirl.attributes_for(:lesson, user: nil, screencast: nil)
          lesson_params[:screencast_id] = @screencast.id
          post :create, lesson: lesson_params
          @lesson = Lesson.find_by(slug: lesson_params[:slug])
        end
        it 'should create new lesson' do
          expect(@lesson).not_to eq(nil)
        end
        it 'should assign current user as author' do
          expect(@lesson.user).to eq(@user)
        end
        it 'should redirect to #show lesson' do
          expect(response).to redirect_to(admin_lesson_path(@lesson))
        end
      end
      
      context 'with invalid lesson params' do
        before :each do
          lesson_params = FactoryGirl.attributes_for(:lesson, user: @user)
          lesson_params[:title] = nil
          post :create, lesson: lesson_params
          @lesson = Lesson.find_by(lesson_params)
        end
        it 'should not create new lesson' do
          expect(@lesson).to eq(nil)
        end
        it 'should render #new' do
          expect(response).to render_template(:new)
        end
      end
    end
    
    describe 'PATCH #update' do
      context 'with valid lesson params' do
        before :each do
          @lesson = FactoryGirl.create(:lesson, user: @user, screencast: @screencast)
          patch :update, id: @lesson.slug, lesson: FactoryGirl.attributes_for(:lesson)
        end
        it 'should update fields of lesson' do
          expect(@lesson.title).not_to eq(Lesson.find(@lesson.id).title)
          expect(@lesson.body).not_to eq(Lesson.find(@lesson.id).body)
        end
        it 'should redirect to #show lesson' do
          @lesson.reload
          expect(response).to redirect_to(admin_lesson_path(@lesson))
        end
      end
      
      context 'with invalid lesson params' do
        before :each do
          @lesson = FactoryGirl.create(:lesson, user: @user, screencast: @screencast)
          lesson_params = FactoryGirl.attributes_for(:lesson)
          lesson_params[:title] = nil
          patch :update, id: @lesson.slug, lesson: lesson_params
        end
        it 'should not update lesson' do
          expect(@lesson.updated_at).to eq(Lesson.find(@lesson.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'PUT #update' do
      context 'with valid lesson params' do
        before :each do
          @lesson = FactoryGirl.create(:lesson, user: @user, screencast: @screencast)
          put :update, id: @lesson.slug, lesson: FactoryGirl.attributes_for(:lesson)
        end
        it 'should update fields of lesson' do
          expect(@lesson.title).not_to eq(Lesson.find(@lesson.id).title)
          expect(@lesson.body).not_to eq(Lesson.find(@lesson.id).body)
        end
        it 'should redirect to #show lesson' do
          @lesson.reload
          expect(response).to redirect_to(admin_lesson_path(@lesson))
        end
      end
      
      context 'with invalid lesson params' do
        before :each do
          @lesson = FactoryGirl.create(:lesson, user: @user, screencast: @screencast)
          lesson_params = FactoryGirl.attributes_for(:lesson)
          lesson_params[:title] = nil
          put :update, id: @lesson.slug, lesson: lesson_params
        end
        it 'should not update lesson' do
          expect(@lesson.updated_at).to eq(Lesson.find(@lesson.id).updated_at)
        end
        it 'should render #edit' do
          expect(response).to render_template(:edit)
        end
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @lesson = FactoryGirl.create(:lesson)
        delete :destroy, id: @lesson.slug
      end
      it 'should destroy the lesson' do
        lessons_count = Lesson.where(id: @lesson.id).count
        expect(lessons_count).to eq(0)
      end
      it 'should redirect to admin/screencasts#show' do
        expect(response).to redirect_to(admin_screencast_path(@lesson.screencast))
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @lesson = FactoryGirl.create(:lesson, published: false)
        post :publish, id: @lesson.slug
      end
      it 'should publish the lesson' do
        @lesson.reload
        expect(@lesson.published).to eq(true)
      end
      it 'should redirect to admin/screencasts#show' do
        expect(response).to redirect_to(admin_screencast_path(@lesson.screencast))
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @lesson = FactoryGirl.create(:lesson, published: true)
        post :hide, id: @lesson.slug
      end
      it 'should hide the lesson' do
        @lesson.reload
        expect(@lesson.published).to eq(false)
      end
      it 'should redirect to admin/screencasts#show' do
        expect(response).to redirect_to(admin_screencast_path(@lesson.screencast))
      end
    end
    
    describe 'POST #sort' do
      before :each do
        @lesson1 = @lessons[0].reload
        @lesson2 = @lessons[1].reload
        @lesson3 = @lessons[2].reload
      end
      it 'should not touch timestamps' do
        post :sort, lesson: [@lesson3.id.to_s, @lesson2.id.to_s, @lesson1.id.to_s]
        # Make sure user signed in
        expect(response).to be_success
        # Test timestamps
        expect(@lesson1.updated_at).to eq(Lesson.find(@lesson1.id).updated_at)
        expect(@lesson2.updated_at).to eq(Lesson.find(@lesson2.id).updated_at)
        expect(@lesson3.updated_at).to eq(Lesson.find(@lesson3.id).updated_at)
      end
      it 'should assign position to lessons in straight order' do
        post :sort, lesson: [@lesson3.id.to_s, @lesson1.id.to_s, @lesson2.id.to_s]
        # Make sure user signed in
        expect(response).to be_success
        # Test positions
        expect(Lesson.find(@lesson1.id).position).to eq(2)
        expect(Lesson.find(@lesson2.id).position).to eq(3)
        expect(Lesson.find(@lesson3.id).position).to eq(1)
      end
    end
  end
  
  context 'user is not signed in' do
    describe 'GET #show' do
      it 'should redirect to new user session path' do
        lesson = @lessons[0]
        get :show, id: lesson.slug
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #new' do
      it 'should redirect to new user session path' do
        get :new, screencast_id: @screencast.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'GET #edit' do
      before :each do
        lesson = @lessons[0]
        get :edit, id: lesson.slug
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #create' do
      before :each do
        lesson_params = FactoryGirl.attributes_for(:lesson, user: nil)
        post :create, lesson: lesson_params
        @lesson = Lesson.find_by(lesson_params)
      end
      it 'should not create new lesson' do
        expect(@lesson).to eq(nil)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PATCH #update' do
      before :each do
        @lesson = FactoryGirl.create(:lesson)
        patch :update, id: @lesson.slug, lesson: FactoryGirl.attributes_for(:lesson)
      end
      it 'should not update fields of lesson' do
        expect(@lesson.title).to eq(Lesson.find(@lesson.id).title)
        expect(@lesson.body).to eq(Lesson.find(@lesson.id).body)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'PUT #update' do
      before :each do
        @lesson = FactoryGirl.create(:lesson)
        put :update, id: @lesson.slug, lesson: FactoryGirl.attributes_for(:lesson)
      end
      it 'should not update fields of lesson' do
        expect(@lesson.title).to eq(Lesson.find(@lesson.id).title)
        expect(@lesson.body).to eq(Lesson.find(@lesson.id).body)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'DELETE #destroy' do
      before :each do
        @lesson = FactoryGirl.create(:lesson)
        delete :destroy, id: @lesson.slug
      end
      it 'should not destroy the lesson' do
        lessons_count = Lesson.where(id: @lesson.id).count
        expect(lessons_count).to eq(1)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #publish' do
      before :each do
        @lesson = FactoryGirl.create(:lesson, published: false)
        post :publish, id: @lesson.slug
      end
      it 'should not publish the lesson' do
        @lesson.reload
        expect(@lesson.published).to eq(false)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #hide' do
      before :each do
        @lesson = FactoryGirl.create(:lesson, published: true)
        post :hide, id: @lesson.slug
      end
      it 'should not hide the lesson' do
        @lesson.reload
        expect(@lesson.published).to eq(true)
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe 'POST #sort' do
      before :each do
        lesson1 = @lessons[0]
        lesson2 = @lessons[1]
        lesson3 = @lessons[2]
        post :sort, lesson: [lesson3.id.to_s, lesson2.id.to_s, lesson1.id.to_s]
      end
      it 'should redirect to new user session path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end