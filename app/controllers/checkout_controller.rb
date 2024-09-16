class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_user.cart_items.includes(:product_variant)
  end

  def create
  end
end
