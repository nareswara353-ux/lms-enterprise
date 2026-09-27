require 'rails_helper'

RSpec.describe ApplicationComponent, type: :component do
  it "inherits from ViewComponent::Base" do
    expect(described_class.superclass).to eq(ViewComponent::Base)
  end
end
