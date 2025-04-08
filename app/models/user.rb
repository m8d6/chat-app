class User < ApplicationRecord
  attribute :terms_and_service, default: false

  enum :gender, { male: 0, female: 1, other: 2 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password

  validates :password,              presence: true,  password: true, confirmation: true, on: :create
  validates :password,              confirmation: true, if: -> { password.present? }
  validates :password_confirmation, presence: true,     if: -> { password.present? }, on: :create
  validates :email_address,         presence: true,  uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :terms_and_service,     acceptance: true, on: :create


  has_many :sessions, dependent: :destroy

  generates_token_for :email_confirmation, expires_in: 24.hours do
    email_address
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
end
