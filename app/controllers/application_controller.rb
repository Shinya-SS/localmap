class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    add_flash_types :success, :info, :warning, :danger

    helper_method :current_user, :logged_in?

    before_action :current_user

    def current_user
        #非ログインユーザの場合ダミーユーザとして機能させる
        current_user = User.find_by(id: session[:user_id])
        if current_user.nil?
            @current_user = User.find_by(id: 0)
        else
            @current_user ||= current_user
        end
    end
    
    def logged_in?
        !current_user.nil? && current_user.id != 0
    end

    def login_chk
        if current_user.nil? || current_user.id == 0
            flash[:danger] = "ログインが必要です。"
            redirect_to("/mypages/index")
        end
    end
    
    private 
    def get_apikey
        ENV['GOOGLE_MAP_API']
        # ''
    end
end
