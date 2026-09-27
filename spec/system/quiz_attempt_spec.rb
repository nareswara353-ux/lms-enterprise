require 'rails_helper'

RSpec.describe "Quiz Attempt", type: :system do
  let(:student) { create(:user, :student) }
  let(:course) { create(:course, :free, status: :published) }
  let!(:quiz) { create(:quiz, course: course, status: :published, passing_score: 50) }

  before do
    create(:enrollment, user: student, course: course, status: :active)
    sign_in_as(student)
  end

  describe "starting a quiz" do
    it "shows the quiz start button" do
      visit course_quiz_path(course, quiz)
      expect(page).to have_content(quiz.title)
    end
  end

  describe "viewing quiz submissions" do
    let!(:submission) { create(:quiz_submission, quiz: quiz, user: student, status: :graded, score: 80) }

    it "shows graded submission" do
      visit quiz_submission_path(submission)
      expect(page).to have_content("80")
    end
  end
end
