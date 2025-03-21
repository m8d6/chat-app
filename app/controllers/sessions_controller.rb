class SessionsController < ApplicationController
  allow_unauthenticated_access

  layout "unauthenticated"

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      unless @session.user.activated?
        return redirect_to login_path, alert: t(".activation_required")
      end

      start_new_session_for(@session.user)

      if @session.user.onboarding_completed_at.nil?
        redirect_to onboarding_path, notice: t(".success")
      else
        redirect_to root_path, notice: t(".success")
      end
    else
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to login_path, notice: "Başarıyla çıkış yaptınız"
  end

  private

  def session_params
    params.require(:session).permit(:email_address, :password)
  end
end
