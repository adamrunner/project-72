class Sensor
  include Mongoid::Document
  include Mongoid::Timestamps

  # embeds_one :latest_entry, class_name: Entry
  # embeds_one :max_temperature_entry, class_name: Entry
  # embeds_one :min_temperature_entry, class_name: Entry
  # embeds_one :average_temp_entry, class_name: Entry
  field :hostname,    type: String
  field :description, type: String

  has_many :entries

  default_scope -> { order(hostname: 1) }

  # field :entries_count, type: Integer
  # field :current_battery,    type: Float
  # field :current_voltage,    type: Float
  # field :current_temp,       type: Float
  # field :current_humidity,   type: Float
  # field :current_heat_index, type: Float

  index(hostname: 1)
  index(updated_at: -1)
end