class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  enum :role, { admin: 0, instructor: 1, student: 2 }

  has_many :courses, foreign_key: :instructor_id, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :quiz_submissions, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :discussion_posts, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 500 }
  validates :role, presence: true

  before_create :generate_api_token

  private

  def generate_api_token
    self.api_token ||= SecureRandom.hex(24)
  end
end
