json.array!(@sensors.where(battery_present: true)) do |sensor|
  json.type 'line'
  json.name sensor.description
  json.data sensor.entries.order(created_at: 1).where(created_at: {"$gt": 30.days.ago}).project({created_at:1, battery:1}).map{|e| [(e.created_at.to_i * 1000), e.battery.to_f]}
end 