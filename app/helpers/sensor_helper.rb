module SensorHelper
  def field_names(sensor)
    sensor.fields.keys.select {|k| k =~ /^current/ }
  end
end