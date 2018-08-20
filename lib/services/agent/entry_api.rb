module Services
  module Agent
    class EntryApi
      attr_accessor :token
      def initialize(options = {})
        @endpoint   = options[:endpoint] || "/entries"
        @token      = options[:token]
        @attributes = options[:attributes]
        @session    = Patron::Session.new({ :timeout => 10,
                                 :base_url => 'http://localhost:3000',
                                 :headers => {
                                   'User-Agent'    => 'Project72-Agent/1.0',
                                   'Content-Type'  => 'application/json',
                                   'Authorization' => "Bearer #{@token}"} } )
        send
      end

      def self.send(attributes, token)
        new(token: token, attributes: attributes)
      end

      def send
        response = @session.post(@endpoint, {entry: @attributes}.to_json)
        if response.status == 200
          puts ""
        else
          raise EntryApi::Error, "Server returned status of #{response.status}"
        end
      end
    end
    class EntryApi::Error < StandardError; end
  end
end