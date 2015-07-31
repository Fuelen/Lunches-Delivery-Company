class DishesController < ApplicationController
  include DateConcern
  before_action :authenticate_user!
  before_action :for_admin!, only: [:new, :create]
  before_action :set_date
  before_action :protect_from_working_on_weekend, only: [:new, :create]
  before_action :set_dishes

  def new
    @dish = Dish.new
  end

  def available_on
    redirect_to new_order_url if @date == Date.today
  end

  def create
    @dish = Dish.create(dish_params)
    if @dish.persisted?
      flash.now[:success]='Dish has been added'
      @dish = Dish.new
    end
    render 'new'
  end

  private 

  def dish_params
    params.require(:dish).permit(:name, :price, :kind)
  end

  def set_dishes
    @dishes = Dish.where(available_on: @date)
  end
end
