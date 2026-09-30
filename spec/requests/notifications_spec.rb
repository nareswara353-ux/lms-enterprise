require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user, :student, password: "password123") }
  let!(:notification) { create(:notification, recipient: user, read: false) }

  def login_as(u)
    post user_session_path, params: { user: { email: u.email, password: "password123" } }
  end

  describe "GET /notifications" do
    it "renders notifications index" do
      login_as(user)
      get notifications_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(notification.message)
    end
  end

  describe "PATCH /notifications/:id" do
    it "marks notification as read and responds with turbo stream" do
      login_as(user)
      patch notification_path(notification), headers: { "Accept" => "text/vnd.turbo-stream.html" }
      expect(response).to have_http_status(:ok)
      expect(notification.reload.read).to be true
    end

    it "redirects on html format" do
      login_as(user)
      patch notification_path(notification)
      expect(response).to redirect_to(notifications_path)
    end
  end

  describe "PATCH /notifications/mark_all_read" do
    it "marks all notifications as read" do
      login_as(user)
      create_list(:notification, 3, recipient: user, read: false)
      patch mark_all_read_notifications_path
      expect(user.notifications.unread.count).to eq(0)
    end
  end
end
