require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }

    after(:build) { |u| u.password_confirmation = u.password = '123456' }
  end
end
