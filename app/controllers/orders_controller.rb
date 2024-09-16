class OrdersController < ApplicationController
    before_action :authenticate_user!
  
    def new
      @cart_items = current_user.cart_items
      @order = Order.new
    end
  
    def create
      @order = Order.new(order_params)
      @order.user = current_user
      @order.shipment_status = 'Pending'
      @order.payment_status = 'Pending'
  
      if @order.save
        current_user.cart_items.each do |cart_item|
          @order.order_items.create!(
            product_variant: cart_item.product_variant,
            quantity: cart_item.quantity,
            price: cart_item.price
          )
        end
        current_user.cart_items.destroy_all
        current_user.update(wallet: current_user.wallet - @order.total_price)
        redirect_to @order, notice: 'Order placed successfully.'
      else
        render :new
      end
    end
  
    private
  
    def order_params
      params.require(:order).permit(:total_price, :shipment_status, :payment_status)
    end
  end
  