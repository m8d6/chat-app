class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    # Giriş formunu göster
  end

  def create
    # email yerine email_address kullanıyoruz
    if user = User.authenticate_by(email_address: params[:email_address], password: params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Başarıyla giriş yapıldı!"
    else
      flash.now[:alert] = "Email adresi veya şifre hatalı."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Oturumu sonlandır
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Başarıyla çıkış yapıldı."
  end
end
