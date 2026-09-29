class ApplicationController < ActionController::Base
  include Pundit::Authorization

  allow_browser versions: :modern

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    elsif resource.instructor?
      instructor_dashboard_path
    else
      dashboard_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :bio, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio, :avatar])
  end

  def user_not_authorized
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, alert: 'Anda tidak memiliki akses.') }
      format.json { render json: { error: 'Forbidden' }, status: :forbidden }
    end
  end

  def record_not_found
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'Data tidak ditemukan.' }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
