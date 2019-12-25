module TasmotaAgent
  class Message
    class Temperature
      attr_reader :attributes

      def initialize(message)
        @message    = message
        @sensors    = parse_sensors
        @attributes = []
        map_payload
      end

      def map_payload
        @sensors.each do |sensor|
          hash = {}
          hash[:read_at]      = DateTime.parse("#{@message["Time"]}-08:00")
          hash[:name]         = @message["name"]
          hash[:temperature]  = (@message[sensor]["Temperature"] * 9/5) + 32.0
          hash[:humidity]     = @message[sensor]["Humidity"]
          hash[:pressure] = @message[sensor]["Pressure"]
          @attributes.push(hash)
        end
      end

      private

      def parse_sensors
        @message.keys.find_all {|key| key.match(/BME280|SI7021|DS18B20/)}
      end
    end
  end
end
