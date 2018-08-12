json.extract! sensor_entry, :id, :hostname, :battery, :voltage, :temp, :humidity, :heat_index, :created_at, :updated_at
json.url sensor_entry_url(sensor_entry, format: :json)
