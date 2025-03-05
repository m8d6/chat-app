class User < ApplicationRecord

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  attribute :terms_and_service, default: false

  has_secure_password

  has_many :sessions, dependent: :destroy

  validates :terms_and_service, acceptance: { message: "^You cannot register without accepting the terms of use." }

end
