class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  has_many :order_items, dependent: :destroy
  has_one_attached :image
end
