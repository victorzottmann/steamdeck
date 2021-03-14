require 'rails_helper'

RSpec.describe "Payments", type: :request do
  describe "GET /success" do
    it "returns http success" do
      get "/payments/success"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /webhook" do
    it "returns http success" do
      get "/payments/webhook"
      expect(response).to have_http_status(:success)
    end
  end

end
