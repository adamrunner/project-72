class ConvertHumidityBatteryToPercentageObject < Mongoid::Migration
  def self.up
    entries = Entry.where("$or": [{humidity: {"$exists": true}}, {battery: {"$exists": true}}])
    entries.each do |entry|
      attributes = entry.attributes
      entry.humidity = Percent.new(attributes[:humidity]) if attributes[:humidity]
      entry.battery  = Percent.new(attributes[:battery])  if attributes[:battery]
      entry.save!
    end

  end

  def self.down
  end
end