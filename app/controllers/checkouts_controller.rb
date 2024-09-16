class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_user.cart_items.includes(:product_variant)
  end

  def create
    @cart_items = current_user.cart_items.includes(:product_variant)
    if @cart_items.empty?
      redirect_to cart_path, alert: 'Your cart is empty.'
    else
      # Example logic for processing checkout
      # current_user.orders.create!(...)
      # Clear the cart
      current_user.cart_items.destroy_all

      redirect_to root_path, notice: 'Checkout successful.'
    end
  end
end
