require "rails_helper"

feature "Signing up" do

  given(:user_data) do {
    name: "Name",
    email: 'email@example.com',
    password: '12345678',
    password_confirmation: '12345678'
  }
  end

  scenario "with empty name" do
    sign_up_with user_data.merge({name: ""})
    expect(page).to have_content 'Please review the problems below'
  end

  scenario "with valid data" do
    sign_up_with user_data
    expect(page).to have_content 'Welcome'
  end

  scenario "as first user" do
    sign_up_with user_data
    expect(page).to have_content 'Lunches Admin'
  end

end
