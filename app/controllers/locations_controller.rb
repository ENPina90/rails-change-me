class LocationsController < ApplicationController
  def index
    @locations = Location.all

    @markers = @locations.geocoded.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude
      }
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    @location.save
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :rating)
  end
end
