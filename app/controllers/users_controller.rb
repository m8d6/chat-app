class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create verify_email ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Email doğrulama maili gönder
        UserMailer.with(user: @user).email_verification.deliver_later
        
        # Oturum AÇMADAN giriş sayfasına yönlendir
        format.html do
          flash[:notice] = "Hesabınız başarıyla oluşturuldu! Şimdi giriş yapabilirsiniz."
          redirect_to new_session_path
        end
      else
        format.html do
          flash.now[:alert] = @user.errors.full_messages.join(", ")
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def verify_email
    user = User.find_by_email_verification_token!(params[:token])
    user.update!(email_verified: true, email_verification_token: nil)
    
    redirect_to new_session_path, 
      notice: "Email adresiniz doğrulandı. Şimdi giriş yapabilirsiniz."
  rescue ActiveRecord::RecordNotFound
    redirect_to new_session_path, 
      alert: "Geçersiz veya kullanılmış doğrulama linki."
  end

  private
    def user_params
      params.require(:user).permit(
        :email_address, 
        :password, 
        :password_confirmation, 
        :terms_of_service
      )
    end
end 