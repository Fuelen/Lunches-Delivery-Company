class Dish < ActiveRecord::Base
  enum kind: [ :first_courses, :main_courses, :drinks ]

  validates_presence_of :name, :kind
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  before_create :set_available_on_today

  private

  def set_available_on_today
    self.available_on = Date.today
  end

end
