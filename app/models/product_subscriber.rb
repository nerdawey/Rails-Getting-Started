class ProductSubscriber < ApplicationRecord
  belongs_to :product
  belongs_to :subscriber
end
