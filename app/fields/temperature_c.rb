class TemperatureC < Unit
  def initialize(value, unit = "ºC")
    @value = value.to_f
    @unit  = unit
  end

  def convert_to_f
    TemperatureF.new((@value * 9/5) + 32)
  end
end
