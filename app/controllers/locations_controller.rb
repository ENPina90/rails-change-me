class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy, :calc_rating]

  def index
    if params[:query].present?
      @locations = Location.where("category ILIKE?", "%#{params[:query]}%")
    else
      @locations = Location.all
    end

    @markers = @locations.geocoded.map do |location|
      {
        latitude: location.latitude,
        longitude: location.longitude,
        info_window: render_to_string(partial: "info_window", locals: { location: location })
      }
    end
  end

  def show
    @location = Location.find(params[:id])
    @review = Review.new
    @user_review = @location.reviews.find_by user_id: current_user if @location.reviews.find_by user_id: current_user
    @markers = [{
      latitude: @location.latitude,
      longitude: @location.longitude
    }]
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.address = @location.address.split(/,\s(.*)/).last if @location.address.count(',') > 3
    if @location.save
      redirect_to location_path(@location)
    else
      render :new
    end
  end

  private

  def calc_rating
    @location.reviews.average(:rating)
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :address, :rating, :category)
  end
end
