class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin!, only: [:show, :index]
  before_action :set_dishes, only: [:new, :create]


  def index
  end

  def create
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


end
