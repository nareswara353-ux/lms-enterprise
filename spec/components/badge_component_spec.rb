require 'rails_helper'

RSpec.describe BadgeComponent, type: :component do
  it "renders label" do
    render_inline(described_class.new(label: "Draft"))
    expect(page).to have_text("Draft")
  end

  it "applies variant class for beginner" do
    render_inline(described_class.new(label: "Beginner", variant: :beginner))
    expect(page).to have_css("span.badge-beginner")
  end

  it "applies variant class for published" do
    render_inline(described_class.new(label: "Published", variant: :published))
    expect(page).to have_css("span.badge-published")
  end

  it "renders with default badge class when variant nil" do
    render_inline(described_class.new(label: "Test"))
    expect(page).to have_css("span.badge")
  end
end
