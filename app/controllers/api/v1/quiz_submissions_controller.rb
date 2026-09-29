module Api
  module V1
    class QuizSubmissionsController < BaseController
      include ApiAuthenticatable

      before_action :set_submission, only: [:show]

      def show
        authorize @submission, :show?
        render json: QuizSubmissionSerializer.serialize(@submission)
      end

      def create
        quiz = Quiz.find(params.expect(:quiz_id))
        submission = quiz.quiz_submissions.create!(
          user: current_api_user,
          status: :in_progress,
          started_at: Time.current
        )
        authorize submission, :create?
        render json: QuizSubmissionSerializer.serialize(submission), status: :created
      end

      private

      def set_submission
        @submission = QuizSubmission.find(params.expect(:id))
      end
    end
  end
end
