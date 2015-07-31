class Api::V1::OrdersController < Api::ApplicationController
  before_action :authenticate!

  def today
    @orders = Order.where(created_on: Date.today)
      .joins(:first_course, :main_course, :drink, :user)
      .includes(:first_course, :main_course, :drink, :user)
    respond_to do |format|
      format.json
    end
  end
end
