class Temperature < Unit
  def initialize(value, unit = "ºF")
    @value = value.to_f
    @unit  = unit
  end
end