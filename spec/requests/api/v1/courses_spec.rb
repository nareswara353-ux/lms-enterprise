require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do
  let!(:published_courses) { create_list(:course, 3, status: :published) }
  let!(:draft_course) { create(:course, status: :draft) }

  describe "GET /api/v1/courses" do
    it "returns published courses" do
      get "/api/v1/courses"
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["data"].size).to eq(3)
    end

    it "excludes draft courses" do
      get "/api/v1/courses"
      json = response.parsed_body
      ids = json["data"].map { |c| c["id"] }
      expect(ids).not_to include(draft_course.id)
    end

    it "includes pagination meta" do
      get "/api/v1/courses"
      json = response.parsed_body
      expect(json["meta"]).to include("current_page", "total_pages", "total_count")
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
