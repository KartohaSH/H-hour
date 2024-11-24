# email:string
# password_digest:string
#
# passwrd:string virtual
# password_confirmation virtualpa

class User < ApplicationRecord
  has_secure_password
  has_one :cart, dependent: :destroy
  validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid e-mail address"}
end
