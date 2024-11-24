class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :create_review]

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
  end

  def create_review
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: 'Review added successfully.'
    else
      redirect_to product_path(@product), alert: 'Failed to add review.'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
