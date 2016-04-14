FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence(5) }
    slug { Faker::Internet.slug }
    preview { Faker::Lorem.paragraph(2) }
    body { Faker::Lorem.paragraph(50) }
    keywords { Faker::Lorem.words(5).join(',') }
    description { Faker::Lorem.sentence }
    user { FactoryGirl.create(:user) }
  end
end