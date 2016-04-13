require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:article)).to be_valid
  end
  
  context 'relations' do
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    context 'fields' do
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
      it { should validate_presence_of(:slug) }
      it { should validate_uniqueness_of(:slug) }
      it { should validate_presence_of(:preview) }
      it { should validate_presence_of(:body) }
      it { should validate_presence_of(:keywords) }
      it { should validate_presence_of(:description) }
    end
    
    context 'relations' do
      it { should validate_presence_of(:user) }
    end
  end
  
  context 'set default position on create' do
    it 'should set position to be last in the list' do
      Article.destroy_all
      article1 = FactoryGirl.create(:article, published: true)
      article2 = FactoryGirl.create(:article, published: false)
      article3 = FactoryGirl.create(:article, published: true)
      
      expect(article1.position).to eq(1)
      expect(article2.position).to eq(2)
      expect(article3.position).to eq(3)
    end
  end
end