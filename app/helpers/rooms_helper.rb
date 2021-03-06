module RoomsHelper
    # 最新メッセージのデータを取得して表示するメソッド
    def most_new_message_preview(room)
        #   最新メッセージのデータを取得する
        message = room.messages.order(created_at: :desc).limit(1)
        # 配列から取り出す
        message = message[0]
    end
    
    #相手のユーザー名を取得して表示するメソッド
    def opponent_user(room)
        # 中間テーブルから相手ユーザーのデータを取得
        entry = room.entries.where.not(user_id: current_user)
        # 相手ユーザーの名前を取得
        name = entry[0].user.name
        # 名前を表示
        # tag.p "#{name}", class: "dm_list_content_link_box_name"
    end
    
    # 長いメッセージは省略する
    def truncate_message(short)
      short = strip_tags(short).truncate(30) 
    end
    
    def unchecked_notifications
    #   @notifications =current_user.passive_notifications.where(checked: false) 
    end
end
