require 'rails_helper'

RSpec.describe EnrollmentQuery do
  let(:user) { create(:user, :student) }
  let(:course) { create(:course, :free) }
  let!(:active) { create(:enrollment, user: user, course: course, status: :active, progress: 30) }
  let!(:completed) { create(:enrollment, :completed) }

  describe ".call" do
    it "returns all enrollments without params" do
      expect(described_class.call.count).to eq(2)
    end

    it "filters by status" do
      result = described_class.call(nil, status: "completed")
      expect(result).to include(completed)
      expect(result).not_to include(active)
    end

    it "filters by user" do
      result = described_class.call(nil, user_id: user.id)
      expect(result).to include(active)
      expect(result).not_to include(completed)
    end

    it "filters by minimum progress" do
      result = described_class.call(nil, min_progress: 50)
      expect(result).to include(completed)
      expect(result).not_to include(active)
    end

    it "sorts by progress ascending" do
      result = described_class.call(nil, sort: "progress_asc")
      expect(result.first).to eq(active)
    end
  end
end
