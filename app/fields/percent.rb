class Percent < Unit
  ZERO_PERCENT = self.new(0.0)

  def self.zero_percent
    ZERO_PERCENT
  end

  def initialize(value, unit = "%")
    @value = value.to_f
    @unit  = unit
  end

  def <=>(percent_object)
    # TODO: attempt to cast non-percent objects into percents
    if self.value < percent_object.value
      -1
    elsif self.value > percent_object.value
      1
    else
      0
    end
  end
end