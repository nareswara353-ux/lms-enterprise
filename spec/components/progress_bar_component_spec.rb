require 'rails_helper'

RSpec.describe ProgressBarComponent, type: :component do
  it "renders progress value" do
    render_inline(described_class.new(progress: 50, label: "Progress"))
    expect(page).to have_text("50%")
  end

  it "clamps progress above 100" do
    render_inline(described_class.new(progress: 150))
    expect(page).to have_css(".progress-fill[style*='width: 100%']")
  end

  it "clamps progress below 0" do
    render_inline(described_class.new(progress: -10))
    expect(page).to have_css(".progress-fill[style*='width: 0%']")
  end

  it "applies low variant for progress under 30" do
    render_inline(described_class.new(progress: 20))
    expect(page).to have_css(".progress-fill.progress-low")
  end

  it "applies mid variant for progress under 70" do
    render_inline(described_class.new(progress: 50))
    expect(page).to have_css(".progress-fill.progress-mid")
  end

  it "applies high variant for progress 70 or above" do
    render_inline(described_class.new(progress: 90))
    expect(page).to have_css(".progress-fill.progress-high")
  end
end
