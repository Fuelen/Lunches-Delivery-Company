class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :first_course, class_name: "Dish"
  belongs_to :main_course, class_name: "Dish"
  belongs_to :drink, class_name: "Dish"
end
