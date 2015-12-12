require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  
  context 'relations' do
    it { should have_many(:articles).dependent(:destroy) }
    it { should have_many(:chapters).dependent(:destroy) }
    it { should have_many(:screencasts).dependent(:destroy) }
    it { should have_many(:lessons).dependent(:destroy) }
  end
end