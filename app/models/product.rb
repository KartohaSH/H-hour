class Product < ApplicationRecord
  has_one_attached :image

  validates :name, :description, :price, :category, presence: true
end
