class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
    stations = Station.all
    stations = stations.map(&:name)

    # jsonファイル確認用
    respond_to do |format|
      format.html
      format.json { render json: stations.to_json }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    
  end

  def update
      respond_to do |format|
          if @user.update(user_update_params)
              format.html { redirect_to userpages_path(id: @user.id), success: '編集に成功しました' }
              format.json { render :show, status: :ok, location: @user }
          else
              format.html { flash.now[:danger] = "編集に失敗しました"
                  render :edit}
              format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      end
  end

  def auto_complete
    stations = Station.select(:name).distinct.where("name like '%" + params[:term] + "%'").order(:name)
    stations = stations.map(&:name)
    render json: stations.to_json
  end

  private
  def user_params
    params.require(:user).permit(:userid, :name, :email, :station, :password, :password_confirmation, :introduction, :icon)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :station, :introduction, :icon)
  end
end