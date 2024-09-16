class CartsController < ApplicationController
  def show
    @cart_items = current_user.cart_items.includes(:product_variant)
  end
end
