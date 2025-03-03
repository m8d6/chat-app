class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy


  attr_accessor :terms_of_service

  normalizes :email_address, with: ->(e) { e.strip.downcase }


  attribute :email_verified, :boolean, default: false
  attribute :email_verification_token, :string

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :terms_of_service, acceptance: true # Kullanıcı sözleşmesinin kabulünü zorunlu kıl


  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validate :password_complexity, if: -> { password.present? }

  before_create :generate_email_verification_token

  private

  def password_complexity
    return if password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])/)

    errors.add :password, "en az bir b\u00FCy\u00FCk harf, bir k\u00FC\u00E7\u00FCk harf, bir say\u0131 ve bir sembol i\u00E7ermelidir"
  end

  def generate_email_verification_token
    self.email_verification_token = SecureRandom.urlsafe_base64
  end
end
