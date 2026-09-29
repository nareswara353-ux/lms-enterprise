class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index], raise: false

  def index
    @featured_courses = Course.published
                              .includes(:instructor)
                              .order(created_at: :desc)
                              .limit(6)
    @total_courses = Course.published.count
    @total_students = User.student.count
    @total_instructors = User.instructor.count
  end
end
