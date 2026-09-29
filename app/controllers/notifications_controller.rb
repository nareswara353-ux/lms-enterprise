class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.recent
  end

  def update
    notification = current_user.notifications.find(params.expect(:id))
    notification.mark_as_read!
    redirect_to notifications_path, notice: "Notifikasi ditandai sudah dibaca."
  end

  def mark_all_read
    current_user.notifications.unread.update_all(read: true)
    redirect_to notifications_path, notice: "Semua notifikasi ditandai sudah dibaca."
  end
end
