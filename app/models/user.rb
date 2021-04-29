class User < ApplicationRecord
  authenticates_with_sorcery!
  
# def  has_unread_messages
#   #current_userのメッセージがある場合
#   unless self.rooms.room_ids.messages
# end  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])[a-z,A-Z,\d]{8,20}\z/
  
# 　allow_blankはエラーメッセージ用
  validates :name, 
            presence: true, length: {in: 1..15, allow_blank: true}
  validates :email,
            uniqueness: true, presence: true, format: {with: VALID_EMAIL_REGEX, allow_blank: true}
  validates :password, :password_confirmation, 
            presence: true, on: :create
  validates :password, :password_confirmation, 
            presence: true, on: :update, allow_blank: true, 
            format: {with: VALID_PASSWORD_REGEX, allow_blank: true}
  validates :password, confirmation: true
  validates :artist, presence: true
  validates :prefectures, presence: true
  validates :profile, length: {maximum: 200}, allow_blank: true
  validates :reset_password_token, allow_nil: true, uniqueness: true
  
  has_many :works, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  enum artist: {yes: 1, no: 2}
  enum prefectures: {
    "---": 0,
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20, 岐阜県: 21, 静岡県: 22, 愛知県: 23,
    三重県: 24, 滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35, 
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46, 沖縄県: 47
  }
end