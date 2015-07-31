module Features
  module SessionHelpers
    def sign_in_with(data)
      visit sign_in_path
      within("#new_user") do
        fill_in 'Email',    with: data[:email]
        fill_in 'Password', with: data[:password]
      end
      click_button 'Log in'
    end

    def sign_in_as_admin(password = 12345678)
      admin = create :admin, password: password, password_confirmation: password
      sign_in_with email: admin.email, password: password
      admin
    end

    def sign_in_as_user(password = 12345678)
      create :admin
      user = create :user, password: password, password_confirmation: password
      sign_in_with email: user.email, password: password
      user
    end

  end
end
