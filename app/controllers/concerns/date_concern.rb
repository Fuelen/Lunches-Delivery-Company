module DateConcern
  extend ActiveSupport::Concern

  private

  def set_date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end

