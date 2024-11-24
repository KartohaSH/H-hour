class CartsController < ApplicationController
  before_action :ensure_cart

  def show
    @cart_items = current_cart.cart_items.includes(:product)
  end

  def add_item
    product = Product.find(params[:product_id])
    cart_item = current_cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + 1 # Ініціалізація значення, якщо воно nil
    if cart_item.save
      redirect_to cart_path, notice: "#{product.name} added to cart!"
    else
      redirect_to products_path, alert: "Failed to add product to cart."
    end
  end
  
  def remove_item
    product = Product.find(params[:product_id])
    cart_item = current_cart.cart_items.find_by(product: product)
  
    if cart_item
      cart_item.destroy
      redirect_to cart_path, notice: "#{product.name} was removed from the cart."
    else
      redirect_to cart_path, alert: "Product not found in the cart."
    end
  end  

  private

  def current_cart
    @current_cart ||= Cart.find_or_create_by(user: current_user)
  end

  def ensure_cart
    redirect_to root_path, alert: "You need to sign in to access your cart." unless current_user
  end
end
