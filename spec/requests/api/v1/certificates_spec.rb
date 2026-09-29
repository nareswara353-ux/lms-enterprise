require 'rails_helper'

RSpec.describe "Api::V1::Certificates", type: :request do
  let(:user) { create(:user, :student) }
  let(:course) { create(:course) }
  let!(:certificate) { create(:certificate, user: user, course: course) }

  describe "GET /api/v1/certificates/:code/verify" do
    it "returns certificate details for valid code" do
      get "/api/v1/certificates/#{certificate.code}/verify"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["code"]).to eq(certificate.code)
      expect(json["valid"]).to be true
    end

    it "returns 404 for invalid code" do
      get "/api/v1/certificates/INVALIDCODE/verify"
      expect(response).to have_http_status(:not_found)
    end
  end
end
