require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:lesson)).to be_valid
  end
  
  context 'relations' do
    it { should belong_to(:screencast) }
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    # Fields
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it 'should validate presense of slug' do
      lesson = FactoryGirl.create(:lesson)
      lesson.slug = nil
      lesson.save
      expect(lesson.slug).not_to eq(nil)
    end
    FactoryGirl.create(:lesson) do
      it { should validate_uniqueness_of(:slug) }
    end
    
    # Relations
    context 'relations' do
      it { should validate_presence_of(:screencast) }
      it { should validate_presence_of(:user) }
    end
  end
end