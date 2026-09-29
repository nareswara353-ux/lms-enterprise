require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create(:user, :instructor) }

  describe "GET /api/v1/users/:id" do
    it "returns user public profile" do
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["name"]).to eq(user.name)
      expect(json["role"]).to eq("instructor")
    end

    it "does not expose email" do
      get "/api/v1/users/#{user.id}"
      json = response.parsed_body
      expect(json).not_to have_key("email")
    end

    it "returns 404 for invalid id" do
      get "/api/v1/users/999999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
