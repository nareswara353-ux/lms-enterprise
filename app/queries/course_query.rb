class CourseQuery < ApplicationQuery
  def call
    relation
      .then { |r| filter_by_status(r) }
      .then { |r| filter_by_level(r) }
      .then { |r| filter_by_instructor(r) }
      .then { |r| filter_by_price(r) }
      .then { |r| search(r) }
      .then { |r| sorted(r) }
  end

  private

  def default_relation
    Course.includes(:instructor)
  end

  def filter_by_status(r)
    params[:status].present? ? r.where(status: params[:status]) : r
  end

  def filter_by_level(r)
    params[:level].present? ? r.where(level: params[:level]) : r
  end

  def filter_by_instructor(r)
    params[:instructor_id].present? ? r.where(instructor_id: params[:instructor_id]) : r
  end

  def filter_by_price(r)
    case params[:price]
    when "free" then r.where(price: 0)
    when "paid" then r.where("price > 0")
    else r
    end
  end

  def search(r)
    params[:q].present? ? r.search_by_title(params[:q]) : r
  end

  def sorted(r)
    case params[:sort]
    when "price_asc" then r.order(price: :asc)
    when "price_desc" then r.order(price: :desc)
    when "popular" then r.order(enrollments_count: :desc)
    else r.order(created_at: :desc)
    end
  end
end
