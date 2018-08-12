class Entry
  include Mongoid::Document
  include Mongoid::Timestamps

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

  # denormalize(*fields, options)

  # denormalize(
  #   :battery, :voltage, :temp, :humidity, :heat_index,
  #   to: :sensor,
  #   prefix: :current
  # )

end