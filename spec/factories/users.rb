FactoryGirl.define do
  factory :user, class: User do
    name                  "Richard Feynman"
    email                 "richard@feynman.com"
    password              "12345678"
    password_confirmation "12345678"
  end

  factory :other_user, class: User do
    name                  "Jaque Fresco"
    email                 "jaque@fres.co"
    password              "12345678"
    password_confirmation "12345678"
  end
end

