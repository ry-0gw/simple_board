class PostsController < ApplicationController
  before_action :logged_in_user

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to @post.topic
    else
      @posts = []
      render 'topics/show'
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

end
