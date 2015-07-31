module Features
  module OtherHelpers
    def add_data(number = 15)
      list = []
      number.times do
        list << yield
      end
      list
    end

    def add_dishes(number = 15)
      add_data number do
        create :dish,
               name: Faker::Name.name,
               price: rand(1..500),
               kind: Dish.kinds.values.sample
      end
    end

    def random_dish_from(kind)
      Dish.send(kind).where(available_on: Date.today).order("RANDOM()").first
    end


    def add_orders_for_a_week(number = 15)
      today = nil
      Date.today.beginning_of_week.upto Date.today.end_of_week - 2 do |date|
        Timecop.freeze(date)
        add_dishes
        today = add_data do
          create :order,
            first_course_id: random_dish_from(:first_courses).id,
            main_course_id: random_dish_from(:main_courses).id,
            drink_id: random_dish_from(:drinks).id,
            address: Faker::Lorem.sentence,
            user_id: User.order("RANDOM()").first.id
        end
      end
      today #return friday's orders
    end
  end
end
