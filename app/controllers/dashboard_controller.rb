class DashboardController < ApplicationController
  def index
    @sensors = Sensor.all
  end
end