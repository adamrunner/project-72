require 'services/tasmota_agent'
namespace :tasmota_agent do
  task start: :environment do
    puts "Starting Tasmota Background Agent..."
    sleep(10)
    @client = MQTT::Client.connect({
      host: "192.168.1.90",
      port: 1883,
      username: "HOMEBRDIGE_USER",
      password: "boarding",
    })
    # TODO: does this wild card work for listening to a wildcard topic?
    @client.get("tele/SONOFF_A00A3C/SENSOR") do |topic, payload|
      #topic =  tele/SONOFF_7FED46/SENSOR
      sensor_hostname = topic.match(/\/(.+)\//)[1]
      puts "#{sensor_hostname} - #{payload}"
      data = JSON.parse('{"Time":"2019-11-14T08:14:01","DS18B20":{"Temperature":21.5},"SI7021":{"Temperature":null,"Humidity":null},"BME280":{"Temperature":21.1,"Humidity":46.9,"Pressure":1014.4},"TempUnit":"C", "PressureUnit":"hPa"}')
      data.merge!(hostname: sensor_hostname)
      c = Mongoid.default_client
      c[:unmapped_entries].insert_one(data)
    end
  end
end
