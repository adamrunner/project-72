class Sensor
  include Mongoid::Document
  include Mongoid::Timestamps

  # embeds_one :latest_entry, class_name: Entry
  # embeds_one :max_temperature_entry, class_name: Entry
  # embeds_one :min_temperature_entry, class_name: Entry
  # embeds_one :average_temp_entry, class_name: Entry
  field :hostname,            type: String
  field :description,         type: String
  field :battery_threshold,   type: Percent, default: Percent.zero_percent
  field :current_battery_low, type: Boolean, default: false

  before_save :set_battery_state, if: -> { current_battery_changed? }

  has_many :entries

  default_scope -> { order(hostname: 1) }

  # field :entries_count, type: Integer
  # field :current_battery,    type: Percent
  # field :current_voltage,    type: Volt
  # field :current_temp,       type: Temperature
  # field :current_humidity,   type: Percent
  # field :current_heat_index, type: Temperature

  index(hostname: 1)
  index(updated_at: -1)

  private
  def set_battery_state
    self.current_battery_low = current_battery < battery_threshold
    true
  end
end