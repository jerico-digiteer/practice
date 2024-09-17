class Admin::OrdersController < ApplicationController
      # Ensure only admins can access this controller
      before_action :authenticate_admin!
  
      def index
        @orders = Order.all # Fetch all orders for the admin view
      end
  
      def show
        @order = Order.includes(:user).find(params[:id])
      end
end
  