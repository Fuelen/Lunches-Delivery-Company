begin
  # helpers
  def random_dish_from(kind)
    Dish.send(kind).where(available_on: Date.today).order("RANDOM()").first
  end

  def fill_three_weeks_with_records(records = 10)
    (Date.today - 3.week).beginning_of_week.upto Date.today do |date|
      Timecop.freeze date do
        records.times do
          yield date unless date.saturday? || date.sunday?
        end
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
    Dish.create name: Faker::Lorem.sentence,
      price:Faker::Number.decimal(2),
      kind: Dish.kinds.values.sample
  end

  puts 'Insert orders...'
  fill_three_weeks_with_records do |date|
    order = Order.create user_id: rand(2..30),
      first_course_id: random_dish_from(:first_courses).id,
      main_course_id: random_dish_from(:main_courses).id,
      drink_id: random_dish_from(:drinks).id,
      address: Faker::Lorem.sentence
  end
  puts 'Completed!'

rescue NoMethodError
  # Sometimes there are no dishes of some kind on some day, because they
  # generates randomly. So just rerun script
  puts '-------------'
  puts 'Rerun please!'
end
