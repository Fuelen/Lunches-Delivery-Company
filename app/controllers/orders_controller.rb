class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin!, only: [:show, :index]
  before_action :set_dishes, only: [:new, :create]


  def index
    @orders_today = Order.where(created_on: Date.today).order(id: :desc)
      .joins(:first_course, :main_course, :drink,:user)
      .includes(:first_course, :main_course, :drink,:user)
    @order_dates = Order.select(:created_on).distinct.order(created_on: :desc)
      .page(params[:page])
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
