require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  before :all do
    @lesson = FactoryGirl.create(:lesson, published: true)
  end
  
  describe 'GET #show' do
    before :each do
      get :show, screencast_id: @lesson.screencast.slug, id: @lesson.slug
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