module Api
  module V1
    class NotificationsController < BaseController
      include ApiAuthenticatable

      def index
        notifications = current_api_user.notifications.recent
        render json: NotificationSerializer.serialize(notifications)
      end

      def update
        notification = current_api_user.notifications.find(params.expect(:id))
        notification.mark_as_read!
        render json: NotificationSerializer.serialize(notification)
      end
    end
  end
end
