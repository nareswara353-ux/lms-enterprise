class NotificationBroadcastJob < ApplicationJob
  queue_as :critical

  def perform(notification_id)
    notification = Notification.find_by(id: notification_id)
    return if notification.nil?

    NotificationsChannel.broadcast_to(
      notification.recipient,
      notification_payload(notification)
    )
  end

  private

  def notification_payload(notification)
    {
      id: notification.id,
      message: notification.message,
      url: notification.url,
      read: notification.read,
      unread_count: notification.recipient.notifications.unread.count,
      created_at: notification.created_at.iso8601
    }
  end
end
