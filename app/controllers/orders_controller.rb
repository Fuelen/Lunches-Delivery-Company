class OrdersController < ApplicationController
  include DateConcern
  before_action :authenticate_user!
  before_action :for_admin!, only: [:index, :created_on]
  before_action :protect_from_working_on_weekend, only: [:new, :create]
  before_action :set_dishes, only: [:new, :create]
  before_action :set_date,   only: [:index, :created_on]
  before_action :set_orders, only: [:index, :created_on]

  def index
    #distinct not work in kaminari
    @order_dates = Order.select(:created_on).order(created_on: :desc)
      .group(:created_on).page(params[:page])
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

  def created_on
  end

  private

  def set_dishes
    @dishes = Dish.where(available_on: Date.today)
  end

  def set_orders
    @orders = Order.where(created_on: @date).order(id: :desc)
      .joins(:first_course, :main_course, :drink,:user)
      .includes(:first_course, :main_course, :drink,:user)
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
