class RoomChannel < ApplicationCable::Channel
  # skip_before_action :require_login, only: [:speak, :subscribed]
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #app/assets/javascripts/channels/room.coffeeで定義した
  #speak関数によって、下記のspeakアクションが呼ばれる
  def speak(data)
    message = Message.new(
              content: data['content'],
              image_data_uri: data['data_uri']
              )
    message.save
  end
end
