FactoryGirl.define do
  factory :lesson do
    title { Faker::Lorem.sentence(5) }
    slug { Faker::Lorem.words(8).join('-') }
    body { Faker::Lorem.paragraph(50) }
    user { FactoryGirl.create(:user) }
    screencast { FactoryGirl.create(:screencast) }
  end
end