class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create, :destroy]
  allow_unauthenticated_access only: %i[ new create destroy ]

  def new
    redirect_to dashboard_path if authenticated?
  end

  def create
    if user = User.authenticate_by(email_address: params[:email_address], password: params[:password])
      session[:user_id] = user.id
      Current.user = user
      redirect_to dashboard_path, notice: "Başarıyla giriş yapıldı!"
    else
      flash.now[:alert] = "Email adresi veya şifre hatalı."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    Current.user = nil
    redirect_to login_path, notice: 'Başarıyla çıkış yapıldı.'
  end
end
