module ApiAuthenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_api_user!
  end

  private

  attr_reader :current_api_user

  def authenticate_api_user!
    token = request.headers["Authorization"]&.split&.last
    @current_api_user = User.find_by(api_token: token) if token.present?
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_api_user
  end
end
