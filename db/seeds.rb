# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# 駅CSVファイルパス
STATION_PATH = "db/data/stations_tokyo.csv"

 
# 駅カラム指定定数
STATION_CSVROW_STATION_ID = 0
STATION_CSVROW_NAME = 2
STATION_CSVROW_LNG = 9
STATION_CSVROW_LAT = 10
 
# 駅CSVを読み込みテーブルに保存
CSV.foreach(STATION_PATH) do |row|
    station_id = row[STATION_CSVROW_STATION_ID]
    name = row[STATION_CSVROW_NAME] + "駅"
    lng = row[STATION_CSVROW_LNG]
    lat = row[STATION_CSVROW_LAT]
 
    Station.find_or_create_by(
        :station_id => station_id,
        :name => name,
        :lat => lat,
        :lng => lng
    )
end



# 初回データ設定の時のみ使用
 User.create do |u|
     u.id = 0
     u.userid = 999
     u.name = 'ゲスト'
     u.email = 'dummy@dummy.com'
     u.station = '東京駅'
     u.password = 'dummy999'
     u.password_confirmation = 'dummy999'
 end



