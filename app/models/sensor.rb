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
  field :battery_present,     type: Boolean, default: false

  validates_presence_of :hostname

  before_save :set_battery_state, if: -> { current_battery_changed? }

  after_save :broadcast_message, if: -> { current_updated_at_changed? }

  has_many :entries, order: {created_at: -1}

  default_scope -> { order(hostname: 1) }

  # field :entries_count, type: Integer
  # field :current_battery,    type: Percent
  # field :current_voltage,    type: Volt
  # field :current_temp,       type: Temperature
  # field :current_humidity,   type: Percent
  # field :current_heat_index, type: Temperature

  index({hostname: 1}, {unique: true})
  index(updated_at: -1)

  def todays_entries
    #TODO: this forces the time zone of the query to be my preferrred time zone, users should be able to configure this
    entries.where(created_at: {"$gt": Date.today.midnight.in_time_zone("America/Los_Angeles") }).order(created_at: 1)
  end

  private
  def set_battery_state
    self.current_battery_low = current_battery < battery_threshold
    true
  end

  def broadcast_message
    #TODO: Is this the correct place for this?
    #TODO: Make a service object to handle the transmission?
    #TODO: entries_count is off by 1 here due to callback ordering.
    #TODO: Broadcastable module?
    ActionCable.server.broadcast('dashboard_channel', self.as_json)
  end
end