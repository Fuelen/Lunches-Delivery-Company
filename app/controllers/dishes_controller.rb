class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin!, only: [:new, :create]

  def new
  end

  def available_on
  end

  def create
  end
end
