class Volt < Unit
  def initialize(value, unit = "V")
    @value = value.to_f
    @unit  = unit
  end
end