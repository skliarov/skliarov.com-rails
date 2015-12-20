require 'rails_helper'

RSpec.describe Screencast, type: :model do
  it 'should have a valid factory' do
    expect(FactoryGirl.create(:screencast)).to be_valid
  end
  
  context 'relations' do
    it { should have_many(:lessons).dependent(:destroy) }
    it { should belong_to(:chapter) }
    it { should belong_to(:user) }
  end
  
  context 'validations' do
    context 'fields' do
      it { should validate_presence_of(:title) }
      it { should validate_uniqueness_of(:title).scoped_to(:chapter_id) }
      it { should validate_presence_of(:body) }
      it 'should require slug to be set' do
        screencast = FactoryGirl.create(:screencast)
        screencast.slug = nil
        screencast.save
        expect(screencast.slug).not_to eq(nil)
      end
      FactoryGirl.create(:screencast) do
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
      it { should validate_presence_of(:chapter) }
      it { should validate_presence_of(:user) }
    end
  end
end