class MypagesController < ApplicationController

  def index
    # 自分がいいねした投稿上位３件
    id = current_user.id
    query = "select TOPICS.* from topics inner join FAVORITES on TOPICS.id = FAVORITES.topic_id
      where FAVORITES.user_id = #{id} order by updated_at desc LIMIT 3"
    @topics = Topic.find_by_sql([query])

    # いいね数上位3件を取得
    query_ranking = "select TOPICS.*,ranking.* from topics
    inner join (select topic_id ,count(1) as rank from favorites group by topic_id) as ranking
    on TOPICS.id = ranking.topic_id
    order by ranking.rank desc,TOPICS.updated_at desc LIMIT 3"
    @topics_rank = Topic.find_by_sql([query_ranking])
    gon.topics_rank = @topics_rank

    # 自分の投稿したもの上位3件
    @my_topics = current_user.topics.order(updated_at: :desc).limit(3)

    # 前投稿で作成日が最新のもの上位４件
    @new_topics = Topic.all.order(created_at: :desc).limit(4)
    # オススメ投稿の２トピックごとに"col-lg-6"クラスを入れるカウント
    @new_cnt = 0

  end
end



