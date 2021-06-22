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
            @price = Cost.new
            @messages = @room.messages.includes(:user)
            @message = Message.new
            @entries = @room.entries.includes(:user)
        else
            if notification.checked == false
                notification.update_attributes(checked: true)
            end
            redirect_back(fallback_location: rooms_path)
        end
    end
        
    def buy
        @user = current_user
        @room = Room.find(params[:id])
        # binding.pry
        @another_user = @room.users.where.not(id: current_user.id).to_a[0]
        @price = Cost.where(:user_id => @user.id, :room_id => @room.id).last.price
        if @user.card.present?
            Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
            @card = Card.find_by(user_id: @user.id)
            customer = Payjp::Customer.retrieve(@card.customer_id)
            @customer_card = customer.cards.retrieve(@card.card_id)
            @card_brand = @customer_card.brand
            case @card_brand
                when "Visa"
                    @card_src = "cards/VISA.png"
                when "MasterCard"
                    @card_src = "cards/MasterCard.png"
                when "JCB"
                    @card_src = "cards/JCB.png"
                when "American Express"
                    @card_src = "cards/AmericavExpress.png"
                when "Diners Club"
                    @card_src = "cards/DinersClub.png"
                when "Discover"
                    @card_src = "cards/Discover.png"
            end
            # 有効期限
            @exp_month = @customer_card.exp_month.to_s
            @exp_year = @customer_card.exp_year.to_s.slice(2, 3)
        end
    end
        
    def pay
        @room = Room.find(params[:id])
        @another_user = @room.users.where.not(user_id: current_user.id)
        @price = Cost.where(:user_id => current_user.id, :room_id => @room.id).last.price
        if current_user.card.present?
           @card = Card.find_by(user_id: current_user.id)
           Payjp.api_key = ENV['PAYJP_SECRET_KEY']
           charge = Payjp::Charge.create(
                amount: @price,
                customer: Payjp::Customer.retrieve(@card.customer_id),
                currency: 'jpy'
           )
        else
            # クレジットカードの登録がない場合は、Pay.jpのシステムを利用
            Payjp.api_key = ENV['PAYJP_SECRET_KEY']
            Payjp::Charge.create(
                amount: @price,
                card: params['payjp-token'],
                currency: 'jpy'
            )
        end
    end
    
    private
    def cost_params
        params.require(:cost).permit(:price)
    end
end
