class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]

  def new
  end

  def create
    @user = User.find_by(email_address: params[:email_address])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to products_path
  end
end
