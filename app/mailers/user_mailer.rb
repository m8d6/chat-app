class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    @token = @user.generate_token_for(:email_confirmation)
    mail(
      to: @user.email_address,
      subject: t('.subject')
    )
  end

  def password_reset_email(user, token)
    @user = user
    @token = token
    @reset_url = edit_password_reset_url(token: @token, host: default_url_options[:host])

    mail(
      to: @user.email_address,
      subject: t('.subject')
    )
  end
end
