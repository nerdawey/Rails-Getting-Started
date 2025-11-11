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
    respond_to do |format|
      if @product.save
        expire_fragment "products"
        format.turbo_stream { render :create }
        format.html { redirect_to @product }
      else
        format.turbo_stream { render :new, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        expire_fragment "products"
        expire_fragment @product
        format.turbo_stream { render :update }
        format.html { redirect_to @product }
      else
        format.turbo_stream { render :edit, status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    expire_fragment "products"
    expire_fragment @product
    @product.destroy
    respond_to do |format|
      format.turbo_stream { render :destroy }
      format.html { redirect_to products_path, status: :see_other }
    end
  end

  private
    def product_params
      params.expect(product: [ :name, :description, :image, :in_stock ])
    end
end