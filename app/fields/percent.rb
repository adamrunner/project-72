class Percent < Unit
  def initialize(value, unit = "%")
    @value = value
    @unit  = unit
  end
end