class Amp < Unit
  def initialize(value, unit = "A")
    @value = value.to_f
    @unit  = unit
  end
end
