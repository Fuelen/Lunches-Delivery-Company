require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  before {  create(:order) }

  context "when valid token" do
    render_views
    describe "GET #today" do
      before do
        API_TOKENS << "valid token"
        get :today, api_token: "valid token", format: :json
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns json that corresponds with schema" do
        expect(response).to match_response_schema("orders_today")
      end
    end
  end

  context "when invalid token" do
    describe "GET #today" do
      before do
        get :today, api_token: "invalid token", format: :json
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns json that corresponds with schema" do
        expect(response).to match_response_schema("unauthorized")
      end
    end
  end
end
