require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:recipient) }
    it { is_expected.to belong_to(:notifiable).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_length_of(:message).is_at_most(500) }
  end

  describe "scopes" do
    let!(:unread) { create(:notification, read: false) }
    let!(:read) { create(:notification, :read) }

    it "returns unread notifications" do
      expect(Notification.unread).to include(unread)
      expect(Notification.unread).not_to include(read)
    end

    it "returns read notifications" do
      expect(Notification.read).to include(read)
    end
  end

  describe "#mark_as_read!" do
    let(:notification) { create(:notification, read: false) }

    it "marks notification as read" do
      notification.mark_as_read!
      expect(notification.reload.read).to be true
    end
  end

  describe "callbacks" do
    it "enqueues broadcast job after create" do
      expect {
        create(:notification)
      }.to have_enqueued_job(NotificationBroadcastJob)
    end
  end
end
