require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  let!(:user) { create(:user, :student, email: "student@test.com", password: "password123") }

  describe "sign in flow" do
    it "allows user to sign in with valid credentials" do
      visit new_user_session_path
      fill_in "Email", with: "student@test.com"
      fill_in "Password", with: "password123"
      click_button "Log in"

      expect(page).to have_current_path(dashboard_path)
    end

    it "shows error with invalid credentials" do
      visit new_user_session_path
      fill_in "Email", with: "student@test.com"
      fill_in "Password", with: "wrongpassword"
      click_button "Log in"

      expect(page).to have_content("Invalid Email or password")
    end
  end

  describe "sign out flow" do
    it "allows user to sign out" do
      sign_in_as(user)
      click_button "Sign out"

      expect(page).to have_link("Sign in")
    end
  end
end
