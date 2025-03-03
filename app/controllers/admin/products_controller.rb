module Admin
  class ProductsController < ApplicationController
    before_action :ensure_admin  # Перевірка, чи є користувач адміністратором
    before_action :set_product, only: [:edit, :update, :destroy]

    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: "Product created successfully."
      else
        flash.now[:alert] = "Failed to create product."
        render :new
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path, notice: "Product updated successfully."
      else
        flash.now[:alert] = "Failed to update product."
        render :edit
      end
    end

    def destroy
      if @product.present?
        ActiveRecord::Base.transaction do
          @product.cart_items.destroy_all
          @product.order_items.destroy_all
          @product.destroy
        end
        redirect_to admin_products_path, notice: "Product deleted successfully."
      else
        redirect_to admin_products_path, alert: "Product not found."
      end
    end

    private

    def ensure_admin
      redirect_to root_path, alert: "Access denied!" unless session[:admin]
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image, :category)
    end
    
  end
end
