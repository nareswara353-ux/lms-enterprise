require 'rails_helper'

RSpec.describe PaginationComponent, type: :component do
  let(:collection) do
    Kaminari.paginate_array((1..50).to_a).page(2).per(10)
  end

  it "renders navigation when multiple pages" do
    render_inline(described_class.new(collection: collection))
    expect(page).to have_css("nav.pagination")
  end

  it "renders prev and next links" do
    render_inline(described_class.new(collection: collection))
    expect(page).to have_link("← Prev")
    expect(page).to have_link("Next →")
  end

  it "highlights current page" do
    render_inline(described_class.new(collection: collection))
    expect(page).to have_css(".page-link.active", text: "2")
  end

  it "does not render for single page collection" do
    single = Kaminari.paginate_array([1, 2, 3]).page(1).per(10)
    render_inline(described_class.new(collection: single))
    expect(page).not_to have_css("nav.pagination")
  end
end
