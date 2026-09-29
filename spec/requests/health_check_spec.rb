require 'rails_helper'

RSpec.describe "HealthCheck", type: :request do
  describe "GET /health" do
    it "returns health status" do
      get "/health"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json).to have_key("database")
      expect(json).to have_key("timestamp")
    end
  end
end
