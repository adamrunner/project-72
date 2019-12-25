require 'rails_helper'

def convert_to_tasmota_timestamp(datetime)
  datetime.to_s.gsub(/-0[7,8]:00/, '')
end

RSpec.describe TasmotaAgent::Message::Energy, type: :service do
  let(:payload) {
    {"Name":"Fridge","Time":"2019-11-19T11:02:53","ENERGY":{"TotalStartTime":"2019-11-10T20:52:13","Total":15.457,"Yesterday":1.808,"Today":0.86,"Period":0,"Power":0,"ApparentPower":0,"ReactivePower":0,"Factor":0,"Voltage":123,"Current":0},"name":"Fridge"}.with_indifferent_access
  }

  describe '#map_payload' do
    let(:result)  { TasmotaAgent::Message::Energy.new(payload) }
    it "maps the :read_at field" do
      value    = payload["Time"]
      original = convert_to_tasmota_timestamp(result.attributes[:read_at])
      expect(value).to eq(original)

    end
    it "maps the :total_start_timestamp field" do
      value   = payload["ENERGY"]["TotalStartTime"]
      original = convert_to_tasmota_timestamp(result.attributes[:total_start_timestamp])
      expect(value).to eq(original)

    end
    it "maps the :total_kwh_since_start field" do
      value = payload["ENERGY"]["Total"]
      expect(value).to eq(result.attributes[:total_kwh_since_start])

    end
    it "maps the :yesterday_kwh field" do
      value = payload["ENERGY"]["Yesterday"]
      expect(value).to eq(result.attributes[:yesterday_kwh])

    end
    it "maps the :today_kwh field" do
      value = payload["ENERGY"]["Today"]
      expect(value).to eq(result.attributes[:today_kwh])

    end
    it "maps the :power field" do
      value = payload["ENERGY"]["Power"]
      expect(value).to eq(result.attributes[:power])

    end
    it "maps the :apparent_power field" do
      value = payload["ENERGY"]["ApparentPower"]
      expect(value).to eq(result.attributes[:apparent_power])

    end
    it "maps the :reactive_power field" do
      value = payload["ENERGY"]["ReactivePower"]
      expect(value).to eq(result.attributes[:reactive_power])

    end
    it "maps the :power_factor field" do
      value = payload["ENERGY"]["Factor"]
      expect(value).to eq(result.attributes[:power_factor])

    end
    it "maps the :voltage field" do
      value = payload["ENERGY"]["Voltage"]
      expect(value).to eq(result.attributes[:voltage])

    end
    it "maps the :current field" do
      value = payload["ENERGY"]["Current"]
      expect(value).to eq(result.attributes[:current])

    end

  end
end
