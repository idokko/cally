class RoomsController < ApplicationController
    before_action :require_login
    require 'payjp'
    
    def index
        @rooms = current_user.rooms.joins(:messages).includes(:messages).order("messages.created_at DESC")
    end
        
    
    def create
        @room = Room.create
        @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
        @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
        redirect_to "/rooms/#{@room.id}"
    end
    
    def show
        current_user.passive_notifications.where(action: 'dm', checked: false, room_id: params[:id]).each do |notification|
            notification.update_attributes(checked: true)
        end        
        @room = Room.find(params[:id])
        if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
            @messages = @room.messages.includes(:user)
            @message = Message.new
            @entries = @room.entries.includes(:user)
        else
            if notification.checked == false
                notification.update_attributes(checked: true)
            end
            redirect_back(fallback_location: rooms_path)
        end
        
        def pay
            Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
             charge = Payjp::Charge.create(
             :amount => params[:amount],
             :card => params['payjp-token'],
             :currency => 'jpy'
            )    
        end
    end
end
