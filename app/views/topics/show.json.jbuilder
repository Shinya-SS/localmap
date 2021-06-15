json.extract! @topic, :id, :user_id, :title, :description, :station, :picture_1, :picture_2, :picture_3, :created_at, :updated_at, :latitude, :longitude
json.url topic_url(@topic, format: :json)
