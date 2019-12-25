class TemperatureF < Unit
  def initialize(value, unit = "ºF")
    @value = value.to_f
    @unit  = unit
  end

  def convert_to_c
    centigrade = ((@value - 32.0) * 5/9).round(2)
    TemperatureC.new(centigrade)
  end
end
