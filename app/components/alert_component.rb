class AlertComponent < ApplicationComponent
  VARIANTS = {
    notice: "flash-notice",
    success: "flash-success",
    alert: "flash-alert",
    warning: "flash-warning",
    info: "flash-info"
  }.freeze

  def initialize(message:, variant: :info, dismissible: false)
    @message = message
    @variant = variant
    @dismissible = dismissible
  end

  private

  attr_reader :message, :variant, :dismissible

  def css_class
    "flash #{VARIANTS[variant.to_sym] || 'flash-info'}"
  end

  def dismissible?
    dismissible
  end
end
