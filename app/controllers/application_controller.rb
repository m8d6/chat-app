class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_user

  # Helper metodu olarak tanımla
  helper_method :current_user
  helper_method :authenticated?

  skip_before_action :require_authentication, only: [:new, :create]

  private
    def set_current_user
      Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def current_user
      Current.user
    end

    def authenticated?
      Current.user.present?
    end

    def require_authentication
      unless authenticated?
        redirect_to new_session_path, alert: "Lütfen önce giriş yapın."
      end
    end
end
