module Api
  module V1
    class EnrollmentsController < BaseController
      include ApiAuthenticatable

      def create
        course = Course.find(params.expect(:course_id))
        result = CourseEnrollmentService.new(user: current_api_user, course: course).call
        if result.success?
          render json: { id: result.enrollment.id, status: result.enrollment.status }, status: :created
        else
          render json: { error: result.error }, status: :unprocessable_content
        end
      end

      def destroy
        enrollment = current_api_user.enrollments.find(params.expect(:id))
        authorize enrollment, :destroy?
        enrollment.destroy
        head :no_content
      end
    end
  end
end
