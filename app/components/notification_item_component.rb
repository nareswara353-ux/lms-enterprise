class NotificationItemComponent < ApplicationComponent
  def initialize(notification:)
    @notification = notification
  end

  private

  attr_reader :notification

  def unread?
    !notification.read
  end

  def css_class
    "notification-item #{'unread' if unread?}"
  end
end
