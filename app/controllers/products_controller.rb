class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      expire_fragment "products"
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      expire_fragment "products"
      expire_fragment @product
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    expire_fragment "products"
    expire_fragment @product
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private
    def product_params
      params.expect(product: [ :name, :description, :image, :in_stock ])
    end
end