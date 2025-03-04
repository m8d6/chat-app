class User < ApplicationRecord
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  attribute :terms_and_service, default: false

  has_secure_password

  has_many :sessions, dependent: :destroy
end
