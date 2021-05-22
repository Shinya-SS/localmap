class Topic < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :station
      t.string :picture_1
      t.string :picture_2
      t.string :picture_3
      t.string :picture_4
      t.string :picture_5

      t.timestamps 
    end
  end
end
