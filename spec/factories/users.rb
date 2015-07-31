FactoryGirl.define do
  factory :user, class: User do
    name                  Faker::Name.name
    email                 Faker::Internet.email
    password              "12345678"
    password_confirmation "12345678"

    factory :other_user do
      email Faker::Internet.email
    end
    factory :admin do
      email Faker::Internet.email
      admin true
    end
  end
end

