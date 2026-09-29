class LessonsController < ApplicationController
  before_action :set_course_module, only: [:create]
  before_action :set_lesson, only: [:show, :update, :destroy, :complete, :incomplete]

  def show
    authorize @lesson
    @course = @lesson.course
    @next_lesson = @lesson.course_module.lessons.ordered.where("position > ?", @lesson.position).first
    @completed = @lesson.completed_by?(current_user)
  end

  def create
    @lesson = @course_module.lessons.build(lesson_params)
    authorize @lesson
    if @lesson.save
      redirect_to course_path(@course_module.course), notice: "Lesson ditambahkan."
    else
      redirect_to course_path(@course_module.course), alert: @lesson.errors.full_messages.join(", ")
    end
  end

  def update
    authorize @lesson
    if @lesson.update(lesson_params)
      redirect_to course_module_lesson_path(@lesson.course_module, @lesson), notice: "Lesson diperbarui."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @lesson
    course = @lesson.course
    @lesson.destroy
    redirect_to course_path(course), notice: "Lesson dihapus."
  end

  def complete
    authorize @lesson, :show?
    LessonCompletion.find_or_create_by!(user: current_user, lesson: @lesson)
    redirect_to course_module_lesson_path(@lesson.course_module, @lesson), notice: "Lesson selesai!"
  end

  def incomplete
    authorize @lesson, :show?
    LessonCompletion.where(user: current_user, lesson: @lesson).destroy_all
    redirect_to course_module_lesson_path(@lesson.course_module, @lesson), notice: "Progress dibatalkan."
  end

  private

  def set_course_module
    @course_module = CourseModule.find(params.expect(:course_module_id))
  end

  def set_lesson
    @lesson = Lesson.find_by!(slug: params.expect(:id))
  end

  def lesson_params
    params.expect(lesson: [:title, :content, :video_url, :duration, :position, :status, :lesson_type])
  end
end
