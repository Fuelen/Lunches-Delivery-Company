begin
# helpers
  def random_dish_from(kind, date = Date.today)
    Dish.send(kind).where(available_on: date).order("RANDOM()").first
  end

  def fill_three_weeks_with_records(records = 10)
    (Date.today - 3.week).beginning_of_week.upto Date.today do |date|
      records.times do
        yield date unless date.saturday? || date.sunday?
      end
    end
  end

  # clear tables
  User.delete_all
  Dish.delete_all
  Order.delete_all

  puts 'Insert users...'
  User.create name: "Launches Admin", email: "email@example.com",
    password: 12345678, password_confirmation: 12345678
  puts "\tAdmin email:    email@example.com"
  puts "\tAdmin password: 12345678"

  30.times do
    password = Faker::Internet.password
    User.create name: Faker::Name.name, email: Faker::Internet.email,
      password: password, password_confirmation: password
  end

  puts 'Insert dishes...'
  fill_three_weeks_with_records 15 do |date|
    dish = Dish.create name: Faker::Lorem.sentence,
      price:Faker::Number.decimal(2),
      kind: Dish.kinds.values.sample
    dish.update_columns available_on: date
  end

  puts 'Insert orders...'
  fill_three_weeks_with_records do |date|
    # this spaghetti needs to process validation
    # validation skip only today dishes, so create order with them
    order = Order.create user_id: rand(2..30),
      first_course_id: random_dish_from(:first_courses).id,
      main_course_id: random_dish_from(:main_courses).id,
      drink_id: random_dish_from(:drinks).id,
      address: Faker::Lorem.sentence
    # create new variables to calculate total price
    # simply order.save will not work
    first_course = random_dish_from(:first_courses, date)
    main_course  = random_dish_from(:main_courses,  date)
    drink        = random_dish_from(:drinks,        date)

    order.update_columns first_course_id: first_course.id,
      main_course_id: main_course.id,
      drink_id: drink.id,
      created_on: date,
      total_price: first_course.price + main_course.price + drink.price
  end
  puts 'Completed!'

  rescue NoMethodError
    # Sometimes there are no dishes of some kind on some day, because they
    # generates randomly. So just rerun script
    puts '-------------'
    puts 'Rerun please!'
end
