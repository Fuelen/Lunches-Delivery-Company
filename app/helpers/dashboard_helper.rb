module DashboardHelper
  def current_weekdays
    Date.today.beginning_of_week.upto Date.today.end_of_week-2 do |date|
      yield date, date.strftime("%A")
    end
  end
end
