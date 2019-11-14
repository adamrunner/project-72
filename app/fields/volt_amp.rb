class VoltAmp < Unit
  def initialize(value, unit = "VA")
    @value = value.to_f
    @unit  = unit
  end
end
