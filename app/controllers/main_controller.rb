class MainController < ApplicationController
  def index
    @products = Product.all
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
  end
end