class FillTotalPriceInOrders < ActiveRecord::Migration
  def up
    Order.all.each do |order|
      order.total_price = order.first_course.price + order.main_course.price +
        order.drink.price
      order.save!
    end
  end

  def down
    Order.update_all total_price: nil
  end
end
