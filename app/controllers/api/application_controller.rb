class Api::ApplicationController < ApplicationController

  protected

  def authenticate!
    unless API_TOKENS.include? params[:api_token]
      render json: { error: 'Bad Token' }, status: :unauthorized
    end
  end
end
