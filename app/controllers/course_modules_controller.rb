class CourseModulesController < ApplicationController
  before_action :set_course
  before_action :set_course_module, only: [:show, :update, :destroy]

  def show
    authorize @course_module
    @lessons = @course_module.lessons.published.ordered
  end

  def create
    @course_module = @course.course_modules.build(course_module_params)
    authorize @course_module
    if @course_module.save
      redirect_to @course, notice: "Modul ditambahkan."
    else
      redirect_to @course, alert: @course_module.errors.full_messages.join(", ")
    end
  end

  def update
    authorize @course_module
    if @course_module.update(course_module_params)
      redirect_to @course, notice: "Modul diperbarui."
    else
      redirect_to @course, alert: @course_module.errors.full_messages.join(", ")
    end
  end

  def destroy
    authorize @course_module
    @course_module.destroy
    redirect_to @course, notice: "Modul dihapus."
  end

  private

  def set_course
    @course = Course.find_by!(slug: params.expect(:course_id))
  end

  def set_course_module
    @course_module = @course.course_modules.find(params.expect(:id))
  end

  def course_module_params
    params.expect(course_module: [:title, :description, :position, :status])
  end
end
