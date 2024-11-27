class OrdersController < ApplicationController
  before_action :set_order, only: :show

  def show
    @card_items = @order.cart_items
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
