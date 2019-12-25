module TasmotaAgent
  class Message
    class Energy
      attr_reader :attributes

      def initialize(message)
        @message     = message
        @attributes  = {}
        map_payload
      end

      def map_payload
        @attributes[:name]                  = @message["Name"]
        @attributes[:read_at]               = DateTime.parse("#{@message["Time"]}-08:00")
        @attributes[:total_start_timestamp] = DateTime.parse("#{@message["ENERGY"]["TotalStartTime"]}-08:00")
        @attributes[:total_kwh_since_start] = @message["ENERGY"]["Total"] # Kilo Watt Hours float
        @attributes[:yesterday_kwh]         = @message["ENERGY"]["Yesterday"] # Kilo Watt Hours float
        @attributes[:today_kwh]             = @message["ENERGY"]["Today"] # Kilo Watt Hours float
        @attributes[:power]                 = @message["ENERGY"]["Power"] # Watts integer
        @attributes[:apparent_power]        = @message["ENERGY"]["ApparentPower"] # VoltAmps integer
        @attributes[:reactive_power]        = @message["ENERGY"]["ReactivePower"] # rVA (Reactive Volt Amps?) integer
        @attributes[:power_factor]          = @message["ENERGY"]["Factor"] # float
        @attributes[:voltage]               = @message["ENERGY"]["Voltage"] # Volts integer
        @attributes[:current]               = @message["ENERGY"]["Current"] # Amps, float
      end
    end
  end
end
