class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?, :current_cart

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end

  def current_cart
    if user_signed_in?
      current_user.cart || current_user.create_cart
    else
      Cart.find_or_create_by(user_id: nil)
    end
  end

end
