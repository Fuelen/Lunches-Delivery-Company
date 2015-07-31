json.array! @orders do |order|
  json.id order.id
  json.address order.address
  json.first_course do
    json.name order.first_course.name
    json.price order.first_course.price
  end
  json.main_course do
    json.name order.main_course.name
    json.price order.main_course.price
  end
  json.drink do
    json.name order.drink.name
    json.price order.main_course.price
  end
  json.user do
    json.name order.user.name
    json.email order.user.email
  end
  json.total_price order.total_price
end
