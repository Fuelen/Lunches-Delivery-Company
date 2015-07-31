module Features
  module RegistrationHelpers
    def sign_up_with(data)
      visit 'users/sign_up'
      within("#new_user") do
        fill_in 'Name',     with: data[:name]
        fill_in 'Email',    with: data[:email]
        fill_in 'Password', with: data[:password], match: :prefer_exact
        fill_in 'Password confirmation', with: data[:password_confirmation]
      end
      click_button 'Sign up'
    end
  end
end
