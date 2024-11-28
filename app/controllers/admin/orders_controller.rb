module Admin
  class OrdersController < Admin::BaseController
    def index
      @orders = Order.includes(order_items: :product)
    end

    def show
      @order = Order.includes(order_items: :product).find(params[:id])
    end
  end
end
