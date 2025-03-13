require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
  end
  
  def assert_error_on(record, attribute, message)
    assert_not record.valid?
    assert_includes record.errors[attribute], message
  end

  test "email should be present" do
    assert_error_on @user, :email_address, "can't be blank"
  end

  test "email should be valid format" do
    invalid_emails = %w[user@example user.org example.com user@.com]
    invalid_emails.each do |invalid_email|
      @user.email_address = invalid_email
      assert_error_on @user, :email_address, "is invalid"
    end
  end

  test "email address should be unique" do
    @user.email_address = users(:existing_user).email_address
    assert_error_on @user, :email_address, "has already been taken"
  end

  test "password should be present" do
    assert_error_on @user, :password, "can't be blank"
  end

  test "password should match confirmation" do
    @user.password = "NewPassword123!"
    @user.password_confirmation = "DifferentPassword123!"
    assert_error_on @user, :password_confirmation, "doesn't match Password"
  end

  test "password should meet minimum length requirement" do
    @user.password = "short"
    @user.password_confirmation = "short"
    assert_error_on @user, :password, "is too short (minimum is 6 characters)"
  end

  test "terms and service should be accepted" do
    assert_error_on @user, :terms_and_service, "must be accepted"
  end
end
