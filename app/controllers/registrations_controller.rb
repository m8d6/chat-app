class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  layout "unauthenticated"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.activation_email(@user).deliver_later
      redirect_to new_registration_path, 
        notice: t(".success_with_activation")
    else
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    @user = User.find_by!(confirmation_token: params[:token])
    @user.activate!
    redirect_to login_path, notice: t(".activation_success")
  rescue ActiveRecord::RecordNotFound
    redirect_to login_path, alert: t(".invalid_token")
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :terms_and_service)
  end
end