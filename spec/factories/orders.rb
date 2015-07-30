FactoryGirl.define do
  factory :order do
    user
    first_course
    main_course
    drink
    address Faker::Lorem.sentence
  end

end
