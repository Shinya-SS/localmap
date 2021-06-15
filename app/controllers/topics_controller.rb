class TopicsController < ApplicationController

  before_action :set_topic, only: [:edit, :update]

  def new
    @topic = Topic.new
    @env = get_apikey

    stations = Station.all
    stations = stations.map(&:name)

    respond_to do |format|
      format.html
      format.json { render json: stations.to_json }
    end
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

  def edit
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_path(@topic), success: '編集に成功しました' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { flash.now[:danger] = "編集に失敗しました"
          render :edit}
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def auto_complete
    stations = Station.select(:name).distinct.where("name like '%" + params[:term] + "%'").order(:name)
    stations = stations.map(&:name)
    render json: stations.to_json
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :description, :station, :latitude, :longitude, :picture_1, :picture_2, :picture_3)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def get_apikey
    # ENV['GOOGLE_MAP_API']
    # ''
  end

end
