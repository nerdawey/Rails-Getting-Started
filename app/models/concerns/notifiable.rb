module Notifiable
  extend ActiveSupport::Concern

  included do
    has_many :product_subscribers, dependent: :destroy, foreign_key: :product_id
    has_many :subscribers, through: :product_subscribers
    after_update_commit :notify_subscribers_if_in_stock
  end

  private
    def notify_subscribers_if_in_stock
      if saved_change_to_in_stock? && in_stock?
        subscribers.each do |subscriber|
          ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
        end
      end
    end
end
