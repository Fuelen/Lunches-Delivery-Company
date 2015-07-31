require "rails_helper"

feature "User" do
  background do
    # go to Tuesday
    Timecop.freeze(Date.today.end_of_week - 5)
  end
  given!(:yesterday_dishes) { add_dishes }
  given!(:yesterday_dayname) { Date.today.strftime "%A" }

  background do
    # go to Wednesday
    Timecop.freeze(Date.today.end_of_week - 4)
  end
  given(:current_password) { 12345678 }
  given(:current_dayname) { Date.today.strftime "%A" } #Wednesday
  given!(:dishes) { add_dishes }
  given(:first_course) { dishes.reject { |dish| !dish.first_courses? }.sample }
  given(:main_course) { dishes.reject { |dish| !dish.main_courses? }.sample }
  given(:drink) { dishes.reject { |dish| !dish.drinks? }.sample }
  given!(:user) { sign_in_as_user current_password }

  scenario "can edit profile" do
    click_link user.name
    click_link 'Edit profile'
    fill_in 'Name', with: 'James Bond'
    fill_in 'Current password', with: current_password
    click_button 'Update'
    expect(page).to have_css "div.alert.alert-notice.alert-dismissable",
      text: "Your account has been updated successfully."
  end

  scenario "can see a weekdays on the dashboard page" do
    expect(page).to have_css "a.list-group-item", text: "Monday"
    expect(page).to have_css "a.list-group-item", text: "Tuesday"
    expect(page).to have_css "a.list-group-item", text: "Wednesday today"
    expect(page).to have_css "p.list-group-item.disabled", text: "Thursday"
    expect(page).to have_css "p.list-group-item.disabled", text: "Friday"
    expect(page).not_to have_css ".list-group-item", text: "Sunday"
    expect(page).not_to have_css ".list-group-item", text: "Saturday"
  end

  scenario "can see list of items with prices for yesterday" do
    click_link yesterday_dayname

    expect(page).to have_css "h2", text: "Dishes available on #{Date.yesterday.to_s :long}"
    ["First courses", "Main courses", "Drinks"].each do |kind|
      expect(page).to have_css "div.panel-heading", text: kind
    end
    yesterday_dishes.each do |dish|
      expect(page).to have_css "li.list-group-item",
        text: "#{dish.name} #{number_to_currency dish.price}"
    end
  end

  scenario "can see list of items with prices when make an order" do
    click_link current_dayname
    expect(page).to have_css "h2", text: "Make an order"
    expect(page).to have_css "label", text: "First course"
    expect(page).to have_css "label", text: "Main course"
    expect(page).to have_css "label", text: "Drink"
    dishes.each do |dish|
      expect(page).to have_css "div.order_#{dish.kind.singularize}_id",
        text: "#{dish.name} #{number_to_currency dish.price}"
    end
  end

  scenario "can choose items from menu and make an order" do
    click_link current_dayname
    choose "order_first_course_id_#{first_course.id}"
    choose "order_main_course_id_#{main_course.id}"
    choose "order_drink_id_#{drink.id}"
    fill_in "Address", with: Faker::Lorem.sentence
    click_button "Create Order"
    expect(page).to have_css "div.alert.alert-success.alert-dismissable",
      text: "Your order has been received and is being processed"
  end
end
