class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  before_action :set_product, only: %i[show]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
    # User should be able to see this if authenticated
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
end
