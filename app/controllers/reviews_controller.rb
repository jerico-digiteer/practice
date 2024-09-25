class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = @product.reviews.includes(:user)
    @can_review = can_review?
  end

  def new
    @review = @product.reviews.build
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_reviews_path(@product), notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to product_reviews_path(@product), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to product_reviews_path(@product), notice: 'Review was successfully deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = @product.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def can_review?
    Order.where(user: current_user)
         .joins(:order_items)
         .where(order_items: { product_variant_id: @product.product_variants.pluck(:id) })
         .exists?
  end

  def hide
    @review = Review.find(params[:id])
    @review.update(hidden: true)
    redirect_to product_reviews_path(@product), notice: 'Review has been hidden.'
  end
end
