class Product < ApplicationRecord
  include Notifiable

  has_rich_text :description
  has_one_attached :image
  validates :name, presence: true
end
