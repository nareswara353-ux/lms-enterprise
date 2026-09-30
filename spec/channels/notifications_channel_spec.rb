require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  let(:user) { create(:user, :student) }

  before { stub_connection current_user: user }

  describe "#subscribed" do
    it "subscribes to user-specific stream" do
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_for(user)
    end

    it "rejects when no current_user" do
      stub_connection current_user: nil
      subscribe
      expect(subscription).to be_rejected
    end
  end

  describe "#unsubscribed" do
    it "stops all streams" do
      subscribe
      unsubscribe
      expect(subscription).not_to have_streams
    end
  end
end
