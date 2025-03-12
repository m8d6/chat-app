require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:test_user)
    @no_email_user = users(:no_email_user)
    @invalid_email_user = users(:invalid_email_user)
    @terms_not_accepted_user = users(:terms_not_accepted_user)
    @no_password_user = users(:no_password_user)
  end

  def build_user(attributes = {})
    default_attributes = {
      email_address: "test2@example.com",
      password: "Password123!",
      password_confirmation: "Password123!",
      terms_and_service: "1"
    }
    User.new(default_attributes.merge(attributes))
  end
  
  def assert_has_error(record, attribute, error_type)
    assert_not record.valid?, "Expected #{record.class} to be invalid with #{attribute}"
    assert record.errors.where(attribute, error_type).present?, 
           "Expected error :#{error_type} on :#{attribute}, but no such error was found"
  end


  test "valid user should be valid" do
    assert @user.valid?, "Expected fixture user to be valid"
  end


  test "email should be present" do
    assert_has_error(@no_email_user, :email_address, :blank)
  end

  test "email should be valid format" do

    assert_has_error(@invalid_email_user, :email_address, :invalid)
    

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



  test "terms and service should be accepted" do
    assert_has_error(@terms_not_accepted_user, :terms_and_service, :accepted)
  end
end
