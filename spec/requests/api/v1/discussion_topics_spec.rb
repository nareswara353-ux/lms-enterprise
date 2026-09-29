require 'rails_helper'

RSpec.describe "Api::V1::DiscussionTopics", type: :request do
  let(:user) { create(:user, :student) }
  let(:course) { create(:course, status: :published) }
  let!(:topic) { create(:discussion_topic, course: course, user: user) }

  let(:auth_headers) { { "Authorization" => "Bearer #{user.api_token}" } }

  describe "GET /api/v1/courses/:course_id/discussion_topics" do
    it "returns discussion topics" do
      get "/api/v1/courses/#{course.slug}/discussion_topics", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json.size).to eq(1)
    end
  end

  describe "GET /api/v1/discussion_topics/:id" do
    it "returns topic detail with author" do
      get "/api/v1/discussion_topics/#{topic.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["author"]).to be_present
    end
  end
end
