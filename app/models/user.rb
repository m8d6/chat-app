class User < ApplicationRecord
  attribute :terms_and_service, default: false

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password




  validates :password, presence: true, password: true
  validates :password_confirmation, presence: true
  validates :email_address, uniqueness: true
  validates :email_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :terms_and_service, acceptance: true

  has_many :sessions, dependent: :destroy
end
