require 'rails_helper'

RSpec.describe CourseQuery do
  let!(:published) { create(:course, :free, status: :published, level: :beginner) }
  let!(:draft) { create(:course, status: :draft) }
  let!(:advanced) { create(:course, :paid, status: :published, level: :advanced) }

  describe ".call" do
    it "returns all courses without params" do
      expect(described_class.call.count).to eq(3)
    end

    it "filters by status" do
      result = described_class.call(nil, status: "published")
      expect(result).to include(published, advanced)
      expect(result).not_to include(draft)
    end

    it "filters by level" do
      result = described_class.call(nil, level: "advanced")
      expect(result).to include(advanced)
      expect(result).not_to include(published)
    end

    it "filters free courses" do
      result = described_class.call(nil, price: "free")
      expect(result).to include(published)
      expect(result).not_to include(advanced)
    end

    it "filters paid courses" do
      result = described_class.call(nil, price: "paid")
      expect(result).to include(advanced)
      expect(result).not_to include(published)
    end

    it "sorts by price ascending" do
      result = described_class.call(nil, sort: "price_asc")
      expect(result.first).to eq(published)
    end

    it "sorts by price descending" do
      result = described_class.call(nil, sort: "price_desc")
      expect(result.first).to eq(advanced)
    end
  end
end
