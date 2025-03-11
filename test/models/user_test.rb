require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Setup runs before each test
  def setup
    @user = users(:test_user)
    @no_email_user = users(:no_email_user)
    @invalid_email_user = users(:invalid_email_user)
    @terms_not_accepted_user = users(:terms_not_accepted_user)
    @no_password_user = users(:no_password_user)
  end

  # Creates a new user with default valid attributes, which can be overridden
  # @param attributes [Hash] attributes to override defaults
  # @return [User] a new user instance
  def build_user(attributes = {})
    default_attributes = {
      email_address: "test2@example.com",
      password: "Password123!",
      password_confirmation: "Password123!",
      terms_and_service: "1"
    }
    User.new(default_attributes.merge(attributes))
  end
  
  # Asserts that a record has a specific error on a specific attribute
  # @param record [ActiveRecord::Base] the record to check
  # @param attribute [Symbol] the attribute with the error
  # @param error_type [Symbol] the type of error
  def assert_has_error(record, attribute, error_type)
    assert_not record.valid?, "Expected #{record.class} to be invalid with #{attribute}"
    assert record.errors.where(attribute, error_type).present?, 
           "Expected error :#{error_type} on :#{attribute}, but no such error was found"
  end

  #----- Validation Tests -----#

  test "valid user should be valid" do
    assert @user.valid?, "Expected fixture user to be valid"
  end

  #----- Email Tests -----#

  test "email should be present" do
    assert_has_error(@no_email_user, :email_address, :blank)
  end

  test "email should be valid format" do
    # Test fixture with invalid email
    assert_has_error(@invalid_email_user, :email_address, :invalid)
    
    # Test multiple invalid formats
    invalid_emails = %w[user@example user.org example.com user@.com]
    invalid_emails.each do |invalid_email|
      user = build_user(email_address: invalid_email)
      assert_has_error(user, :email_address, :invalid)
    end
  end

  test "email address should be unique" do
    duplicate_user = build_user(email_address: @user.email_address)
    assert_has_error(duplicate_user, :email_address, :taken)
  end

  #----- Password Tests -----#

  test "password should be present" do
    assert_has_error(@no_password_user, :password, :blank)
  end

  test "password should match confirmation" do
    user = build_user(
      password: "Password123!",
      password_confirmation: "different"
    )
    assert_has_error(user, :password_confirmation, :confirmation)
  end

  test "password should meet minimum length requirement" do
    user = build_user(
      password: "abc12",
      password_confirmation: "abc12"
    )
    assert_has_error(user, :password, :too_short)
  end

  #----- Terms of Service Tests -----#

  test "terms and service should be accepted" do
    assert_has_error(@terms_not_accepted_user, :terms_and_service, :accepted)
  end
end
