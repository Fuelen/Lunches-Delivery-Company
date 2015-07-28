class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin!, only: [:new, :create]

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


end
