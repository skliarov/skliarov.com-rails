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
      it 'should validate format of slug to contain only lower case letters, numbers and dashes' do
        should allow_value('some-slug-goes-here').for(:slug)
        should_not allow_value('some.slug.goes.here').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
        should_not allow_value('some_slug_goes_here').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
        should_not allow_value('Some-Slug-Goes-HERE').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
        should_not allow_value('some/slug/goes/here').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
      end
    end
    
    context 'relations' do
      it { should validate_presence_of(:screencast) }
      it { should validate_presence_of(:user) }
    end
  end
  
  context 'set default position on create' do
    it 'should set position to be last in the list' do
      screencast = FactoryGirl.create(:screencast)
      lesson1 = FactoryGirl.create(:lesson, published: true, screencast: screencast)
      lesson2 = FactoryGirl.create(:lesson, published: false, screencast: screencast)
      lesson3 = FactoryGirl.create(:lesson, published: true, screencast: screencast)
      
      expect(lesson1.position).to eq(1)
      expect(lesson2.position).to eq(2)
      expect(lesson3.position).to eq(3)
    end
  end
end