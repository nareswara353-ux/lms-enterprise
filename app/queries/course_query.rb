class CourseQuery < ApplicationQuery
  def call
    relation
      .then { |rel| filter_by_status(rel) }
      .then { |rel| filter_by_level(rel) }
      .then { |rel| filter_by_instructor(rel) }
      .then { |rel| filter_by_price(rel) }
      .then { |rel| search(rel) }
      .then { |rel| sorted(rel) }
  end

  private

  def default_relation
    Course.includes(:instructor)
  end

  def filter_by_status(rel)
    params[:status].present? ? rel.where(status: params[:status]) : rel
  end

  def filter_by_level(rel)
    params[:level].present? ? rel.where(level: params[:level]) : rel
  end

  def filter_by_instructor(rel)
    params[:instructor_id].present? ? rel.where(instructor_id: params[:instructor_id]) : rel
  end

  def filter_by_price(rel)
    case params[:price]
    when "free" then rel.where(price: 0)
    when "paid" then rel.where("price > 0")
    else rel
    end
  end

  def search(rel)
    params[:q].present? ? rel.search_by_title(params[:q]) : rel
  end

  def sorted(rel)
    case params[:sort]
    when "price_asc" then rel.order(price: :asc)
    when "price_desc" then rel.order(price: :desc)
    when "popular" then rel.order(enrollments_count: :desc)
    else rel.order(created_at: :desc)
    end
  end
end
