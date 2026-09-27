require 'rails_helper'

RSpec.describe AlertComponent, type: :component do
  it "renders message" do
    render_inline(described_class.new(message: "Success!"))
    expect(page).to have_text("Success!")
  end

  it "applies notice variant" do
    render_inline(described_class.new(message: "OK", variant: :notice))
    expect(page).to have_css(".flash-notice")
  end

  it "applies alert variant" do
    render_inline(described_class.new(message: "Error", variant: :alert))
    expect(page).to have_css(".flash-alert")
  end

  it "does not render close button by default" do
    render_inline(described_class.new(message: "Test"))
    expect(page).not_to have_css("button.alert-close")
  end

  it "renders close button when dismissible" do
    render_inline(described_class.new(message: "Test", dismissible: true))
    expect(page).to have_css("button.alert-close")
  end
end
