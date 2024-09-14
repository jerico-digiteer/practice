class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: %i[show edit update destroy]

  # GET /admin/products
  def index
    @products = Product.all
  end

  # GET /admin/products/1
  def show
  end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # POST /admin/products
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # GET /admin/products/1/edit
  def edit
  end

  # PATCH/PUT /admin/products/1
  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/products/1
  def destroy
    @product.destroy
    redirect_to admin_products_url, notice: 'Product was successfully destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :variants, :quantity)
    end
end
