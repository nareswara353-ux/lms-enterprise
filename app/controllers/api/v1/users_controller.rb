module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: [:show]

      def show
        authorize @user, :show?
        render json: UserSerializer.serialize(@user)
      end

      private

      def set_user
        @user = User.find(params.expect(:id))
      end
    end
  end
end
