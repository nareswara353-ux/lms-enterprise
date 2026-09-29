require 'rails_helper'

RSpec.describe "Registration", type: :system do
  describe "sign up flow" do
    it "allows new user to register as student" do
      visit new_user_registration_path
      fill_in "Name", with: "New Student"
      fill_in "Email", with: "newstudent@test.com"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "password123"
      click_button "Sign up"

      expect(page).to have_content("confirmation link")
    end

    it "shows validation errors for invalid data" do
      visit new_user_registration_path
      fill_in "Name", with: ""
      fill_in "Email", with: "invalid-email"
      fill_in "Password", with: "short"
      fill_in "Password confirmation", with: "short"
      click_button "Sign up"

      expect(page).to have_content("error")
    end
  end
end
