class RenameSensorHostnameToName < Mongoid::Migration
  def self.up
    Sensor.rename(hostname: :name)
  end

  def self.down
    Sensor.rename(name: :hostname)
  end
end
