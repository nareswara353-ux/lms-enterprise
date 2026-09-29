require 'rails_helper'

RSpec.describe "Api::V1::DiscussionPosts", type: :request do
  let(:user) { create(:user, :student) }
  let(:course) { create(:course, status: :published) }
  let(:topic) { create(:discussion_topic, course: course, user: user) }
  let!(:post_record) { create(:discussion_post, discussion_topic: topic, user: user) }

  let(:auth_headers) { { "Authorization" => "Bearer #{user.api_token}" } }

  describe "GET /api/v1/discussion_topics/:discussion_topic_id/discussion_posts" do
    it "returns posts for topic" do
      get "/api/v1/discussion_topics/#{topic.id}/discussion_posts", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json.size).to eq(1)
    end
  end

  describe "GET /api/v1/discussion_posts/:id" do
    it "returns post detail" do
      get "/api/v1/discussion_posts/#{post_record.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json["author"]).to be_present
    end
  end
end
