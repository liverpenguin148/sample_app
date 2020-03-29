class User < ApplicationRecord
  # remember_token属性に対応するアクセサーの作成
  # アクセサー：データを取り出すメソッド、代入するメソッドを定義してくれる
  attr_accessor :remember_token
  
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: {maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence:true, length: {minimum: 6}
  
  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      # MIN_COSTコストパラメータを最小にする
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    # ランダムなトークンを返す。
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  # ログイン時に、ランダムな記憶トークンを作成する。
  # その際、記憶トークンをハッシュ化した値を記憶ダイジェストに設定し、DBに記憶
  def remember
    # ランダムなトークンを設定する。
    self.remember_token = User.new_token
    # 記憶ダイジェストを更新(作成したトークンをハッシュ化)
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す。
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
