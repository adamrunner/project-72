class TemperatureF < Unit
  def initialize(value, unit = "ºF")
    @value = value.to_f
    @unit  = unit
  end

  def convert_to_c
    TemperatureC.new((@value − 32) * 5/9)
  end
end
