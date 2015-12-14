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
    end
    
    context 'relations' do
      it { should validate_presence_of(:chapter) }
      it { should validate_presence_of(:user) }
    end
  end
end