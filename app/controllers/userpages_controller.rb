class UserpagesController < ApplicationController
    def index
        # リンクされてきたユーザIDを引数として受け取る
        user_id = params[:id]
        @user = User.find(user_id)

        # ユーザページの投稿したもの上位４件
        @my_topics = @user.topics.order(updated_at: :desc).limit(4)

        # ユーザページのいいねしたもの上位４件
        @my_fav_topics = @user.favorite_topics.order(updated_at: :desc).limit(4)
    end

    # Myスポット一覧
    def myspot
        # リンクされてきたユーザIDを引数として受け取る
        user_id = params[:id]
        @user = User.find(user_id)

        @favorite_topics = @user.favorite_topics.order(updated_at: :desc)
    end
    
    #投稿一覧
    def mypost
        # リンクされてきたユーザIDを引数として受け取る
        user_id = params[:id]
        @user = User.find(user_id)

        @mytopics = @user.topics.order(updated_at: :desc)
    end
end
