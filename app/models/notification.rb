class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :notifiable, polymorphic: true, optional: true

  validates :message, presence: true, length: { maximum: 500 }

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }
  scope :recent, -> { order(created_at: :desc).limit(50) }

  after_create_commit :broadcast_to_recipient

  def mark_as_read!
    update(read: true)
  end

  def mark_as_unread!
    update(read: false)
  end

  private

  def broadcast_to_recipient
    NotificationBroadcastJob.perform_later(id)
  end
end
