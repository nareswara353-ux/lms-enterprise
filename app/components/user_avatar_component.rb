class UserAvatarComponent < ApplicationComponent
  def initialize(user:, size: :medium)
    @user = user
    @size = size
  end

  private

  attr_reader :user, :size

  def initials
    user.name.to_s.split.map { |n| n[0] }.first(2).join.upcase
  end

  def css_size
    "avatar-#{size}"
  end
end
