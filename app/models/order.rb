class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :first_course, class_name: "Dish"
  belongs_to :main_course, class_name: "Dish"
  belongs_to :drink, class_name: "Dish"

  validates_presence_of :first_course_id,
                        :main_course_id,
                        :drink_id,
                        :address
  validates_each :first_course, :main_course, :drink do |record, kind, dish|
    if dish.nil?
      record.errors.add(kind, 'does not exists')
    else
      # if drink_id has pizza's id
      if kind.to_s.pluralize != dish.kind
        record.errors.add(kind, "is not #{kind.to_s.humanize(capitalize: false)}")
      end
      if dish.available_on != Date.today
        record.errors.add(kind, 'is not available today')
      end
    end
  end

  before_create :set_created_on_today


  private

  def set_created_on_today
    self.created_on = Date.today
  end
end
