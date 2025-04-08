class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    @token = @user.generate_token_for(:email_confirmation)
    mail(
      to: @user.email_address,
    )
  end
end
