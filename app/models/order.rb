class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :total_price, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending completed canceled], message: "%{value} is not a valid status" }
end
