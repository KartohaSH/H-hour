module Admin
  class OrdersController < Admin::BaseController
    def index
      @orders = Order.all
    end
  end
end
