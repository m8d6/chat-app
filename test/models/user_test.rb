require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:test_user)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email should be present" do
    user = User.new(
      password: "Password123!",
      password_confirmation: "Password123!",
      terms_and_service: "1"
    )
    assert_not user.valid?
    assert user.errors.where(:email_address, :blank).present?
  end

  test "email should be valid format" do
    invalid_emails = %w[user@example user.org example.com user@.com]
    invalid_emails.each do |invalid_email|
      user = User.new(
        email_address: invalid_email,
        password: "Password123!",
        password_confirmation: "Password123!",
        terms_and_service: "1"
      )
      assert_not user.valid?, "#{invalid_email} should not be valid"
      assert user.errors.where(:email_address, :invalid).present?
    end
  end

  test "password should be present" do
    user = User.new(email_address: "test2@example.com", terms_and_service: "1")
    assert_not user.valid?
    assert user.errors.where(:password, :blank).present?
  end

  test "password should match confirmation" do
    user = User.new(
      email_address: "test2@example.com",
      password: "Password123!",
      password_confirmation: "different",
      terms_and_service: "1"
    )
    assert_not user.valid?
    assert user.errors.where(:password_confirmation, :confirmation).present?
  end

  test "password should meet minimum length requirement" do
    user = User.new(
      email_address: "test2@example.com",
      password: "abc12",
      password_confirmation: "abc12",
      terms_and_service: "1"
    )
    assert_not user.valid?
    assert user.errors.where(:password, :too_short).present?
  end

  test "terms and service should be accepted" do
    user = User.new(
      email_address: "test2@example.com",
      password: "Password123!",
      password_confirmation: "Password123!",
      terms_and_service: "0"
    )
    assert_not user.valid?
    assert user.errors.where(:terms_and_service, :accepted).present?
  end

  test "email address should be unique" do
    duplicate_user = User.new(
      email_address: @user.email_address,
      password: "Password123!",
      password_confirmation: "Password123!",
      terms_and_service: "1"
    )
    assert_not duplicate_user.valid?
    assert duplicate_user.errors.where(:email_address, :taken).present?
  end
end
