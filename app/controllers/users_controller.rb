class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    authorize @user
    @courses = @user.courses.published if @user.instructor?
    @enrollments = @user.enrollments.includes(:course) if @user.student?
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profil diperbarui."
    else
      render :show, status: :unprocessable_content
    end
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.expect(user: [:name, :bio, :avatar])
  end
end
