FactoryGirl.define do
  factory :chapter do
    title { Faker::Lorem.sentence(5) }
    user { FactoryGirl.create(:user) }
  end
end