module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?, :current_user
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticated?
    current_user.present?
  end

  def require_authentication
    unless authenticated?
      redirect_to login_path, alert: I18n.t("sessions.form.sign_in_prompt")
    end
  end

  def start_new_session_for(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def terminate_session
    session[:user_id] = nil
    @current_user = nil
  end
end