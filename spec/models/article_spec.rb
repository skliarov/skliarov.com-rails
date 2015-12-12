require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:article)).to be_valid
  end
  
  context 'relations' do
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    # Fields
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:preview) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:keywords) }
    it { should validate_presence_of(:description) }
    it 'should validate presense of slug' do
      article = FactoryGirl.create(:article)
      article.slug = nil
      article.save
      expect(article.slug).not_to eq(nil)
    end
    FactoryGirl.create(:article) do
      it { should validate_uniqueness_of(:slug) }
    end
    
    # Relations
    context 'relations' do
      it { should validate_presence_of(:user) }
    end
  end
end