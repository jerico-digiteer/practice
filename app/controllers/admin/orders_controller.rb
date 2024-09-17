class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all 
  end

  def show
    @order = Order.includes(:user).find(params[:id])
  end
end
