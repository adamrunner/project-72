module Services
  module Agent
    class AuthApi
      attr_accessor :token
      def initialize(options = {})
        @endpoint = options[:endpoint] || "/auth"
        @email = options[:email] || "fakeuser@localhost"
        @password = options[:password] || "fakepassword"
        @baseurl  = options[:baseurl]  || "http://localhost:3000"
        @session  = Patron::Session.new({ :timeout => 10,
                                 :base_url => @base_url,
                                 :headers => {
                                   'User-Agent'   => 'Project72-Agent/1.0',
                                   'Content-Type' => 'application/json'} } )
        unless options[:silent]
          request
        end
      end

      def request
        puts "Logging in to API"
        response = @session.post(@endpoint, {email: @email, password: @password})
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