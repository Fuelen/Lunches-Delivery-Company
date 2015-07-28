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
end
