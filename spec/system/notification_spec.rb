require 'rails_helper'

RSpec.describe "Notification", type: :system do
  let(:student) { create(:user, :student) }
  let!(:notification) { create(:notification, recipient: student, message: "Selamat datang!") }

  before { sign_in_as(student) }

  describe "viewing notifications" do
    it "shows user notifications" do
      visit notifications_path
      expect(page).to have_content("Selamat datang!")
    end
  end

  describe "marking notification as read" do
    it "marks notification as read" do
      visit notifications_path
      click_button "Tandai Dibaca"

      expect(notification.reload.read).to be true
    end
  end
end
