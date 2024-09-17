class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = current_user.cart_items.includes(:product_variant)
  end

  def create
    cart_items = current_user.cart_items.includes(:product_variant)

    if cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    total_price = cart_items.sum(&:total_price)

    if current_user.wallet < total_price
      redirect_to checkout_path, alert: "Insufficient wallet balance."
      return
    end

    order = current_user.orders.create(
      total_price: total_price,
      shipment_status: :shipment_pending,
      payment_status: :paid 
    )

    cart_items.each do |cart_item|
      product_variant = cart_item.product_variant
    
      if product_variant.stock_quantity < cart_item.quantity
        redirect_to checkout_path, alert: "#{product_variant.name} does not have enough stock."
        return
      end
    
      product_variant.update!(stock_quantity: product_variant.stock_quantity - cart_item.quantity)
    
      order_item = order.order_items.create!(
        product_variant: product_variant,
        quantity: cart_item.quantity,
        price: cart_item.price,
        total_price: cart_item.total_price 
      )
    end
    

    current_user.update!(wallet: current_user.wallet - total_price)

    current_user.cart_items.destroy_all

    redirect_to order_path(order), notice: "Checkout completed successfully."
  rescue StandardError => e
    redirect_to checkout_path, alert: "Error during checkout: #{e.message}"
  end
end
