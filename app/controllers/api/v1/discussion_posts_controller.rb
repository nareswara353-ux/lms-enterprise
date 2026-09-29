module Api
  module V1
    class DiscussionPostsController < BaseController
      include ApiAuthenticatable

      before_action :set_topic, only: [:index, :create]
      before_action :set_post, only: [:show]

      def index
        posts = @topic.posts.root_posts.ordered
        render json: DiscussionPostSerializer.serialize(posts)
      end

      def show
        render json: DiscussionPostSerializer.serialize(@post)
      end

      def create
        post = @topic.posts.build(post_params.merge(user: current_api_user))
        if post.save
          render json: DiscussionPostSerializer.serialize(post), status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_content
        end
      end

      private

      def set_topic
        @topic = DiscussionTopic.find(params.expect(:discussion_topic_id))
      end

      def set_post
        @post = DiscussionPost.find(params.expect(:id))
      end

      def post_params
        params.expect(discussion_post: [:content, :parent_id])
      end
    end
  end
end
