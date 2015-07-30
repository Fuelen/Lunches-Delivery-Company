FactoryGirl.define do
  factory :dish, aliases: [:main_course], class: Dish do
    name Faker::Commerce.product_name
    price Faker::Commerce.price
    kind :main_courses
    factory :first_course do kind :first_courses end
    factory :drink do kind :drinks end
  end
end
