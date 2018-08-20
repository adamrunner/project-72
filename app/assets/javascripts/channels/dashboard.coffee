App.dashboard = App.cable.subscriptions.create "DashboardChannel",
  connected: ->
    console.log('connected to channel')
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log('disconnected from channel')
    # Called when the subscription has been terminated by the server

  received: (data) ->

    seriesData = chart.chartData.find (element) =>
      element.name == data.description

    seriesData.data.push([moment(data.current_updated_at).valueOf(), data.current_temp.value])

    window.sensorData[data._id] = data
    console.log(data)
    # Called when there's incoming data on the websocket for this channel