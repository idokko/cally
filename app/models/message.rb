class Message < ApplicationRecord
    # validates :user_id, presence: true
    validates :content_or_image, presence: true
    
    private
        def content_or_image
          content.present? || image.present? 
        end
        
    # belongs_to :user
    
    # CarrierWave用の設定
    mount_uploader :image, ImageUploader
    
    after_create_commit {MessageBroadcastJob.perform_later self}
    
    # チャットのメッセージを上から最新順に表示するため
    # デフォルトで作成日の降順でデータを取得する設定
    default_scope {order(created_at: :desc)}
end
