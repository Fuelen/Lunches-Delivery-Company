class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin!, only: [:show, :index]
  before_action :set_dishes, only: [:new, :create]


  def index
  end

  def create
    @order = Order.create(order_params)
    if @order.persisted?
      flash[:success] = 'Your order has been received and is being processed'
      redirect_to root_url
    else
      render 'new'
    end

  end

  def new
    @order = Order.new
  end

  def show
  end

  private

  def set_dishes
    @dishes = Dish.where(available_on: Date.today)
  end

  def order_params
    params.require(:order).permit(
      :first_course_id,
      :main_course_id,
      :drink_id,
      :address
    ).merge(user_id: current_user.id)
  end
end
