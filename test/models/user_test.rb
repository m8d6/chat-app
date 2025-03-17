require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:first)
  end

  test "email should be present" do
    @user.email_address = nil

    assert_error_on @user, :email_address, :blank
  end

  test "email should be valid format" do
    invalid_formats = [ "user@", "plainaddress", "user@.com", "@example.com" ]

    invalid_formats.each do |format|
      @user.email_address = format
      assert_error_on @user, :email_address, :invalid
    end
  end

  test "email address should be unique" do
    duplicate_user = User.new(email_address: @user.email_address)

    assert_error_on duplicate_user, :email_address, :taken
  end

  test "password should be present" do
    @user.password = nil

    assert_error_on @user, :password, :blank
  end

  test "password should match confirmation" do
    @user.password = "NewPassword123!"
    @user.password_confirmation = "DifferentPassword123!"

    assert_error_on @user, :password_confirmation, :confirmation
  end

  test "password should meet minimum length requirement" do
    @user.password = "short"
    @user.password_confirmation = "short"

    assert_error_on @user, :password, :too_short
  end

  test "terms and service should be accepted" do
    @user.terms_and_service = false

    assert_error_on @user, :terms_and_service, :accepted
  end
end
