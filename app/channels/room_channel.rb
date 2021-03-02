class RoomChannel < ApplicationCable::Channel
  # 接続された時
  def subscribed
    stream_from "room_channel_#{params['room']}"
  end

  # 切断された時
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    DirectMessage.create! content: data['direct_message'], user_id: current_user.id, room_id: params['room']
  end
end
