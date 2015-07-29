class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :first_course, class_name: "Dish"
  belongs_to :main_course, class_name: "Dish"
  belongs_to :drink, class_name: "Dish"

  validates_presence_of :first_course_id,
                        :main_course_id,
                        :drink_id,
                        :address

  before_create :set_ordered_on_today


  private

  def set_ordered_on_today
    self.ordered_on = Date.today
  end
end
