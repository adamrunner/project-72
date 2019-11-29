class Temperature
  def self.new(value, unit)
    if unit.blank?
    elsif unit.match(/F/)
      TemperatureF.new(value, unit)
    elsif unit.match(/C/)
      TemperatureC.new(value, unit)
    end
  end
end
