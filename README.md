### Project72 (just a cool name) 

Collects, persists and displays sensor data from a network of sensors. 

Contains a background daemon and a web application front end. The background daemon is a rake task that should be started with SystemD. 

The application does the following: 
Renders a simple interface using Vue.js to display current information about the sensors most recent data. 
Renders a temperature over time line chart, using Highcharts-Vue.
Renders a battery % over time line chart, using Highcharts-Vue. 
Listens for new updates about sensors to arrive via ActionCable; the dashboard page subscribes to the `dashboard-channel`, updates the underlying data when new information arrives via Websockets, causing Vue.js to re-render any changed information. 
The Websocket connection only provides state updates for the sensors, it does not update the chart data. 
Provides an API to write new sensor data to, currently unused. 


The agent does the following: 
Listens to the MQTT Topic of `data` for a key-value encoded payload. The payload will look something like this: 
`HOSTNAME:ESP_82544,TEMP:83.31,...`
After receiving a payload, the agent will parse it and subsequently create new entries within the database for both the Sensor (if not a currently known sensor) and whatever values were passed to the message queue. It will downcase the keys. 

Technology Stack: 
Mosquitto - MQTT Broker
Rails 5.2 - Application Framework 
Vue.js - Frontend Component JS Framework
ActionCable - Used for transmitting messages to the UI after they're received.
Puma - Application Server 
Nginx - Web Server
MongoDB - Persistence Layer / Database 

Deployment: 

Uses `capistrano` for deployment; currently requires actual pre-compilation (and commit) of the assets from the asset pipeline and webpack. Should script the following: 

```
env RAILS_ENV=production bin/rake assets:precompile
env RAILS_ENV=production bin/rake webpacker:compile
git add public
git commit -m "add changed and compiled assets" 
git push
bundle exec cap production deploy
```
