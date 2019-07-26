require 'services/agent'
namespace :agent do
  task start: :environment do
    puts "Starting Background Agent..."
    sleep(10)
    @client = MQTT::Client.connect(ENV['AGENT_MQTT_HOST'])
    @client.get('data') do |topic, payload|
      puts "#{DateTime.now.iso8601} - #{payload}"
      attributes = Services::Agent::MessageReceiver.parse(payload)
      entry      = Entry.create(attributes)
      
      ActionCable.server.broadcast('dashboard_channel', entry.sensor.as_json)
    end
  end
end