class RoomChannel < ApplicationCable::Channel
  # 接続された時
  def subscribed
    stream_from "room_channel_#{params['room']}"
    # stream_from "room_channel"
    
  end

  # 切断された時
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # ActionCable.server.broadcast 'room_channel', direct_message: data['directmessage']
    DirectMessage.create! content: data['direct_message'], user_id: current_user.id, room_id: params['room']
    # ActionCable.sever.broadcast('room_channel', direct_message: render_direct_message(direct_message))
  end
end


# private

# def render_direst_message(direct_message)
#   ActionController.render(
#     partial: 'direct_messages/direct_message',
#     locals: {direct_message: direct_message}
#     )
# end