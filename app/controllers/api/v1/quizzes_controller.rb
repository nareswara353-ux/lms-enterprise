module Api
  module V1
    class QuizzesController < BaseController
      include ApiAuthenticatable

      before_action :set_course, only: [:index]
      before_action :set_quiz, only: [:show]

      def index
        quizzes = @course.quizzes.published
        render json: QuizSerializer.serialize(quizzes)
      end

      def show
        authorize @quiz, :show?
        render json: QuizSerializer.serialize(@quiz)
      end

      private

      def set_course
        @course = Course.find_by!(slug: params.expect(:course_id))
      end

      def set_quiz
        @quiz = Quiz.find(params.expect(:id))
      end
    end
  end
end
