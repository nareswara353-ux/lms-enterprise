class EmptyStateComponent < ApplicationComponent
  def initialize(title:, description: nil, icon: "📭", action_label: nil, action_path: nil)
    @title = title
    @description = description
    @icon = icon
    @action_label = action_label
    @action_path = action_path
  end

  private

  attr_reader :title, :description, :icon, :action_label, :action_path

  def action?
    action_label.present? && action_path.present?
  end
end
