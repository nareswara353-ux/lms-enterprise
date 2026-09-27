class CourseCardComponent < ApplicationComponent
  def initialize(course:)
    @course = course
  end

  private

  attr_reader :course

  def formatted_price
    return "Gratis" unless course.price.positive?

    number_to_currency(course.price, unit: "Rp", precision: 0)
  end
end
