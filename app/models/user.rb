class User < ApplicationRecord
  include PasswordValidatable

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  attribute :terms_and_service, default: false

  has_secure_password

  has_many :sessions, dependent: :destroy


  validates :terms_and_service, acceptance: { message: :terms_of_use_acceptance_required }
end
