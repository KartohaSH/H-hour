class OrdersController < ApplicationController
  before_action :set_order, only: :show

  def show
    @card_items = @order.cart_items
  end

  def create
    @order = current_user.orders.new(order_params)
    @cart = current_cart

    # Копіюємо елементи кошика до замовлення
    @cart.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
    end

    if @order.save
      @cart.destroy # очищаємо кошик після створення замовлення
      redirect_to @order, notice: "Замовлення успішно створено!"
    else
      render :new, alert: "Не вдалося створити замовлення."
    end
  end

  def index
    @orders = current_user.orders.includes(:order_items)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:address, :phone_number)
  end
end
