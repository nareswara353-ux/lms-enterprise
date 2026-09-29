class EnrollmentQuery < ApplicationQuery
  def call
    relation
      .then { |r| filter_by_status(r) }
      .then { |r| filter_by_course(r) }
      .then { |r| filter_by_user(r) }
      .then { |r| filter_by_progress(r) }
      .then { |r| sorted(r) }
  end

  private

  def default_relation
    Enrollment.includes(:user, :course)
  end

  def filter_by_status(r)
    params[:status].present? ? r.where(status: params[:status]) : r
  end

  def filter_by_course(r)
    params[:course_id].present? ? r.where(course_id: params[:course_id]) : r
  end

  def filter_by_user(r)
    params[:user_id].present? ? r.where(user_id: params[:user_id]) : r
  end

  def filter_by_progress(r)
    return r if params[:min_progress].blank?

    r.where("progress >= ?", params[:min_progress])
  end

  def sorted(r)
    case params[:sort]
    when "progress_asc" then r.order(progress: :asc)
    when "progress_desc" then r.order(progress: :desc)
    else r.order(created_at: :desc)
    end
  end
end
