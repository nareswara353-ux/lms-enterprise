require 'rails_helper'

RSpec.describe "Lesson Completion", type: :system do
  let(:student) { create(:user, :student) }
  let(:course) { create(:course, :free, status: :published) }
  let(:modul) { create(:course_module, course: course, status: :published) }
  let!(:lesson) { create(:lesson, course_module: modul, status: :published) }

  before do
    create(:enrollment, user: student, course: course, status: :active)
    sign_in_as(student)
  end

  it "allows student to mark lesson as complete" do
    visit course_module_lesson_path(modul, lesson)
    click_button "Tandai Selesai"

    expect(page).to have_content("Lesson selesai")
    expect(page).to have_button("Tandai Belum Selesai")
  end

  it "allows student to unmark completed lesson" do
    create(:lesson_completion, user: student, lesson: lesson)
    visit course_module_lesson_path(modul, lesson)
    click_button "Tandai Belum Selesai"

    expect(page).to have_content("Progress dibatalkan")
  end
end
