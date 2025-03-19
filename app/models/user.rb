class User < ApplicationRecord
  attribute :terms_and_service, default: false
  before_create :generate_activation_token

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password

  validates :password,              presence: true, password: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :email_address,         presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :terms_and_service,     acceptance: true

  has_many :sessions, dependent: :destroy

  def activate!
    update_columns(
      email_confirmed: true,
      email_verified_at: Time.current,
      confirmation_token: nil
    )
  end

  def activated?
    email_confirmed?
  end

  private

  def generate_activation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.email_confirmed = false
    self.email_verified_at = nil
  end
end
