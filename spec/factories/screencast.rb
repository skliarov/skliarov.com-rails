FactoryGirl.define do
  factory :screencast do
    title { Faker::Lorem.sentence(5) }
    body { Faker::Lorem.paragraph(50) }
    user { FactoryGirl.create(:user) }
    chapter { FactoryGirl.create(:chapter) }
  end
end