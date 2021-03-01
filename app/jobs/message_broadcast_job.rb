class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    #room_channelに対して生成したデータをブロードキャストする
    #ブロードキャストされたデータはroom.coffeeの
    #received関数に渡される
    #ブロードキャスト:通信を発信するところ(controller等)が出す通信
    #パブリッシャ(通信を発信)->ブロードキャスト->ストリーム(通信を受け取ってサブスクライバーへ転送)
    ActionCalbe.server.broadcast('room_channel', data(message))
  end
  
  private
    def data(message) {
      message_html:
      ApplicationController.renderer.render(
        partial: 'messages/message',
        locals: {message: message}
      )
    }
    end
end
