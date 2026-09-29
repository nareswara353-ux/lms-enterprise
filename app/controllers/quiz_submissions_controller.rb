class QuizSubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :update, :grade]

  def show
    authorize @submission
    @quiz = @submission.quiz
    @questions = @quiz.quiz_questions.includes(:question).order(:position)
  end

  def create
    quiz = Quiz.find(params.expect(:quiz_id))
    @submission = quiz.quiz_submissions.build(user: current_user, status: :in_progress)
    authorize @submission
    if @submission.save
      redirect_to quiz_submission_path(@submission)
    else
      redirect_to quiz_path(quiz), alert: @submission.errors.full_messages.join(", ")
    end
  end

  def update
    authorize @submission
    @submission.update!(answers: params[:answers]&.to_unsafe_h || {})
    QuizGradingService.new(@submission).call
    redirect_to quiz_submission_path(@submission), notice: "Quiz dinilai."
  end

  def grade
    authorize @submission, :grade?
    QuizGradingService.new(@submission).call
    redirect_to quiz_submission_path(@submission), notice: "Re-grading selesai."
  end

  private

  def set_submission
    @submission = QuizSubmission.find(params.expect(:id))
  end
end
