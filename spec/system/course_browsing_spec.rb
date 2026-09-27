require 'rails_helper'

RSpec.describe "Course Browsing", type: :system do
  let!(:published_course) { create(:course, :free, title: "Ruby Fundamentals", status: :published) }
  let!(:draft_course) { create(:course, title: "Draft Course", status: :draft) }

  describe "visiting home page" do
    it "shows featured courses" do
      visit root_path
      expect(page).to have_content("Ruby Fundamentals")
      expect(page).not_to have_content("Draft Course")
    end
  end

  describe "course listing" do
    it "lists only published courses" do
      visit courses_path
      expect(page).to have_content("Ruby Fundamentals")
      expect(page).not_to have_content("Draft Course")
    end
  end

  describe "course detail" do
    it "shows course details and curriculum" do
      visit course_path(published_course)
      expect(page).to have_content(published_course.title)
      expect(page).to have_content(published_course.instructor.name)
    end
  end
end
