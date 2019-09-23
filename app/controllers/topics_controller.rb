class TopicsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :correct_user, only: :destroy

  def new
    @topic = Topic.new
  end

  def index
    @topics = Topic.paginate(page: params[:page])
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = "トピックを作成しました"
      redirect_to root_url
    else
      render 'topics/new'
    end
  end

  def destroy
    @topic.destroy
    flash[:success] = "トピックを削除しました"
    redirect_to request.referrer || root_url
  end

  private

    def topic_params
      params.require(:topic).permit(:title)
    end

    def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to root_url if @topic.nil?
    end
end
