class Unit
  include Comparable
  attr :value
  attr_reader :unit, :value

  def initialize(value, unit = nil)
    @value = value.to_f
    @unit = unit
  end

  def inspect
    "#<#{self.class.name}:#{"0x00%x" % (object_id << 1)} #{to_s}>"
  end

  def to_s
    "#{@value}#{@unit}"
  end

  def to_f
    @value.to_f
  end

  def mongoize
    {
      value: @value,
      unit:  @unit
    }.with_indifferent_access
  end

  class << self
    def demongoize(object)
      if object.is_a?(Hash) and (object = object.with_indifferent_access).has_key?(:value)
        self.new(object[:value], object[:unit])
      else
        case object
        when String, BigDecimal, Numeric, Float
          self.new(object)
        else
          object
        end
      end
    end

    def mongoize(object)
      case object
      when self then object.mongoize
      else
        demongoize(object).mongoize
      end
    end

    def evolve(object)
      case object
      when self then object.mongoize
      else
        demongoize(object).mongoize
      end
    end

  end
end