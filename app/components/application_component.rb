class ApplicationComponent < ViewComponent::Base
  private

  def merge_class(*classes)
    classes.compact.join(" ")
  end
end
