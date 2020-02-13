require 'faker'

User.delete_all

User.create(name: 'Admin', email: 'admin@example.com', admin: true, password: 'test_admin')

100.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Devise.friendly_token.first(16)
  )
end
