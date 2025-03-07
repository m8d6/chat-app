class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  layout "unauthenticated"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_registration_path, notice: t(".create")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :terms_and_service)
  end
end
