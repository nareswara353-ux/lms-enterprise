class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show], raise: false
  before_action :set_course, only: [:show, :edit, :update, :destroy, :students, :analytics]

  def index
    @courses = policy_scope(Course).includes(:instructor).order(created_at: :desc)
  end

  def show
    authorize @course
    @modules = @course.modules.published.ordered.includes(:lessons)
    @enrollment = current_user&.enrollments&.find_by(course: @course)
  end

  def new
    @course = Course.new
    authorize @course
  end

  def edit
    authorize @course
  end

  def create
    @course = current_user.courses.build(course_params)
    authorize @course
    if @course.save
      redirect_to @course, notice: "Course berhasil dibuat."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    authorize @course
    if @course.update(course_params)
      redirect_to @course, notice: "Course berhasil diperbarui."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @course
    @course.destroy
    redirect_to courses_path, notice: "Course dihapus."
  end

  def students
    authorize @course
    @students = @course.students.includes(:enrollments)
  end

  def analytics
    authorize @course
    @total_enrollments = @course.enrollments.count
    @completed_count = @course.enrollments.completed.count
    @average_progress = @course.enrollments.average(:progress)&.round(2) || 0
  end

  private

  def set_course
    @course = Course.find_by!(slug: params.expect(:id))
  end

  def course_params
    params.expect(course: [:title, :description, :price, :status, :level, :duration, :cover_image])
  end
end
