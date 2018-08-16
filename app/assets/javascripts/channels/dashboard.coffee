App.dashboard = App.cable.subscriptions.create "DashboardChannel",
  connected: ->
    console.log('connected to channel')
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log('disconnected from channel')
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log(data)
    # Called when there's incoming data on the websocket for this channel