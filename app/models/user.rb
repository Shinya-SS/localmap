class User < ApplicationRecord
    
    #ユーザID：１０文字以内・英数半角文字のみ・DB上で一意・未入力NG
    valid_userid_regex = /\A[a-zA-Z0-9]+\z/
    validates :userid, presence: true, length: {maximum: 10}, uniqueness: true, format: {with: valid_userid_regex, message: "は英数半角文字で入力ください。"}

    #ニックネーム：１５文字以内・未入力NG
    validates :name, presence: true, length: {maximum: 15}

    #メールアドレス：「~ @ ~ . ~」の形式のみ許可・未入力許可
    valid_email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :email, format: {with: valid_email_regex, message: "は「xxx@xxx.xxx」の形式で入力ください。"}, allow_blank: true

    #パスワード：８~３２文字・アルファベット/数字の混合のみ許可
    valid_password_regex = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
    validates :password, length: {in: 8..32}, confirmation: true, format: {with: valid_password_regex, message: "は英数半角字の混在で入力ください。"}, on: :create 
    validates :password_confirmation, length: {in: 8..32}, format: {with: valid_password_regex, message: "は英数半角字の混在で入力ください。"}, on: :create

    has_secure_password

    has_many :topics
    has_many :favorites
    has_many :comments
    has_many :favorite_topics, through: :favorites, source: 'topic'

    mount_uploader :icon, ImageUploader
end
