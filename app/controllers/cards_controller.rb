class CardsController < ApplicationController
    before_action :require_login
    require 'payjp'
    
    def new
    end
    
    def create
       Payjp.api_key = ENV['PAYJP_SECRET_KEY']
       unless params['payjp_token'].blank?
        #   生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
          customer = Payjp::Customer.create(
            email: current_user.email,
            card: params["payjp_token"],
            metadata: {user_id: current_user.id}
          )
        #   トークン化した情報をアプリのcardsテーブルに登録
          @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
          if @card.save
             redirect_to user_path(current_user.id)
          else
             redirect_to action: "new"
          end
       else
          redirect_to action: "new", danger: "登録できませんでした"
       end
    end
        
    def show
      card = Card.find_by(user_id: current_user.id)
      if card.blank?
          redirect_to action: "new" 
      else
          Pay.api_key = ENV["PAYJP_SECRET_KEY"]
          customer = Payjp::Customer.retrieve(card.customer_id)
          @default_card_imformation = customer.cards.retrieve(card.card_id)
      end
    end
    
        # PayjpとCardデータベースを削除
    def delete
       card = Card.find_by(user_id: current_user.id)
       unless card.blank?
          Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
          customer = Payjp::Customer.retrieve(card.customer_id)
          customer.delete
          card.delete
       end
       redirect_to action: "new"
    end
    
    # payjpとCardのデータベース作成
    # def pay
    #   Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    #   if params['payjp_token'].blank?
    #       redirect_to action: "new"
    #   else
    #       customer = Payjp::Customer.create(
    #         card: params['payjp_token']
    #       )
    #       @card = Card.new(
    #         user_id: current_user.id,
    #         customer_id: customer.id,
    #         card_id: customer.default_card
    #       )  
    #       if @card.save
    #         redirect_to action: "show"
    #       else
    #         redirect_to action: "pay" 
    #       end
    #   end
    # end
end
