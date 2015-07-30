require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  ########################
  # When visitor is guest
  ########################
  context "when visitor is guest" do
    describe "GET #show" do
      it "redirects to sign in page" do
        get :show
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  #######################
  # When visitor is user
  #######################
  context "when visitor is user" do
    login_user

    describe "GET #show" do
      it "responds success" do
        get :show
        expect(response).to have_http_status(:success)
      end
    end
  end

  ########################
  # When visitor is admin
  ########################
  context "when visitor is admin" do
    login_admin

    describe "GET #show" do
      it "responds success" do
        get :show
        expect(response).to have_http_status(:success)
      end
    end
  end
end
