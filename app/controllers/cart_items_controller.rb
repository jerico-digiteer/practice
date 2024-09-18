class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart_item = current_user.cart_items.find_or_initialize_by(product_variant_id: params[:product_variant_id])
    product_variant = ProductVariant.find_by(id: params[:product_variant_id])

    if product_variant.nil?
      redirect_back fallback_location: products_path, alert: 'Product variant not found.'
      return
    end

    requested_quantity = params[:quantity].to_i
    current_quantity_in_cart = @cart_item.quantity || 0
    total_requested_quantity = current_quantity_in_cart + requested_quantity

    if total_requested_quantity > product_variant.stock_quantity
      redirect_back fallback_location: products_path, alert: "Only #{product_variant.stock_quantity} items available in stock."
      return
    end

    @cart_item.quantity = total_requested_quantity
    @cart_item.price = product_variant.price
    @cart_item.total_price = @cart_item.price * @cart_item.quantity

    if @cart_item.save
      redirect_to cart_path, notice: 'Item added to cart.'
    else
      redirect_back fallback_location: products_path, alert: 'Failed to add item to cart.'
    end
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  def show
    @cart_items = current_user.cart_items
  end
end
