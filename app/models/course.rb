class Course < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title, against: [:title, :description], using: { tsearch: { prefix: true } }
  enum :status, { draft: 0, published: 1, archived: 2 }
  enum :level, { beginner: 0, intermediate: 1, advanced: 2 }

  belongs_to :instructor, class_name: "User"
  has_many :modules, class_name: "CourseModule", dependent: :destroy
  has_many :lessons, through: :modules
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user
  has_many :discussion_topics, dependent: :destroy
  has_many :quizzes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :description, length: { maximum: 2000 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :slug, presence: true, uniqueness: true
  validates :duration, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  before_validation :generate_slug, if: -> { title.present? && slug.blank? }

  def total_modules_count
    modules.published.count
  end

  def total_lessons_count
    modules.published.sum(:lessons_count)
  end

  def enrollment_count
    enrollments.active.count
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
