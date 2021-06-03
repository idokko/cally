class CardsController < ApplicationController
    before_action :require_login
    require 'payjp'
    
    def new
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      @card = Card.where(user_id: current_user.id)
    end
    
    def create
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      unless params['payjp_token'].blank?
        #   生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
          customer = Payjp::Customer.create(
            email: current_user.email,
            card: params['payjp_token'],
            metadata: {user_id: current_user.id}
          )
        #   トークン化した情報をアプリのcardsテーブルに登録
          @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
          
          if @card.save
            redirect_to user_path(current_user.id)
          else
            redirect_to action: "show"
          end
      else
        # binding.pry
          flash.now[:danger] = '登録出来ませんでした'
          render :new
      end
    end
        
    def show
      @card = Card.find_by(user_id: current_user.id)
      unless @card.blank?
        Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)
        
        # カードブランド表示の準備
        @card_brand = @customer_card.brand
        case @card_brand
          when "Visa"
            @card_src = "VISA.png"
          when "MasterCard"
            @card_src = "MasterCard.png"
          when "JCB"
            @card_src = "JCB.png"
          when "American Express"
            @card_src = "AmericanExpress.png"
          when "Diners Club"
            @card_src = "DinersClub.png"
          when "Discover"
            @card_src = "Discover.png"
        end
        # 有効期限の記述
        @exp_month = @customer_card.exp_month.to_s
        @exp_year = @customer_card.exp_year.to_s.slice(2, 3)
      end
    end
    
        # PayjpとCardデータベースを削除
    def destroy
       @card = Card.find_by(user_id: current_user.id)
       unless @card.blank?
          Payjp.api_key = ENV['PAYJP_SECRET_KEY']
          customer = Payjp::Customer.retrieve(@card.customer_id)
          customer.delete
          @card.delete
          unless @card.destroy
            redirect_to card_path(current_user.id), danger: "削除できませんでした"
          end
       end
    end
    
    # payjpとCardのデータベース作成
    def pay
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      if params['payjp_token'].blank?
          redirect_to action: "new"
      else
          customer = Payjp::Customer.create(
            card: params['payjp_token']
          )
          @card = Card.new(
            user_id: current_user.id,
            customer_id: customer.id,
            card_id: customer.default_card
          )  
          if @card.save
            redirect_to action: "show"
          else
            redirect_to action: "pay" 
          end
      end
    end
end
