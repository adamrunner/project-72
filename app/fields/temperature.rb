class Temperature < Unit
  def initialize(value, unit = "ºF")
    @value = value
    @unit  = unit
  end
end