class StatComponent < ApplicationComponent
  def initialize(label:, value:, icon: nil)
    @label = label
    @value = value
    @icon = icon
  end

  private

  attr_reader :label, :value, :icon

  def formatted_value
    value.is_a?(Numeric) ? number_with_delimiter(value) : value
  end
end
