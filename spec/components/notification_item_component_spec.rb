require 'rails_helper'

RSpec.describe NotificationItemComponent, type: :component do
  let(:notification) { build(:notification, message: "Hello!", read: false) }

  it "renders message" do
    render_inline(described_class.new(notification: notification))
    expect(page).to have_text("Hello!")
  end

  it "applies unread class when unread" do
    render_inline(described_class.new(notification: notification))
    expect(page).to have_css(".notification-item.unread")
  end

  it "does not apply unread class when read" do
    notification.read = true
    render_inline(described_class.new(notification: notification))
    expect(page).not_to have_css(".notification-item.unread")
  end
end
