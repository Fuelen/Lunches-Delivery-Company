require "rails_helper"

feature "Admin" do
  given!(:admin) { sign_in_as_admin }
  given!(:users) { add_data { create(:user,
                                     email: Faker::Internet.email,
                                     name: Faker::Name.name) } }
  given!(:today_orders) { add_orders_for_a_week }
  # There can be any day except Monday (then test which call Date#yesterday
  # will failure)
  background { Timecop.freeze(Date.parse("Friday")) }
  after { Timecop.return }

  scenario "can see admin navbar" do
    ["Dashboard", "Users", "Menu for today", "Orders"].each do |menu_item|
      expect(page).to have_css "ul.nav.nav-tabs li", text: menu_item
    end
  end

  scenario "can see list of users" do
    click_link "Users"
    users.each do |user|
      expect(page).to have_css "div.list-group div.list-group-item",
        text: "#{user.name} (#{user.email})"
    end
    expect(page).to have_css "div.list-group div.list-group-item",
        text: "#{admin.name} (#{admin.email})"
  end

  scenario "can add dishes for today" do
    click_link "Menu for today"
    expect(page).to have_css "h2", text: "Make menu for today"
    fill_in "Name", with: "dish name"
    fill_in "Price", with: "20"
    select "First courses"
    click_button "Create Dish"
    expect(page).to have_css "div.alert.alert-success.alert-dismissable",
      text: "Dish has been added"
  end

  scenario "can browse days and see user's orders there" do
    click_link "Orders"
    expect(page).to have_css "h3", text: "Orders by date"
    # check if there are all days in a list
    Date.today.beginning_of_week.upto Date.today do |date|
      expect(page).to have_css "div.list-group a.list-group-item",
        text: long_date(date)
    end
    click_link long_date(Date.yesterday)
    expect(page).to have_css "h3", text: "Orders for #{long_date(Date.yesterday)}"
    # check whether all orders are there
    Order.where(created_on: Date.yesterday).each do |order|
      expect(page).to have_css "div.panel-heading",
        text: "#{order.user.name} ##{order.id}"
      expect(page).to have_css "tr",
        text: "First course #{order.first_course.name} #{number_to_currency order.first_course.price}"
      expect(page).to have_css "tr",
        text: "Main course #{order.main_course.name} #{number_to_currency order.main_course.price}"
      expect(page).to have_css "tr",
        text: "Drink #{order.drink.name} #{number_to_currency order.drink.price}"
      expect(page).to have_css "tr",
        text: "Total #{number_to_currency order.total_price}"
    end
  end

  scenario "can see list of orders and total lunch cost for today" do
    click_link "Orders"
    expect(page).to have_css "div.alert.alert-info",text: "Total cost: "
    today_orders.each do |order|
      expect(page).to have_css "div.panel-heading",
        text: "#{order.user.name} ##{order.id}"
      expect(page).to have_css "tr",
        text: "First course #{order.first_course.name} #{number_to_currency order.first_course.price}"
      expect(page).to have_css "tr",
        text: "Main course #{order.main_course.name} #{number_to_currency order.main_course.price}"
      expect(page).to have_css "tr",
        text: "Drink #{order.drink.name} #{number_to_currency order.drink.price}"
      expect(page).to have_css "tr",
        text: "Total #{number_to_currency order.total_price}"
    end
  end
end
