json.array!(@sensors) do |sensor|
  json.type 'line'
  json.name sensor.description
  json.data sensor.todays_entries.map{|e| [(e.created_at.to_i * 1000), e.temp.to_f]}
end