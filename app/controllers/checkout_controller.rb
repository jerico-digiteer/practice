class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_user.cart_items.includes(:product_variant)
  end

  def create
    # Handle the checkout process here
    # For example, you might create an order and clear the cart

    @cart_items = current_user.cart_items.includes(:product_variant)
    if @cart_items.empty?
      redirect_to cart_path, alert: 'Your cart is empty.'
    else
      # Example logic for processing checkout
      # Order creation logic
      # current_user.orders.create!(...)
      # Clear the cart
      current_user.cart_items.destroy_all

      redirect_to root_path, notice: 'Checkout successful.'
    end
  end
end
