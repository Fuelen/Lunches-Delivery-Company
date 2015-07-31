require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:first_course) { FactoryGirl.create :first_course }
  let(:main_course) { FactoryGirl.create :main_course }
  let(:drink) { FactoryGirl.create :drink }
  let(:valid_params_for_create) do
    {
      order: {
        first_course_id: first_course.id,
        main_course_id:  main_course.id,
        drink_id:        drink.id,
        address:         "valid"
      }
    }
  end
  let(:invalid_params_for_create) {{ order: { address: "valid"} }}

  ########################
  # When visitor is guest
  ########################
  context "when visitor is guest" do
    describe "GET #index" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to new_user_session_url
      end

    end

    describe "POST #create" do
      it "redirects to sign in page" do
        post :create
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "GET #new" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "GET #created_on" do
      it "redirects to sign in page" do
        get :created_on, date: Date.today
        expect(response).to redirect_to new_user_session_url
      end
    end
  end

  #######################
  # When visitor is user
  #######################
  context "when visitor is user" do
    login_user
    describe "GET #index" do
      it "raises not found" do
        expect{ get :index }.to raise_error(ActionController::RoutingError)
      end
    end

    describe "POST #create" do
      it "responds success when params is invalid" do
        post :create, invalid_params_for_create
        expect(response).to have_http_status(:success)
      end

      it "redirects to root when params is valid" do
        post :create, valid_params_for_create
        expect(response).to redirect_to root_url
      end

      it "redirects to root when today is weekend" do
        Timecop.freeze Date.today.end_of_week do
          post :create
          expect(response).to redirect_to root_url
        end
      end
    end

    describe "GET #new" do
      it "responds success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "redirects to root when today is weekend" do
        Timecop.freeze Date.today.end_of_week do
          get :new
          expect(response).to redirect_to root_url
        end
      end
    end

    describe "GET #created_on" do
      it "raises not found" do
        expect{ get :created_on, date: Date.today }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  ########################
  # When visitor is admin
  ########################
  context "when visitor is admin" do
    login_admin

    describe "GET #index" do
      it "responds success" do
        get :index
        expect(response).to have_http_status(:success)
      end

    end

    describe "POST #create" do
      it "responds success when params is invalid" do
        post :create, invalid_params_for_create
        expect(response).to have_http_status(:success)
      end

      it "redirects to root when params is valid" do
        post :create, valid_params_for_create
        expect(response).to redirect_to root_url
      end
    end

    describe "GET #new" do
      it "responds success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #created_on" do
      it "responds success" do
        get :created_on, date: Date.today
        expect(response).to have_http_status(:success)
      end
    end
  end

end
