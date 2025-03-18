class Session
  include ActiveModel::Model

  attr_accessor :email_address, :password
  attr_reader :user

  validates :email_address, :password, presence: true
  validate :authenticate_user

  def save
    return false if invalid?
    true
  end

  private

  def authenticate_user
    @user = User.find_by(email_address: email_address)&.authenticate(password)
    
    return if @user

    errors.add :base, :invalid_credentials
  end
end