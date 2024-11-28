class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product, :order
  validates :quantity, presence: true
end