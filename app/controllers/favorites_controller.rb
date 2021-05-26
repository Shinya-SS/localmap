class FavoritesController < ApplicationController

    before_action :set_favorite, only: [:create, :delete]

    def index
        @favorite_topics = current_user.favorite_topics
    end

    def create
        user = current_user
        topic = Topic.find(params[:topic_id])
        favorite = Favorite.create(user_id: user.id, topic_id: topic.id)
        
        favorite.save
    end

    def delete
        user = current_user
        topic = Topic.find(params[:topic_id])
        favorite = Favorite.find_by(user_id: user.id, topic_id: topic.id)
    
        favorite.delete
    end

    private

    def set_favorite
        @topic = Topic.find(params[:topic_id])
    end
end
