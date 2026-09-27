require 'rails_helper'

RSpec.describe StatComponent, type: :component do
  it "renders label and value" do
    render_inline(described_class.new(label: "Users", value: 100))
    expect(page).to have_text("Users")
    expect(page).to have_text("100")
  end

  it "formats numeric value with delimiter" do
    render_inline(described_class.new(label: "Revenue", value: 1_500_000))
    expect(page).to have_text("1,500,000")
  end

  it "renders string value as-is" do
    render_inline(described_class.new(label: "Status", value: "Active"))
    expect(page).to have_text("Active")
  end

  it "renders icon when provided" do
    render_inline(described_class.new(label: "Users", value: 10, icon: "👤"))
    expect(page).to have_css(".stat-icon", text: "👤")
  end
end
