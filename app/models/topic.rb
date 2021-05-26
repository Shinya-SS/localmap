class Topic < ApplicationRecord
    validates :user_id, presence: true
    validates :title, presence: true
    validates :station, presence: true
    validates :latitude, presence: true
    validates :longitude, presence: true

    belongs_to :user
    has_many :favorites
    
    mount_uploader :picture_1, ImageUploader

    #最寄駅検索Searchメソッド
    def self.search(search)
        return Topic.all unless search
        Topic.where(['station LIKE ?', "%#{search}%"])
    end

    #いいねされているかチェックメソッド
    def already_favorite?(user)
      self.favorites.where(user_id: user.id).exists?
    end
end
