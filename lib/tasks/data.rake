namespace :data do
  desc "Imports data from the old MongoDB collection"
  task import: :environment do
    import_data
    convert_data
  end

  def import_data
    `mongoexport -d sensor_data -c entries | mongoimport -d project72_production -c entries --drop`
  end

  def convert_data
    entries = Entry.all
    total   = entries.all.count
    entries.each_with_index do |entry, i|
      printf("\rMigrating Entries: %d/%d", i+1, total)
      attributes = entry.attributes
      entry.humidity   = Percent.new(attributes[:humidity]) if attributes[:humidity]
      entry.battery    = Percent.new(attributes[:battery])  if attributes[:battery]
      entry.temp       = Temperature.new(entry.attributes[:temp]) if attributes[:temp]
      entry.heat_index = Temperature.new(entry.attributes[:heat_index]) if attributes[:heat_index]
      entry.save!
    end
  end

end