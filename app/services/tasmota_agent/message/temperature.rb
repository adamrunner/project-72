module TasmotaAgent
  class Message
    class Temperature
      def initialize(message)
        @message    = message
        @sensors    = parse_sensors
        @attributes = []
        # {"Time":"2019-11-14T08:14:01","DS18 B20":{"Temperature":21.5},"SI7021":{"Temperature":null,"Humidity":null},"BME280":{"Temperature":21.1,"Humidity":46.9,"Pressure":1014.4},"TempUnit":"C", "PressureUnit":"hPa"}
        # map known sensors
        # capture units
        # create Entry for each sensor
        # All have same timestamp
        # Hostname - which identifies the sensor uniquely, will include the sensor identifier
        # e.g. SONOFF_A00AC3_BME280
        # This will follow the currenttly implemented model of "Sensors" only having a single purpose
        # "Hostname" field should be renamed to something more sensible
        # e.g. name


      end

      def map_payload
        @sensors.each do |sensor|
          hash = {}
          hash[:hostname]     = @message["hostname"]
          hash[:temperature]  = (@message[sensor]["Temperature"] * 9/5) + 32.0
          hash[:humidity]     = @message[sensor]["Humidity"]
          hash[:air_pressure] = @message[sensor]["Pressure"]
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
