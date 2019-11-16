namespace :tasmota_agent do
  task start: :environment do
    puts "Starting Tasmota Background Agent..."
    sleep(10)
    @client = MQTT::Client.connect({
      host: "adamrunner.com",
      port: 1883
    })
    # TODO: does this wild card work for listening to a wildcard topic?
    @client.get("#") do |topic, payload|
      puts "#{sensor_hostname} - #{payload}"
      if topic.match(/tele\/(.+)\/SENSOR/)
        sensor_hostname = topic.match(/\/(.+)\//)[1]

        data = JSON.parse(payload)
        data.merge!(hostname: sensor_hostname)
        c = Mongoid.default_client
        c[:unmapped_entries].insert_one(data)
      end
    end
  end
end
