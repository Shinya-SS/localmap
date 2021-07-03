class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.integer :station_id
      t.integer :line_id
      t.string :name
      t.string :address
      t.decimal :lat
      t.decimal :lng

      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
    end
  end
end
