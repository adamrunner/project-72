require 'rails_helper'

def convert_to_tasmota_timestamp(datetime)
  datetime.to_s.gsub(/-0[7,8]:00/, '')
end

def convert_temp_f_to_temp_c(temp_f)
  ((temp_f - 32.0) * 5/9).round(2)
end

def convert_temp_c_to_temp_f(temp_c)
  ((temp_c * 9/5) + 32).round(2)
end

RSpec.describe TasmotaAgent::Message::Temperature, type: :service do
  let(:payload_am2301) {
    {"Time":"2019-12-25T01:20:52","AM2301":{"Temperature":7,"Humidity":69.9},"TempUnit":"C","name":"Outdoor_Sensor"}
  }
  let(:payload_bme280) {
    {"Time":"2019-11-19T11:01:27","BME280":{"Temperature":25.4,"Humidity":37,"Pressure":1007.5,"SeaPressure":1015.2},"PressureUnit":"hPa","TempUnit":"C","name":"Kitchen_LEDs"}.with_indifferent_access
  }
  let(:payload_si7021) {
    {"Time":"2019-11-19T11:03:08","SI7021":{"Temperature":19.9,"Humidity":57.2},"TempUnit":"C","name":"Front_Door_Switch"}
  }
  let(:payload_ds18b20) {
    {"Time":"2019-11-19T11:05:41","DS18B20":{"Temperature":21.1},"TempUnit":"C","name":"Garage_Heater"}
  }
  let(:payload_multi_ds18b20) {
    {"Time":"2019-11-19T20:06:27","TempUnit":"C","name":"Plant_Lights","DS18B20_1":{"Id":"0315A11811FF","Temperature":22.6},"DS18B20_2":{"Id":"031689EBFBFF","Temperature":21.2}}
  }

  describe '#map_payload' do
    let(:result)  { TasmotaAgent::Message::Temperature.new(payload_bme280) }
    it "maps the :read_at field" do
      value    = payload_bme280["Time"]
      original = convert_to_tasmota_timestamp(result.attributes[0][:read_at])
      expect(value).to eq(original)
    end
    context "when the sensor is a bme280, with temp, pressure and humidity" do
      let(:result)  { TasmotaAgent::Message::Temperature.new(payload_bme280) }
      it "maps the temperature" do
        value    = result.attributes[0][:temperature]
        original = convert_temp_c_to_temp_f(payload_bme280["BME280"]["Temperature"])
        expect(value).to eq(original)
      end
      it "maps the humidity" do
        value    = result.attributes[0][:humidity]
        original = payload_bme280["BME280"]["Humidity"]
        expect(value).to eq(original)
      end
      it "maps the pressure" do
        value    = result.attributes[0][:pressure]
        original = payload_bme280["BME280"]["Pressure"]
        expect(value).to eq(original)
      end
    end
    context "when the sensor is a AM2301, with temp and humidity" do
      let(:result)  { TasmotaAgent::Message::Temperature.new(payload_am2301) }
      it "maps the temperature" do
        value    = result.attributes[0][:temperature]
        original = convert_temp_c_to_temp_f(payload_am2301["AM2301"]["Temperature"])
        expect(value).to eq(original)
      end
      it "maps the humidity" do
        value    = result.attributes[0][:humidity]
        original = payload_am2301["AM2301"]["Humidity"]
        expect(value).to eq(original)
      end
    end

    context "when the sensor is a si7021, with temp and humidity" do
      let(:result)  { TasmotaAgent::Message::Temperature.new(payload_si7021) }
      it "maps the temperature" do
        value    = result.attributes[0][:temperature]
        original = convert_temp_c_to_temp_f(payload_si7021["SI7021"]["Temperature"])
        expect(value).to eq(original)
      end
      it "maps the humidity" do
        value    = result.attributes[0][:humidity]
        original = payload_si7021["SI7021"]["Humidity"]
        expect(value).to eq(original)
      end
    end
    context "when the sensor is a multiple ds18b20, with temp" do
      it "maps the temperature" do

      end
    end
  end

end
