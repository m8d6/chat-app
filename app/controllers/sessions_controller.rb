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

      session[:user_id] = @session.user.id

      redirect_to root_path, notice: t(".success")
    else
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session).permit(:email_address, :password)
  end
end
