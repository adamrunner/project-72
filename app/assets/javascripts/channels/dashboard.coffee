App.dashboard = App.cable.subscriptions.create "dasboard_channel",
  connected: ->
    console.log('connected to channel')
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log('disconnected from channel')
    # Called when the subscription has been terminated by the server

  received: (data) ->
    window.data.sensors[data._id] = data
    console.log(data)
    # Called when there's incoming data on the websocket for this channel