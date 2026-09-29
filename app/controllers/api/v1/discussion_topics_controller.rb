module Api
  module V1
    class DiscussionTopicsController < BaseController
      include ApiAuthenticatable

      before_action :set_course, only: [:index, :create]
      before_action :set_topic, only: [:show]

      def index
        topics = @course.discussion_topics.pinned_first
        render json: DiscussionTopicSerializer.serialize(topics)
      end

      def show
        authorize @topic, :show?
        render json: DiscussionTopicSerializer.serialize(@topic)
      end

      def create
        topic = @course.discussion_topics.build(topic_params.merge(user: current_api_user))
        authorize topic, :create?
        if topic.save
          render json: DiscussionTopicSerializer.serialize(topic), status: :created
        else
          render json: { errors: topic.errors.full_messages }, status: :unprocessable_content
        end
      end

      private

      def set_course
        @course = Course.find_by!(slug: params.expect(:course_id))
      end

      def set_topic
        @topic = DiscussionTopic.find(params.expect(:id))
      end

      def topic_params
        params.expect(discussion_topic: [:title, :content, :pinned])
      end
    end
  end
end
