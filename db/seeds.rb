# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create name: "Launches Admin", email: "email@example.com",
  password: 12345678, password_confirmation: 12345678
p "Admin email:    email@example.com"
p "Admin password: 12345678"
30.times do
  password = Faker::Internet.password
  User.create name: Faker::Name.name, email: Faker::Internet.email,
    password: password, password_confirmation: password
end
