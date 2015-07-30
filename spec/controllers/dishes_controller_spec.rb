require 'rails_helper'

RSpec.describe DishesController, type: :controller do
  let(:params_for_create) { {dish: {name: "Coca", price: 2, kind: 'drinks'} }}

  ########################
  # When visitor is guest
  ########################
  context "when visitor is guest" do
    describe "GET #new" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "GET #available_on" do
      it "redirects to sign in page" do
        get :available_on, date: Date.today
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "POST #create" do
      it "redirects to sign in page" do
        post :create
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  #######################
  # When visitor is user
  #######################
  context "when visitor is user" do
    login_user

    describe "GET #new" do
      it "raises not found" do
        expect{ get :new }.to raise_error(ActionController::RoutingError)
      end
    end

    describe "GET #available_on" do
      it "redirects to new order when date is today" do
        get :available_on, date: Date.today
        expect(response).to redirect_to new_order_url
      end

      it "returns http success when date is not today" do
        get :available_on, date: Date.today - 1
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      it "raises not found" do
        expect{ post :create }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  ########################
  # When visitor is admin
  ########################
  context "when visitor is admin" do
    login_admin
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #available_on" do
      it "redirects to new order when date is today" do
        get :available_on, date: Date.today
        expect(response).to redirect_to new_order_url
      end

      it "returns http success when date in not today" do
        get :available_on, date: Date.today - 1
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      it "redirects to sign in page" do
        post :create, params_for_create
        expect(response).to have_http_status(:success)
      end
    end
  end
end
