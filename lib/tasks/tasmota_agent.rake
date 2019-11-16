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
    @client.get("#") do |topic, payload|
      if topic.match(/tele\/(.+)\/SENSOR/)
        sensor_hostname = topic.match(/\/(.+)\//)[1]
        puts "#{sensor_hostname} - #{payload}"
        data = JSON.parse(payload)
        data.merge!(hostname: sensor_hostname)
        c = Mongoid.default_client
        c[:unmapped_entries].insert_one(data)
      end
    end
  end
end
