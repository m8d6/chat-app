class UserMailer < ApplicationMailer
  default from: "ali@rumeysa.com"

  def activation_email(user)
    @user = user
    @activation_url = confirm_registration_url(token: @user.confirmation_token)

    mail(
      to: @user.email_address,
      subject: I18n.t("user_mailer.activation_email.activation_subject")
    )
  end
end
