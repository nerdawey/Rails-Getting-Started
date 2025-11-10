class Subscriber < ApplicationRecord
  has_many :product_subscribers, dependent: :destroy
  has_many :products, through: :product_subscribers
  validates :email_address, presence: true, uniqueness: true
end
