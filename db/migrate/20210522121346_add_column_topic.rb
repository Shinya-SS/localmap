class AddColumnTopic < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :latitude, :float
    add_column :topics, :longitude, :float
  end
end
