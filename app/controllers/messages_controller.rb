class MessagesController < ApplicationController
    before_action :require_login
    
    def create
        # binding.pry
        if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
            if  @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
                
               
                @anotherEntry = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
                @roomId = @anotherEntry.find_by(room_id: @room.id)
                notification = current_user.active_notifications.new(
                    room_id: @room.id,
                    message_id: @message.id,
                    visited_id: @roomId.user_id,
                    visitor_id: current_user.id,
                    action: 'dm'
                )
                # 自分のメッセージの場合は、通知済みとする
                if notification.visitor_id == notification.visited_id
                   notification.checked = true 
                end
                notification.save!
                redirect_to "/rooms/#{@message.room_id}"
            else
                redirect_back(fallback_location: works_path)
            end
        end
    end
     @room = @message.room_id
end
