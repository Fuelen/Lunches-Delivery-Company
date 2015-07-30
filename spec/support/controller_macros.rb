module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in :user, FactoryGirl.create(:admin)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      FactoryGirl.create(:admin) # first user is admin
      sign_in FactoryGirl.create(:user)
    end
  end
end
