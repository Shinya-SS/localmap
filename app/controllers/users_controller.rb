class UsersController < ApplicationController

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

  def auto_complete
    stations = Station.select(:name).distinct.where("name like '%" + params[:term] + "%'").order(:name)
    stations = stations.map(&:name)
    render json: stations.to_json
  end

  private
  def user_params
    params.require(:user).permit(:userid, :name, :email, :station, :password, :password_confirmation)
  end
end