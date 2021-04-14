class MessageForm
    include ActiveModel::Model

    # attr_accessorメソッド
    # クラス外部からインスタンス変数を参照、変更可能にする
    attr_accessor :content, :user_id, :room_id, :photos
    
    validates :content_or_photo, presence: true
    private
    def content_or_photo
       self.content.present? || MessageImage.photos.present? 
    end
    
    def save!
        # もし無効ならfalseを返す
       return false if invalid?
       message = Message.new(content: content, user_id: user_id, room_id: room_id)
       message.message_images.build(photos: photos).save!
       
       message.save! ? true : false
    end
end