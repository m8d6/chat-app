class OnboardingController < ApplicationController
  before_action :check_activation_status

  layout "unauthenticated"

  def show
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(onboarding_params.merge(onboarding_completed_at: Time.current))
      redirect_to dashboard_path, notice: t(".success")
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def onboarding_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :gender, :title)
  end

  def check_activation_status
    return if current_user.activated?

    redirect_to login_path, alert: I18n.t("sessions.create.activation_required")
  end
end
