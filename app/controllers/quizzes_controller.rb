class QuizzesController < ApplicationController
  before_action :set_course, only: [:index, :create]
  before_action :set_quiz, only: [:show, :update, :destroy, :start, :submit]

  def index
    @quizzes = @course.quizzes
  end

  def show
    authorize @quiz
    @submission = @quiz.quiz_submissions.find_by(user: current_user)
  end

  def create
    @quiz = @course.quizzes.build(quiz_params)
    authorize @quiz
    if @quiz.save
      redirect_to course_quiz_path(@course, @quiz), notice: "Quiz dibuat."
    else
      redirect_to @course, alert: @quiz.errors.full_messages.join(", ")
    end
  end

  def update
    authorize @quiz
    if @quiz.update(quiz_params)
      redirect_to course_quiz_path(@quiz.course, @quiz), notice: "Quiz diperbarui."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @quiz
    course = @quiz.course
    @quiz.destroy
    redirect_to course_path(course), notice: "Quiz dihapus."
  end

  def start
    authorize @quiz, :start?
    submission = @quiz.quiz_submissions.create!(user: current_user, status: :in_progress, started_at: Time.current)
    redirect_to quiz_submission_path(submission)
  end

  def submit
    authorize @quiz, :submit?
    submission = @quiz.quiz_submissions.find(params.expect(:submission_id))
    submission.update!(answers: params[:answers]&.to_unsafe_h || {})
    QuizGradingService.new(submission).call
    redirect_to quiz_submission_path(submission), notice: "Quiz selesai."
  end

  private

  def set_course
    @course = Course.find_by!(slug: params.expect(:course_id))
  end

  def set_quiz
    @quiz = Quiz.find(params.expect(:id))
  end

  def quiz_params
    params.expect(quiz: [:title, :description, :time_limit, :passing_score, :status, :lesson_id])
  end
end
