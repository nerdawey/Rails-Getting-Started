class SubscribersController < ApplicationController
  skip_before_action :require_login, only: [ :create, :destroy ]

  def create
    @product = Product.find(params[:product_id])
    @subscriber = Subscriber.find_or_create_by(email_address: params[:email_address])
    @product.subscribers << @subscriber unless @product.subscribers.include?(@subscriber)
    redirect_to @product, notice: "You've been subscribed to notifications for this product."
  end

  def destroy
    @product = Product.find(params[:product_id])
    @subscriber = Subscriber.find_by(email_address: params[:email])
    if @subscriber
      @product.subscribers.delete(@subscriber)
      redirect_to @product, notice: "You've been unsubscribed from notifications for this product."
    else
      redirect_to @product, alert: "Subscriber not found."
    end
  end
end
