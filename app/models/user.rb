class User < ApplicationRecord
  attribute :terms_and_service, default: false

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password
  validates :password, presence: true, password: true
  validates :password_confirmation, presence: true

  has_many :sessions, dependent: :destroy

  validates :terms_and_service, acceptance: { message: "You cannot register without accepting the terms of use." }
end
