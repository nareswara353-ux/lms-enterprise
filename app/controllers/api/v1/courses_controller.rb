module Api
  module V1
    class CoursesController < BaseController
      before_action :set_course, only: [:show]

      def index
        courses = policy_scope(Course).published
        courses = courses.where(level: params[:level]) if params[:level].present?
        courses = courses.order(created_at: :desc).page(params[:page]).per(params[:per_page] || 20)
        render json: courses.map { |c| course_payload(c) }
      end

      def show
        authorize @course, :show?
        render json: course_payload(@course, detailed: true)
      end

      private

      def set_course
        @course = Course.find_by!(slug: params.expect(:id))
      end

      def course_payload(course, detailed: false)
        payload = {
          id: course.id,
          title: course.title,
          slug: course.slug,
          description: course.description,
          level: course.level,
          price: course.price,
          instructor: { id: course.instructor.id, name: course.instructor.name }
        }
        if detailed
          payload[:modules] = course.modules.published.ordered.map do |m|
            { id: m.id, title: m.title, lessons_count: m.lessons_count }
          end
        end
        payload
      end
    end
  end
end
