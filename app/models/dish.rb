class Dish < ActiveRecord::Base
  enum kind: [ :first_course, :main_course, :drink ]

  before_create :set_available_on_today

  private

  def set_available_on_today
    self.available_on = Date.today
  end

end
