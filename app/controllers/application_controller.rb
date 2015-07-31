class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def for_admin!
    if !user_signed_in? or !current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def protect_from_working_on_weekend
    if Date.today.sunday? || Date.today.saturday?
      redirect_to root_url, notice: "Sorry, but we are not working on weekend"
    end
  end
end
