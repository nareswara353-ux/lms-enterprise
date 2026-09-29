class Lesson < ApplicationRecord
  enum :status, { draft: 0, published: 1 }
  enum :lesson_type, { video: 0, text: 1, quiz: 2 }

  belongs_to :course_module
  has_one :course, through: :course_module
  has_many :quiz_submissions, dependent: :destroy
  has_many :lesson_completions, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :position, uniqueness: { scope: :course_module_id }
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, if: -> { title.present? && slug.blank? }
  before_validation :set_default_position, on: :create

  scope :ordered, -> { order(:position) }
  scope :published, -> { where(status: :published) }

  def completed_by?(user)
    lesson_completions.exists?(user: user)
  end

  private

  def generate_slug
    self.slug = "#{course_module.course.slug}-#{title.parameterize}"
  end

  def set_default_position
    self.position = course_module.lessons.maximum(:position).to_i + 1 if position.blank?
  end

  def to_param
    slug
  end
end
