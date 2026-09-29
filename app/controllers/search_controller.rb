class SearchController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    @query = params[:q].to_s.strip
    return if @query.blank?

    @courses = Course.published.search_by_title(@query).limit(20)
    @users = User.where("name ILIKE ?", "%#{@query}%").limit(10)
  end
end
