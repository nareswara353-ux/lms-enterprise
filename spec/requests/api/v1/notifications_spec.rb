require 'rails_helper'

RSpec.describe "Api::V1::Notifications", type: :request do
  let(:user) { create(:user, :student, api_token: "test-token-#{SecureRandom.hex(4)}") }
  let!(:notification) { create(:notification, recipient: user) }

  let(:auth_headers) { { "Authorization" => "Bearer #{user.api_token}" } }

  describe "GET /api/v1/notifications" do
    it "returns user notifications" do
      get "/api/v1/notifications", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json.size).to be >= 1
    end

    it "returns unauthorized without token" do
      get "/api/v1/notifications"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH /api/v1/notifications/:id" do
    it "marks notification as read" do
      patch "/api/v1/notifications/#{notification.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(notification.reload.read).to be true
    end
  end
end
