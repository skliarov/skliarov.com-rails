FactoryGirl.define do
  factory :chapter do
    title { Faker::Lorem.sentence(5) }
    slug { Faker::Lorem.words(8).join('-') }
    user { FactoryGirl.create(:user) }
  end
end