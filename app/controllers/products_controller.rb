class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  before_action :set_product, only: %i[show]
  
  helper_method :sort_column, :sort_direction

  # GET /products
  def index
    @products = Product.all.order("#{sort_column} #{sort_direction}")
  end

  # GET /products/1
  def show
    @reviews = @product.reviews.includes(:user) # Loads the reviews for the product
    @can_review = can_review? 
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # GET /products/1/edit
  def edit
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, product_variants_attributes: [:id, :name, :price, :stock_quantity, :_destroy])
  end

  def authorize_admin
    redirect_to products_path, alert: 'You are not authorized to perform this action.' unless current_admin
  end

  def sort_column
    %w[name description].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def can_review?
    OrderItem.joins(:order)
              .where(orders: { user_id: current_user.id }, product_variant_id: @product.product_variants.pluck(:id))
              .exists?
  end
  
end
