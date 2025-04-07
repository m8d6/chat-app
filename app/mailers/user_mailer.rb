class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(
      to: @user.email_address,
    )
  end
end
