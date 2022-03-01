class ReviewsController < ApplicationController
  def new
    @location = Location.find(params[:location_id])
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(params[:review])
  end

  def create
    @review = Review.new(review_params)
    @location = Location.find(params[:location_id])
    @review.user_id = current_user.id
    @review.location = @location
    @review.save
    redirect_to location_path(@location)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
