require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do
  
  describe 'POST #sort' do
    before(:all) do
      # Create articles
      user = FactoryGirl.create(:user)
      login_as user, scope: :user
      @article1 = FactoryGirl.create(:article, published: true, user: user)
      @article2 = FactoryGirl.create(:article, published: true, user: user)
      @article3 = FactoryGirl.create(:article, published: true, user: user)
    end
    
    it 'should assign position to articles in reverse order' do
      post :sort, article: [@article3.id.to_s, @article1.id.to_s, @article2.id.to_s]
      
      # Reload articles
      @article1.reload
      @article2.reload
      @article3.reload
      
      expect(response.status).to eq(200)
      expect(@article1.position).to eq(2)
      expect(@article2.position).to eq(1)
      expect(@article3.position).to eq(3)
    end
  end
end