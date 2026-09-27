require 'rails_helper'

RSpec.describe "Discussion", type: :system do
  let(:student) { create(:user, :student) }
  let(:course) { create(:course, :free, status: :published) }

  before do
    create(:enrollment, user: student, course: course, status: :active)
    sign_in_as(student)
  end

  describe "viewing discussion topics" do
    let!(:topic) { create(:discussion_topic, course: course, user: student, title: "Pertanyaan tentang Rails") }

    it "shows topics for course" do
      visit course_discussion_topics_path(course)
      expect(page).to have_content("Pertanyaan tentang Rails")
    end
  end

  describe "viewing topic detail" do
    let(:topic) { create(:discussion_topic, course: course, user: student) }

    it "shows topic and posts" do
      create(:discussion_post, discussion_topic: topic, user: student, content: "Terima kasih")
      visit course_discussion_topic_path(course, topic)
      expect(page).to have_content(topic.title)
      expect(page).to have_content("Terima kasih")
    end
  end
end
