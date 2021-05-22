class Topic < ApplicationRecord
    validates :user_id, presence: true
    validates :title, presence: true
    validates :station, presence: true

    belongs_to :user
    
    mount_uploader :picture_1, ImageUploader

end
