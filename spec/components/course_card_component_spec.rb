require 'rails_helper'

RSpec.describe CourseCardComponent, type: :component do
  let(:course) { create(:course, :free, title: "Ruby Fundamentals", level: :beginner) }

  it "renders course title" do
    render_inline(described_class.new(course: course))
    expect(page).to have_text("Ruby Fundamentals")
  end

  it "renders instructor name" do
    render_inline(described_class.new(course: course))
    expect(page).to have_text(course.instructor.name)
  end

  it "renders Gratis for free course" do
    render_inline(described_class.new(course: course))
    expect(page).to have_text("Gratis")
  end

  it "renders price for paid course" do
    paid = create(:course, :paid)
    render_inline(described_class.new(course: paid))
    expect(page).to have_text("Rp")
  end

  it "renders level badge" do
    render_inline(described_class.new(course: course))
    expect(page).to have_css(".badge-beginner")
  end
end
