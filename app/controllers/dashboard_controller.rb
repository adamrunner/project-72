class DashboardController < ApplicationController
  def index
    @sensors = Sensor.all.map {|s| {s._id.to_s => s}}.inject(&:merge)
  end
end