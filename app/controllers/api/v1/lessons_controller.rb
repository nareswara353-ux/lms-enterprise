module Api
  module V1
    class LessonsController < BaseController
      before_action :set_lesson, only: [:show]

      def show
        authorize @lesson, :show?
        render json: LessonSerializer.serialize(@lesson)
      end

      private

      def set_lesson
        @lesson = Lesson.find_by!(slug: params.expect(:id))
      end
    end
  end
end
