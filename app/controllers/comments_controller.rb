class CommentsController < ApplicationController

    def create
        user = current_user
        topic = Topic.find(params[:comment][:topic_id])
        comment = Comment.new(user_id: user.id, topic_id: topic.id, comment: params[:comment][:comment])

        if comment.save
            redirect_to topic_path(topic.id), success: 'コメントを投稿しました'
        else
            redirect_to topic_path(topic.id), danger: 'コメント投稿に失敗しました'
        end
    end
end
