class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :reviews
  has_many :users, through: :reviews
  has_one_attached :image
end
