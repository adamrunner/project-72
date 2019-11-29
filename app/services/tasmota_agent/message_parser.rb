module Services
  module TasmotaAgent
    # Power message parser
    class MessageParser
      def self.perform(payload, sensor_hostname)
        # SONOFF_7FED46
        self.new(payload, sensor_hostname).perform
      end

      attr_accessor :message, :attributes
      def initialize(payload, sensor_hostname)
        @sensor_hostname = sensor_hostname
        @message = JSON.parse(payload)
        @attributes = {}
      end

      def perform
      end
    end
  end
end
