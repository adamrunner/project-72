json.temperature_series_data do
  json.array!(@sensors) do |sensor|
    json.type 'line'
    json.name sensor.description
    json.data sensor.todays_entries.map{|e| [(e.created_at.to_i * 1000), e.temp.to_f]}
  end
end

json.battery_series_data do
  json.array!(@sensors.where(battery_present: true)) do |sensor|
    json.type 'line'
    json.name sensor.description
    json.data sensor.todays_entries.map{|e| [(e.created_at.to_i * 1000), e.battery.to_f]}
  end
end