class RoomsController < ApplicationController
    before_action :require_login
    
    def index
        # @rooms = current_user.rooms.joins(:messages).includes(:messages).order("messages.created_at DESC")
        @currentEntries = current_user.entries
        myRoomIds = []
        
        @currentEntries.each do |entry|
           myRoomIds << entry.room.id 
        end
        
        @anotherEntries = Entry.where(room_id: myRoomIds).where.not('user_id = ?', current_user.id)
    end
    
    def create
        @room = Room.create
        @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
        @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
        redirect_to "/rooms/#{@room.id}"
    end
    
    def show
        @room = Room.find(params[:id])
        if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
            @messages = @room.messages.includes(:user)
            @message = Message.new
            @entries = @room.entries.includes(:user)
        else
            
            redirect_back(fallback_location: works_path)
        end
        
       
    end
end
