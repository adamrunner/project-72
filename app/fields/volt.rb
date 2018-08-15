class Volt < Unit
  def initialize(value, unit = "V")
    @value = value
    @unit  = unit
  end
end