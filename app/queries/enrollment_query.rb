class EnrollmentQuery < ApplicationQuery
  def call
    relation
      .then { |rel| filter_by_status(rel) }
      .then { |rel| filter_by_course(rel) }
      .then { |rel| filter_by_user(rel) }
      .then { |rel| filter_by_progress(rel) }
      .then { |rel| sorted(rel) }
  end

  private

  def default_relation
    Enrollment.includes(:user, :course)
  end

  def filter_by_status(rel)
    params[:status].present? ? rel.where(status: params[:status]) : rel
  end

  def filter_by_course(rel)
    params[:course_id].present? ? rel.where(course_id: params[:course_id]) : rel
  end

  def filter_by_user(rel)
    params[:user_id].present? ? rel.where(user_id: params[:user_id]) : rel
  end

  def filter_by_progress(rel)
    return rel if params[:min_progress].blank?

    rel.where(progress: (params[:min_progress])..)
  end

  def sorted(rel)
    case params[:sort]
    when "progress_asc" then rel.order(progress: :asc)
    when "progress_desc" then rel.order(progress: :desc)
    else rel.order(created_at: :desc)
    end
  end
end
