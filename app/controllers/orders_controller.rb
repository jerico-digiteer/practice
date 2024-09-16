class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.shipment_status = 'pending'
    @order.payment_status = 'unpaid'

    if @order.save
      current_user.cart_items.each do |cart_item|
        @order.order_items.create!(
          product_variant_id: cart_item.product_variant_id,
          quantity: cart_item.quantity,
          price: cart_item.price
        )
      end

      current_user.cart_items.destroy_all

      redirect_to order_path(@order), notice: 'Order placed successfully!'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price)
  end
end
