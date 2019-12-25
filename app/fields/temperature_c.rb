class TemperatureC < Unit
  def initialize(value, unit = "ºC")
    @value = value.to_f
    @unit  = unit
  end

  def convert_to_f
    fahrenheit = ((@value * 9/5) + 32).round(2)
    TemperatureF.new(fahrenheit)
  end
end
