require 'rails_helper'

RSpec.describe EmptyStateComponent, type: :component do
  it "renders title" do
    render_inline(described_class.new(title: "No courses"))
    expect(page).to have_text("No courses")
  end

  it "renders description when provided" do
    render_inline(described_class.new(title: "Empty", description: "Try again"))
    expect(page).to have_text("Try again")
  end

  it "renders action link when provided" do
    render_inline(described_class.new(title: "Empty", action_label: "Browse", action_path: "/courses"))
    expect(page).to have_link("Browse", href: "/courses")
  end

  it "does not render action link when missing" do
    render_inline(described_class.new(title: "Empty"))
    expect(page).not_to have_css("a.btn")
  end
end
