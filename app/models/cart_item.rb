class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true 
  
  validates :quantity, presence: true
end
