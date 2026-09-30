class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.recent
  end

  def update
    notification = current_user.notifications.find(params[:id])
    notification.mark_as_read!
    respond_to do |format|
      format.html { redirect_to notifications_path, notice: "Notifikasi ditandai sudah dibaca." }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(helpers.dom_id(notification), partial: "notifications/notification", locals: { notification: notification }) }
    end
  end

  def mark_all_read
    current_user.notifications.unread.update_all(read: true)
    redirect_to notifications_path, notice: "Semua notifikasi ditandai sudah dibaca."
  end
end
