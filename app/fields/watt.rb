class Watt < Unit
  def initialize(value, unit = "w")
    @value = value.to_f
    @unit  = unit
  end
end
