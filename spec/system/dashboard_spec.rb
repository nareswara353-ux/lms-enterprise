require 'rails_helper'

RSpec.describe "Dashboard", type: :system do
  describe "student dashboard" do
    let(:student) { create(:user, :student) }
    let!(:enrollment) { create(:enrollment, user: student, course: create(:course, :free)) }

    before { sign_in_as(student) }

    it "shows enrolled courses" do
      visit dashboard_path
      expect(page).to have_content("Course yang Diikuti")
      expect(page).to have_content(enrollment.course.title)
    end
  end

  describe "instructor dashboard" do
    let(:instructor) { create(:user, :instructor) }
    let!(:course) { create(:course, instructor: instructor, status: :published) }

    before { sign_in_as(instructor) }

    it "shows course statistics" do
      visit instructor_dashboard_path
      expect(page).to have_content("Instructor Dashboard")
      expect(page).to have_content(course.title)
    end
  end

  describe "admin dashboard" do
    let(:admin) { create(:user, :admin) }

    before { sign_in_as(admin) }

    it "shows global statistics" do
      visit admin_dashboard_path
      expect(page).to have_content("Admin Dashboard")
      expect(page).to have_content("Total Users")
    end
  end
end
