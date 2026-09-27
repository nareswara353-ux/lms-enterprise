class LessonItemComponent < ApplicationComponent
  def initialize(lesson:, completed: false)
    @lesson = lesson
    @completed = completed
  end

  private

  attr_reader :lesson

  def completed?
    @completed
  end

  def status_icon
    completed? ? "✓" : "○"
  end

  def status_class
    completed? ? "lesson-completed" : "lesson-pending"
  end
end
