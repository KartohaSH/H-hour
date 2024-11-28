class CartsController < ApplicationController
  before_action :set_cart

  def current_cart
    if user_signed_in?
      @current_cart ||= Cart.find_or_create_by(user: current_user)
    else
      session[:cart_id] ||= Cart.create.id
      @current_cart ||= Cart.find(session[:cart_id])
    end
  end  

  def checkout
    @cart_items = current_cart.cart_items
  
    if @cart_items.any?
      total_price = @cart_items.sum { |item| item.quantity * item.product.price }
      order = Order.create(
        user: current_user, # Може бути nil для гостей
        total_price: total_price,
        status: 'pending'
      )
  
      @cart_items.each do |cart_item|
        order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
  
      @cart_items.destroy_all # Очищення кошика
      session[:cart_id] = nil # Очистити сесію для гостей
      redirect_to order_path(order), notice: "Order successfully placed!"
    else
      redirect_to cart_path, alert: "Your cart is empty!"
    end
  end
  
  def show
    @cart = current_cart
    @cart_items = current_cart.cart_items.includes(:product)
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart = current_cart
    cart_item = @cart.cart_items.find_by(product: product)
  
    if cart_item
      cart_item.quantity += params[:quantity].to_i
    else
      cart_item = @cart.cart_items.new(product: product, quantity: params[:quantity])
    end
  
    if cart_item.save
      redirect_to cart_path, notice: "#{product.name} додано до кошика!"
    else
      redirect_to product_path(product), alert: "Не вдалося додати товар до кошика."
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

  def destroy
    current_cart.destroy
    redirect_to root_path, notice: "Кошик очищено."
  end

  private

  def set_cart
    @cart = current_cart
  end
  
end
