require 'services/agent'
namespace :agent do
  task :start do
    puts "Starting Background Agent..."
    sleep(10)
    @auth_api = Services::Agent::AuthApi.new
    @token    = @auth_api.token
    @client = MQTT::Client.connect('temp.adamrunner.com')
    @client.get('data') do |topic, payload|
      puts "#{DateTime.now.iso8601} - #{payload}"
      attributes = Services::Agent::MessageReceiver.parse(payload)
      Services::Agent::EntryApi.send(attributes, @token)
    end
    # agent authenticates with API upon start
    # agent listens to MQTT message queue
    # parses the message format "KEY:VALUE,KEY:VALUE"
    # builds an object with the keys and values
    # sends a POST request to the entries API
    # uses the object as the payload
    # if server returns 401
    # agent should attempt to relogin and get new key
  end
end