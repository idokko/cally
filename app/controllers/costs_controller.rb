class CostsController < ApplicationController
    before_action :require_login
    
    def create
        @entry_room = Entry.where(:user_id => current_user.id, :room_id => params[:cost][:room_id])
        if @entry_room.present?
            @price = Cost.new(cost_params)
            if @price.save
                redirect_to  "/rooms/#{@price.room_id}/buy"
            else
                flash.now[:danger] = "入力値が正しくありません"
                render :new
            end
        end
    end
    
    private
    def cost_params
        params.require(:cost).permit(:user_id, :room_id, :price).merge(:user_id => current_user.id)
    end
end
