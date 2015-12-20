require 'rails_helper'

RSpec.describe Admin::LessonsController, type: :controller do
  describe 'POST #sort' do
    before :all do
      # Create user
      @user = FactoryGirl.create(:user)
      screencast = FactoryGirl.create(:screencast, user: @user)
      
      # Create lessons
      @lesson1 = FactoryGirl.create(:lesson, user: @user, screencast: screencast)
      @lesson2 = FactoryGirl.create(:lesson, user: @user, screencast: screencast)
      @lesson3 = FactoryGirl.create(:lesson, user: @user, screencast: screencast)
    end
    
    before :each do
      sign_in :user, @user
    end
    
    it 'should not touch timestamps' do
      post :sort, lesson: [@lesson3.id.to_s, @lesson2.id.to_s, @lesson1.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test timestamps
      expect(@lesson1.updated_at).to eq(Lesson.find(@lesson1.id).updated_at)
      expect(@lesson2.updated_at).to eq(Lesson.find(@lesson2.id).updated_at)
      expect(@lesson3.updated_at).to eq(Lesson.find(@lesson3.id).updated_at)
    end
    
    it 'should assign position to lessons in straight order' do
      post :sort, lesson: [@lesson3.id.to_s, @lesson1.id.to_s, @lesson2.id.to_s]
      # Make sure user signed in
      expect(response.status).to eq(200)
      # Test positions
      expect(Lesson.find(@lesson1.id).position).to eq(2)
      expect(Lesson.find(@lesson2.id).position).to eq(3)
      expect(Lesson.find(@lesson3.id).position).to eq(1)
    end
  end
end