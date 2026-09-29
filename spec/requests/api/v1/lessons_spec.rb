require 'rails_helper'

RSpec.describe "Api::V1::Lessons", type: :request do
  let(:lesson) { create(:lesson, status: :published) }

  describe "GET /api/v1/lessons/:id" do
    it "returns lesson detail" do
      get "/api/v1/lessons/#{lesson.slug}"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["title"]).to eq(lesson.title)
      expect(json["course_module"]).to be_present
    end

    it "returns not found for invalid slug" do
      get "/api/v1/lessons/nonexistent"
      expect(response).to have_http_status(:not_found)
    end
  end
end
