class TopicsController < ApplicationController

  def new
    @topic = Topic.new
    @env = get_apikey
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to mypages_index_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def search
    @env = get_apikey
    @topics = Topic.search(params[:search])
    gon.topics = @topics
  end

  def show
    @env = get_apikey
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    #コメントを作成日の降順で取得
    @comments = @topic.comments.order(id: :desc)
    
    gon.topic = @topic
    gon.ido = @topic.latitude
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :description, :station, :latitude, :longitude, :picture_1, :picture_2, :picture_3, :picture_4, :picture_5)
  end

  def get_apikey
    # ENV['GOOGLE_MAP_API']
    # ''
  end
end
