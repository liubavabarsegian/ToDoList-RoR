# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Competitions', type: :request do
  describe 'GET /friends' do
    it 'returns http success' do
      get '/friends_competitions'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /all_users' do
    it 'returns http success' do
      get '/all_competitions'
      expect(response).to have_http_status(:found)
    end
  end
end
