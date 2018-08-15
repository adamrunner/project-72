class ConvertHeatIndexToTemperatureObject < Mongoid::Migration
  def self.up
    entries = Entry.where(heat_index: {"$exists": true})
    entries.each do |entry|
      entry.heat_index = Temperature.new(entry.attributes[:heat_index])
      entry.save!
    end
  end

  def self.down
  end
end