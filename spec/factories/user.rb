FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 20) }
    password_confirmation { password }
  end
end