class OnboardingController < ApplicationController
  before_action :check_activation_status
  
  layout "unauthenticated"

  def show
    @user = current_user
  end

  def update
    @user = current_user
    
    @user.skip_password_validation = true
    
    if @user.update(onboarding_params)
      @user.update_column(:onboarding_completed_at, Time.current)
      redirect_to dashboard_path, notice: t(".success")
    else
      puts "Validation errors: #{@user.errors.full_messages}"
      Rails.logger.debug "Validation errors: #{@user.errors.full_messages}"
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