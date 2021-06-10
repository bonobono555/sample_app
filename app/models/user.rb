class User < ApplicationRecord
    # emailをDB保存前に全て小文字に変更する
    before_save { self.email = email.downcase }
    
    # name 
    validates :name, presence: true, length: { maximum: 50 }
    # validatesはメソッド、下記を書き換えたのが上記
    # validates(:name, presence: true)

    # email正規表現
    VALID_EMAIL_REGEX = VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    # password
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

end
