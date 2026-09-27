class BadgeComponent < ApplicationComponent
  VARIANTS = {
    beginner: "badge-beginner",
    intermediate: "badge-intermediate",
    advanced: "badge-advanced",
    draft: "badge-draft",
    published: "badge-published",
    active: "badge-active",
    completed: "badge-completed",
    dropped: "badge-dropped",
    pending: "badge-pending",
    successful: "badge-successful",
    failed: "badge-failed",
    refunded: "badge-refunded"
  }.freeze

  def initialize(label:, variant: nil)
    @label = label
    @variant = variant
  end

  private

  attr_reader :label, :variant

  def css_class
    "badge #{VARIANTS[variant&.to_sym] || ''}".strip
  end
end
