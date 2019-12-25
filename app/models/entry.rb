class Entry
  include Mongoid::Document
  include Mongoid::Timestamps
  include Denormalizable

  field :hostname,              type: String
  field :battery,               type: Percent
  field :voltage,               type: Volt
  field :temp,                  type: Temperature
  field :humidity,              type: Percent
  field :pressure,              type: Pressure
  field :heat_index,            type: Temperature
  field :read_at,               type: DateTime
  field :total_start_timestamp, type: DateTime
  field :total_kwh_since_start, type: WattHour
  field :yesterday_kwh,         type: WattHour
  field :today_kwh,             type: WattHour
  field :power,                 type: Watt
  field :apparent_power,        type: VoltAmp
  field :reactive_power,        type: VoltAmp
  field :power_factor,          type: Float
  field :current_draw,          type: Amp

  validates :hostname, presence: true

  index(created_at: 1)
  index(hostname:   1)
  index(created_at: 1, hostname: 1)

  default_scope -> { order(created_at: 1) }

  before_validation :set_sensor_id, if: Proc.new {|e| e.sensor_id.blank? && e.hostname.present? }

  denormalize(
    :battery, :voltage, :temp, :humidity, :heat_index, :updated_at,
    to: :sensor,
    prefix: :current
  )

  def set_sensor_id
    self.sensor_id = Sensor.find_or_create_by(hostname: hostname).id
  end
end
