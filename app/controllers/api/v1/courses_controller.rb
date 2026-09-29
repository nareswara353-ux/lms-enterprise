module Api
  module V1
    class CoursesController < BaseController
      before_action :set_course, only: [:show]

      def index
        courses = CourseQuery.call(policy_scope(Course), query_params)
        courses = courses.page(params[:page]).per(params[:per_page] || 20)
        render json: {
          data: courses.map { |c| course_payload(c) },
          meta: pagination_meta(courses)
        }
      end

      def show
        authorize @course, :show?
        render json: course_payload(@course, detailed: true)
      end

      private

      def query_params
        params.permit(:q, :status, :level, :instructor_id, :price, :sort).to_h
      end

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count,
          per_page: collection.limit_value
        }
      end

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
