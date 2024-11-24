class MainController < ApplicationController
  def index
    @user = current_user
    @products = Product.all
    @cart = current_user ? current_user.cart : Cart.find_or_create_by(user_id: nil) # Use guest cart if not logged in
  end
end
