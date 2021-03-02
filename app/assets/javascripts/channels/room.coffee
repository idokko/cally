document.addEventListener 'turbolinks: load', ->
  if App.room
    App.cable.subscriptions.remove App.room
  App.room = App.cable.subscriptions.create {channel: "RoomChannel", room: $('#direct_messages').data('room_id')},
    # 通信が確立された時
    connected: ->
      # Called when the subscription is ready for use on the server
    # 通信が切断された時
    disconnected: ->
      # Called when the subscription has been terminated by the server
    # 値を受け取った時
    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      # 投稿を追加
      $('#direct_messages').append data['direct_message']
    # サーバーサイドのspeakアクションにdirect_messageパラメータを渡す
    speak: (direct_message) ->
      @perform 'speak', direct_message: direct_message
      
  $('#chat-input').on 'keypress', (event) ->
    # rreturnキーが押されたら
    if event.KeyCode is 13
      # speakメソッド, event.target.valueを引数にする
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()
