class ConvertTempToTemperatureObject < Mongoid::Migration
  def self.up
    Entry.all.each do |entry|
      entry.update_attributes(temp: Temperature.new(entry.attributes[:temp]))
    end
  end

  def self.down
  end
end