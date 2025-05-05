class User < ApplicationRecord
  attribute :terms_and_service, default: false

  enum :gender, { male: 0, female: 1, other: 2 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password

  validates :password,              presence: true, password: true, confirmation: true, on: :create
  validates :password,              confirmation: true,                     if: -> { password.present? }
  validates :password_confirmation, presence: true,                         if: -> { password.present? }, on: :create
  validates :email_address,         presence: true, uniqueness: true,        format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :terms_and_service,     acceptance: true,                        on: :create
  validates :first_name, :last_name, :birth_date, :gender, :title, presence: true, if: :should_validate_onboarding_completion?

  has_many :sessions, dependent: :destroy

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email_address
  end

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  def activate!
    update_columns(
      email_confirmed: true,
      email_verified_at: Time.current,
    )
  end

  def activated?
    email_confirmed?
  end

  private
  def should_validate_onboarding_completion?
    onboarding_completed_at_changed? || onboarding_completed_at.present?
  end
end
