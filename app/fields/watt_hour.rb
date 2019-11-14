class WattHour < Unit
  def initialize(value, unit = "wh")
    @value = value.to_f
    @unit  = unit
  end
end
