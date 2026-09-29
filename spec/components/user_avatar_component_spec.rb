require 'rails_helper'

RSpec.describe UserAvatarComponent, type: :component do
  let(:user) { build(:user, name: "John Doe") }

  it "renders user initials" do
    render_inline(described_class.new(user: user))
    expect(page).to have_text("JD")
  end

  it "renders medium size by default" do
    render_inline(described_class.new(user: user))
    expect(page).to have_css(".avatar-medium")
  end

  it "renders small size variant" do
    render_inline(described_class.new(user: user, size: :small))
    expect(page).to have_css(".avatar-small")
  end

  it "renders name as title attribute" do
    render_inline(described_class.new(user: user))
    expect(page).to have_css("[title='John Doe']")
  end
end
