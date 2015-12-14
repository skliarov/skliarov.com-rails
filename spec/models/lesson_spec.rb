require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:lesson)).to be_valid
  end
  
  context 'relations' do
    it { should belong_to(:screencast) }
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    context 'fields' do
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title).scoped_to(:screencast_id) }
      it { should validate_presence_of(:body) }
      it 'should require slug to be set' do
        lesson = FactoryGirl.create(:lesson)
        lesson.slug = nil
        lesson.save
        expect(lesson.slug).not_to eq(nil)
      end
      FactoryGirl.create(:lesson) do
        it { should validate_uniqueness_of(:slug) }
      end
    end
    
    context 'relations' do
      it { should validate_presence_of(:screencast) }
      it { should validate_presence_of(:user) }
    end
  end
end