FactoryGirl.define do
  factory :lesson do
    title { Faker::Lorem.word }
    body { Faker::Lorem.paragraph(50) }
    user { FactoryGirl.create(:user) }
    screencast { FactoryGirl.create(:screencast) }
  end
end