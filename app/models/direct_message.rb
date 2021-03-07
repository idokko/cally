class DirectMessage < ApplicationRecord
    validates :content, presence: true
    
    belongs_to :user, optional: true
    belongs_to :room, optional: true
    # ブロードキャスト
    after_create_commit {DirectMessageBroadcastJob.perform_later self}
end
