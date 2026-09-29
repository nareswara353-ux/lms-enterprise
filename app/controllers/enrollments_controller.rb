class EnrollmentsController < ApplicationController
  before_action :set_course, only: [:create]

  def create
    result = CourseEnrollmentService.new(user: current_user, course: @course).call
    if result.success?
      redirect_to course_path(@course), notice: "Berhasil mendaftar di course."
    else
      redirect_to course_path(@course), alert: result.error
    end
  end

  def destroy
    enrollment = current_user.enrollments.find(params.expect(:id))
    authorize enrollment
    course = enrollment.course
    enrollment.destroy
    redirect_to course_path(course), notice: "Pendaftaran dibatalkan."
  end

  private

  def set_course
    @course = Course.find_by!(slug: params.expect(:course_id))
  end
end
