class MessagesController < ApplicationController
    before_action :require_login
    
    def create
        @entry_room = Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id])
        if @entry_room.present?
            # binding.pry
            @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id, images: []).merge(:user_id => current_user.id))
            # Notificationの準備
            @room = @message.room
            @anotherRoomMember = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
            @theId = @anotherRoomMember.find_by(room_id: @room.id)
            
            # ログインユーザーがメッセージを送ったとき
            if @message.content.present? && @message.images.attached?
                @message_count = @message.images.size + 1
            elsif @message.images.attached?
                @message_count = @message.images.size
            else
                @message_count = 1
            end
            
            unless @message.content.blank? && @message.images.blank?
            @message_count.times do
                    notification = current_user.active_notifications.new(
                        room_id: @room.id,
                        message_id: @message.id,
                        visited_id: @theId.user_id,
                        visitor_id: current_user.id,
                        checked: false,
                        action: 'dm',
                        content_checked: false,
                    )
                    # 自分のメッセージの場合は、通知済みとする
                    if notification.visitor_id == notification.visited_id
                      notification.checked = true 
                    end
                    # @message.contentの中身があるか確認
                    unless @message.content.blank? || @message.images.blank?
                        notification.content_checked = true
                    end
                    notification.save!
                end
            end
        redirect_to "/rooms/#{@message.room_id}"
        else
            flash.now[:danger] = 'メッセージを送信できませんでした'
            render :new
                # redirect_back(fallback_location: works_path)

        end
    end
    #  @room = @message.room_id
end
