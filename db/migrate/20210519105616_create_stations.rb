class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations, id: false, options: 'ENGINE=InnoDB COLLATE=utf8_general_ci' do |t|
      t.integer :station_id, null: false, unique: true
      t.integer :line_id
      t.string :name
      t.string :address
      t.decimal :lat, :precision => 9, :scale => 6, null: true
      t.decimal :lng, :precision => 9, :scale => 6, null: true

      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at
    end
  end
end
