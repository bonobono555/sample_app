class User < ApplicationRecord
    attr_accessor :remember_token
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
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # 渡された文字列のハッシュ値を返す
    def self.digest(string)
    # def User.digest(string) 上記と同じ意味　User.メソッドをself.メソッドに書き換えられる。selfはUser「クラス」を指す
    
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def self.new_token
    # def User.new_token 上記と同じ意味　User.メソッドをself.メソッドに書き換えられる。selfはUser「クラス」を指す

        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end  


    # rememberメソッド、digestメソッドは以下のような書き方もできる。selfはUser「クラス」を指す
    # class << self
    #     # 渡された文字列のハッシュ値を返す
    #     def digest(string)
    #       cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    #                                                     BCrypt::Engine.cost
    #       BCrypt::Password.create(string, cost: cost)
    #     end
    
    #     # ランダムなトークンを返す
    #     def new_token
    #       SecureRandom.urlsafe_base64
    #     end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end    
    
    # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end    


end
