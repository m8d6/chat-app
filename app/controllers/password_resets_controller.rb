class PasswordResetsController < ApplicationController
  allow_unauthenticated_access 

  layout "unauthenticated" 

  before_action :find_user_by_token, only: [:edit, :update]

  def new
    @user = User.new(email_address: params[:email_address])
  end

  def create
    @user = User.find_by(email_address: params.dig(:user, :email_address)&.downcase&.strip)

    if @user.present? && @user.activated? 
      token = @user.generate_token_for(:password_reset)
      UserMailer.password_reset_email(@user, token).deliver_now 
    end

    redirect_to new_session_path, notice: t('.instructions_sent') 
  end

  def edit
  end

  def update
    if @user.update(password_params)


      redirect_to new_session_path, notice: t('.success') 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def find_user_by_token
    @token = params[:token]
    @user = User.find_by_token_for(:password_reset, @token)

    unless @user
      redirect_to new_session_path, alert: t('.invalid_token') 
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveSupport::MessageVerifier::ExpiredSignature
    redirect_to new_session_path, alert: t('.invalid_token') 
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
