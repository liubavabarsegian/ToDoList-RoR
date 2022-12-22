require 'rails_helper'

RSpec.describe "Competitions", type: :request do
  describe "GET /friends" do
    it "returns http success" do
      get "/competitions/friends"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /all_users" do
    it "returns http success" do
      get "/competitions/all_users"
      expect(response).to have_http_status(:success)
    end
  end

end
