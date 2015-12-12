FactoryGirl.define do
  factory :chapter do
    title { Faker::Lorem.word }
    user { FactoryGirl.create(:user) }
  end
end