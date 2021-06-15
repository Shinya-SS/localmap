class MypagesController < ApplicationController
  def index
    id = current_user.id
    query = "select TOPICS.* from topics inner join FAVORITES on TOPICS.id = FAVORITES.topic_id
      where FAVORITES.user_id = #{id} order by updated_at desc LIMIT 3"
    @topics = Topic.find_by_sql([query])

    # いいね数上位５件を取得
    query_ranking = "select TOPICS.*,ranking.* from topics
    inner join (select topic_id ,count(1) as rank from favorites group by topic_id) as ranking
    on TOPICS.id = ranking.topic_id
    order by ranking.rank desc,TOPICS.updated_at desc LIMIT 5"
    @topics_rank = Topic.find_by_sql([query_ranking])
    gon.topics_rank = @topics_rank
  end
end

