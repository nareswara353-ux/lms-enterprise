module Users
  class RegistrationsController < Devise::RegistrationsController
    private

    def sign_up_params
      params.expect(user: [:name, :email, :password, :password_confirmation, :bio, :role])
    end

    def account_update_params
      params.expect(user: [:name, :email, :password, :password_confirmation, :current_password, :bio, :avatar])
    end

    def after_sign_up_path_for(_resource)
      dashboard_path
    end
  end
end
