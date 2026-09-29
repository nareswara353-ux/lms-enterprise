class CourseModule < ApplicationRecord
  def to_param
    id.to_s
  end
  enum :status, { draft: 0, published: 1 }

  belongs_to :course
  has_many :lessons, dependent: :destroy
  has_many :quizzes, through: :course

  validates :title, presence: true, length: { maximum: 150 }
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :position, uniqueness: { scope: :course_id }

  before_validation :set_default_position, on: :create

  scope :ordered, -> { order(:position) }

  def total_duration
    lessons.published.sum(:duration)
  end

  private

  def set_default_position
    self.position = course.course_modules.maximum(:position).to_i + 1 if position.blank?
  end
end
