require 'rails_helper'

RSpec.describe LessonItemComponent, type: :component do
  let(:lesson) { create(:lesson, title: "Intro to Rails", duration: 15) }

  it "renders lesson title and duration" do
    render_inline(described_class.new(lesson: lesson))
    expect(page).to have_text("Intro to Rails")
    expect(page).to have_text("15 menit")
  end

  it "shows pending icon when not completed" do
    render_inline(described_class.new(lesson: lesson, completed: false))
    expect(page).to have_css(".lesson-pending")
  end

  it "shows completed icon when completed" do
    render_inline(described_class.new(lesson: lesson, completed: true))
    expect(page).to have_css(".lesson-completed")
  end

  it "links to lesson path" do
    render_inline(described_class.new(lesson: lesson))
    expect(page).to have_link("Intro to Rails", href: lesson_path(lesson))
  end
end
