class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalizable

  field :hostname,   type: String
  field :battery,    type: Float
  field :voltage,    type: Float
  field :temp,       type: Float
  field :humidity,   type: Float
  field :heat_index, type: Float

  index(created_at: 1)
  index(hostname:   1)
  index(created_at: 1, hostname: 1)

  default_scope -> { order(created_at: -1) }
  before_validation :set_sensor_id, if: Proc.new {|e| e.sensor_id.blank? && e.hostname.present? }

  denormalize(
    :battery, :voltage, :temp, :humidity, :heat_index,
    to: :sensor,
    prefix: :current
  )

  def set_sensor_id
    self.sensor_id = Sensor.find_by(hostname: hostname).id
  end
end