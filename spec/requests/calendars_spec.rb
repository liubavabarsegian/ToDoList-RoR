require 'rails_helper'

RSpec.describe "Calendars", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/calendars/show"
      expect(response).to have_http_status(:success)
    end
  end

end
