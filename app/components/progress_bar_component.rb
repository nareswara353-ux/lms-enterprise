class ProgressBarComponent < ApplicationComponent
  def initialize(progress:, label: nil)
    @progress = progress.to_i.clamp(0, 100)
    @label = label
  end

  private

  attr_reader :progress, :label

  def variant
    return "progress-low" if progress < 30
    return "progress-mid" if progress < 70

    "progress-high"
  end
end
