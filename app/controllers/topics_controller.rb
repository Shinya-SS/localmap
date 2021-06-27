class TopicsController < ApplicationController

  before_action :set_topic, only: [:edit, :update, :destroy]
  before_action :login_chk, only: [:new, :create, :edit, :update]

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

    #初回表示なら
    if params[:search].nil?
      search_station = current_user.station
    else
      search_station = params[:search]
    end
    @topics = Topic.search(search_station)
    #検索結果の上位５件
    gon.topics = @topics.limit(5)
    #初期表示：ログインユーザの最寄駅/検索：検索した駅名
    gon.station = search_station

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

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html{ redirect_to _path , success: '削除に成功しました' }
      format.json{ head :no_content }
    end
  end

  def auto_complete
    stations = Station.select(:name).distinct.where("name like '%" + params[:term] + "%'").order(:name)
    stations = stations.map(&:name)
    render json: stations.to_json
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :description, :station, :latitude, :longitude, :picture_1, :picture_2, :picture_3, :remove_picture_1, :remove_picture_2, :remove_picture_3)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end
