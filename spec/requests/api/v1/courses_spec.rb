require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do
  let!(:published_courses) { create_list(:course, 3, status: :published) }
  let!(:draft_course) { create(:course, status: :draft) }

  describe "GET /api/v1/courses" do
    it "returns published courses" do
      get "/api/v1/courses"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json.size).to eq(3)
    end

    it "excludes draft courses" do
      get "/api/v1/courses"
      json = response.parsed_body
      ids = json.pluck("id")
      expect(ids).not_to include(draft_course.id)
    end
  end

  describe "GET /api/v1/courses/:id" do
    let(:course) { published_courses.first }

    it "returns course detail" do
      get "/api/v1/courses/#{course.slug}"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["title"]).to eq(course.title)
    end
  end
end
