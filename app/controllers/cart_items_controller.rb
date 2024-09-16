class CartItemsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @product_variant = ProductVariant.find(params[:product_variant_id])
      @cart_item = current_user.cart_items.find_or_initialize_by(product_variant: @product_variant)
      
      @cart_item.quantity += params[:quantity].to_i
      @cart_item.price = @product_variant.price
      @cart_item.save
  
      redirect_to cart_path, notice: 'Product added to cart.'
    end
  
    def destroy
      @cart_item = current_user.cart_items.find(params[:id])
      @cart_item.destroy
      redirect_to cart_path, notice: 'Product removed from cart.'
    end
  
    def index
      @cart_items = current_user.cart_items
    end
  end
  