class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin!, only: [:new, :create]
  before_action :set_date
  before_action :set_dishes

  def new
    @dish = Dish.new
  end

  def available_on
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

  def set_date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

end
