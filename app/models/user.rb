class User < ApplicationRecord
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_secure_password

  has_many :sessions, dependent: :destroy
end
