class OnboardingController < ApplicationController
  before_action :check_activation_status
  
  layout "unauthenticated"

  def show
  end

  def update
    if current_user.update(onboarding_params)
      current_user.update(onboarding_completed_at: Time.current)
      redirect_to root_path, notice: t(".success")
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def onboarding_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :gender, :title)
  end

  def check_activation_status
    unless current_user.activated?
      redirect_to login_path, alert: t("sessions.create.activation_required")
    end
  end
end