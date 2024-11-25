# email:string
# password_digest:string
#
# passwrd:string virtual
# password_confirmation virtualpa

class User < ApplicationRecord
  # Secure password
  has_secure_password

  # Associations
  has_one :cart, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :products, through: :reviews

  # Validations
  validates :email, presence: true, 
                    uniqueness: true, 
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid e-mail address" }
end

  