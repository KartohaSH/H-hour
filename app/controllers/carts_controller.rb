class CartsController < ApplicationController
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
  end

  def add_item
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += 1
    if cart_item.save
      redirect_to cart_path, notice: "#{product.name} added to cart!"
    else
      redirect_to products_path, alert: "Failed to add item to cart."
    end
  end

  def remove_item
    cart_item = @cart.cart_items.find_by(id: params[:id])
    if cart_item
      cart_item.destroy
      redirect_to cart_path, notice: "Item removed from cart."
    else
      redirect_to cart_path, alert: "Item not found."
    end
  end

  private

  def set_cart
    # Перевірка наявності користувача через сесію (або інший механізм)
    if session[:user_id]
      @cart = User.find(session[:user_id]).cart || current_user.create_cart
    else
      # Якщо немає користувача, створюємо кошик для гостя
      @cart = Cart.find_or_create_by(user_id: nil)
    end
  end
end
