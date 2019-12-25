class Pressure < Unit
  def initialize(value, unit = "hPa")
    @value = value.to_f
    @unit  = unit
  end
end
