module Services
  module Agent
    class AuthApi
      attr_accessor :token
      def initialize(options = {})
        @endpoint = options[:endpoint] || "/auth"
        @username = options[:user]     || "fakeuser@localhost"
        @password = options[:password] || "fakepassword"
        @session  = Patron::Session.new({ :timeout => 10,
                                 :base_url => 'http://localhost:3000',
                                 :headers => {
                                   'User-Agent'   => 'Project72-Agent/1.0',
                                   'Content-Type' => 'application/json'} } )
        unless options[:silent]
          request
        end
      end

      def request
        puts "Logging in to API"
        response = @session.post(@endpoint, {user: @username, password: @password})
        if response.status == 200
          @token = JSON.parse(response.body)["token"]
        else
          raise AuthApi::Error, "Server returned status of #{response.status}"
        end
      end
    end
    class AuthApi::Error < StandardError; end
  end
end