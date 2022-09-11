class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.home
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to @review.home
  end

  private
    def review_params
      params.require(:review).permit(:comment, :star, :home_id)
    end
end