require 'rails_helper'

RSpec.describe "Enrollment", type: :system do
  let(:student) { create(:user, :student) }
  let!(:course) { create(:course, :free, status: :published) }

  before { sign_in_as(student) }

  describe "enrolling in a free course" do
    it "allows student to enroll" do
      visit course_path(course)
      click_button "Daftar Gratis"

      expect(page).to have_content("Berhasil mendaftar")
      expect(page).to have_content("Anda sudah terdaftar")
    end
  end

  describe "viewing enrolled course" do
    before { create(:enrollment, user: student, course: course, status: :active) }

    it "shows enrollment progress" do
      visit course_path(course)
      expect(page).to have_content("Anda sudah terdaftar")
    end
  end
end
