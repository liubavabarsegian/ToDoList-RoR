require 'rails_helper'

RSpec.describe "Friends", type: :request do
  describe "GET /send_request" do
    it "returns http success" do
      get "/friends/send_request"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /get_request" do
    it "returns http success" do
      get "/friends/get_request"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /accept_request" do
    it "returns http success" do
      get "/friends/accept_request"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /decline_request" do
    it "returns http success" do
      get "/friends/decline_request"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy_friendship" do
    it "returns http success" do
      get "/friends/destroy_friendship"
      expect(response).to have_http_status(:success)
    end
  end

end
