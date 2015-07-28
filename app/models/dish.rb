class Dish < ActiveRecord::Base
  enum kind: [ :first_course, :main_course, :drink ]
end
