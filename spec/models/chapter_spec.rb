require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:chapter)).to be_valid
  end
  
  context 'relations' do
    it { should have_many(:screencasts).dependent(:destroy) }
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    context 'fields' do
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title) }
      it 'should require slug to be set' do
        chapter = FactoryGirl.create(:chapter)
        chapter.slug = nil
        chapter.save
        expect(chapter.slug).not_to eq(nil)
      end
      it { should validate_uniqueness_of(:slug) }
      it 'should validate format of slug to contain only lower case letters, numbers and dashes' do
        should allow_value('some-slug-goes-here').for(:slug)
        should_not allow_value('some.slug.goes.here').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
        should_not allow_value('some_slug_goes_here').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
        should_not allow_value('Some-Slug-Goes-HERE').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
        should_not allow_value('some/slug/goes/here').for(:slug).with_message('Only lower case letters, numbers and dashes are allowed')
      end
    end
    
    context 'relations' do
      it { should validate_presence_of(:user) }
    end
  end
end