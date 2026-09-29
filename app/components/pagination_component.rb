class PaginationComponent < ApplicationComponent
  def initialize(collection:, params: {})
    @collection = collection
    @params = params
  end

  private

  attr_reader :collection, :params

  def current_page
    collection.current_page
  end

  def total_pages
    collection.total_pages
  end

  def prev_page?
    current_page > 1
  end

  def next_page?
    current_page < total_pages
  end

  def page_range
    ([current_page - 2, 1].max..[current_page + 2, total_pages].min)
  end
end
