class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalizable

  field :hostname,   type: String
  field :battery,    type: Percent
  field :voltage,    type: Volt
  field :temp,       type: Temperature
  field :humidity,   type: Percent
  field :heat_index, type: Temperature

  validates :hostname, presence: true

  index(created_at: 1)
  index(hostname:   1)
  index(created_at: 1, hostname: 1)

  default_scope -> { order(created_at: -1) }

  before_validation :set_sensor_id, if: Proc.new {|e| e.sensor_id.blank? && e.hostname.present? }

  denormalize(
    :battery, :voltage, :temp, :humidity, :heat_index, :updated_at,
    to: :sensor,
    prefix: :current
  )

  def set_sensor_id
    self.sensor_id = Sensor.find_by(hostname: hostname).id
  end
end