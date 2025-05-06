class RegistrationsController < ApplicationController
  allow_unauthenticated_access

  layout "unauthenticated"

  def new
    if authenticated? && current_user.onboarding_completed_at.present?
      return redirect_to dashboard_path
    end

    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.activation_email(@user).deliver_now

      redirect_to new_registration_path, notice: t(".success_with_activation")
    else
      flash.now[:alert] = t(".failure")

      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def confirm
    @user = User.find_by_token_for!(:email_confirmation, params[:token])
    @user.activate!

    redirect_to new_session_path, notice: t(".activation_success")
  rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveRecord::RecordNotFound
    redirect_to new_session_path, alert: t(".invalid_token")
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :terms_and_service)
  end
end
