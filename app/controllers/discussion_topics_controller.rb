class DiscussionTopicsController < ApplicationController
  before_action :set_course, only: [:index, :create]
  before_action :set_topic, only: [:show, :update, :destroy]

  def index
    @topics = @course.discussion_topics.pinned_first.includes(:user)
  end

  def show
    authorize @topic
    @posts = @topic.posts.root_posts.includes(:user, replies: :user).ordered
    @new_post = DiscussionPost.new
  end

  def create
    @topic = @course.discussion_topics.build(topic_params.merge(user: current_user))
    authorize @topic
    if @topic.save
      redirect_to course_discussion_topic_path(@course, @topic), notice: "Topik dibuat."
    else
      redirect_to course_path(@course), alert: @topic.errors.full_messages.join(", ")
    end
  end

  def update
    authorize @topic
    if @topic.update(topic_params)
      redirect_to course_discussion_topic_path(@topic.course, @topic), notice: "Topik diperbarui."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @topic
    course = @topic.course
    @topic.destroy
    redirect_to course_discussion_topics_path(course), notice: "Topik dihapus."
  end

  private

  def set_course
    @course = Course.find_by!(slug: params.expect(:course_id))
  end

  def set_topic
    @topic = DiscussionTopic.find(params.expect(:id))
  end

  def topic_params
    params.expect(discussion_topic: [:title, :content, :status, :pinned])
  end
end
