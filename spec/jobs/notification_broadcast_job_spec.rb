require 'rails_helper'

RSpec.describe NotificationBroadcastJob, type: :job do
  let(:user) { create(:user, :student) }
  let!(:notification) { create(:notification, recipient: user) }

  describe "#perform" do
    it "broadcasts to recipient's channel" do
      expect(NotificationsChannel).to receive(:broadcast_to).with(user, hash_including(:id, :message))
      described_class.new.perform(notification.id)
    end

    it "does nothing for non-existent notification" do
      expect(NotificationsChannel).not_to receive(:broadcast_to)
      described_class.new.perform(999_999)
    end

    it "includes unread count in payload" do
      expect(NotificationsChannel).to receive(:broadcast_to) do |_, payload|
        expect(payload[:unread_count]).to eq(1)
      end
      described_class.new.perform(notification.id)
    end
  end
end
