class User < ApplicationRecord
    
    #ユーザID：１０文字以内・英数半角文字のみ・未入力NG
    valid_userid_regex = /\A[a-zA-Z0-9]+\z/
    validates :userid, presence: true, length: {maximum: 10}, format: {with: valid_userid_regex}

    #ニックネーム：１５文字以内・未入力NG
    validates :name, presence: true, length: {maximum: 15}

    #メールアドレス：「~ @ ~ . ~」の形式のみ許可・未入力許可
    valid_email_regex = /\w+@\w+.\w+/
    validates :email, format: {with: valid_email_regex}

    #パスワード：８~３２文字・アルファベット/数字の混合のみ許可
    valid_password_regex = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
    validates :password, length: {in: 8..32}, format: {with: valid_password_regex} 
    validates :password_confirmation, length: {in: 8..32}, format: {with: valid_password_regex} 

    has_secure_password
end
