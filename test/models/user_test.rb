require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email_address: "test@example.com",
      password: "Password123!",
      password_confirmation: "Password123!",
      terms_and_service: "1"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email_address = ""
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], I18n.t("activerecord.errors.models.user.attributes.email_address.blank")
  end

  test "email should be valid format" do
    invalid_emails = %w[user@example user.org example.com user@.com]
    invalid_emails.each do |invalid_email|
      @user.email_address = invalid_email
      assert_not @user.valid?, "#{invalid_email} should not be valid"
      assert_includes @user.errors[:email_address], I18n.t("activerecord.errors.models.user.attributes.email_address.invalid")
    end
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = ""
    assert_not @user.valid?
    assert_includes @user.errors[:password], I18n.t("can't be blank")
  end

  test "password should match confirmation" do
    @user.password_confirmation = "different"
    assert_not @user.valid?
    assert_includes @user.errors[:password_confirmation], I18n.t("doesn't match Password")
  end

  test "password should meet minimum length requirement" do
    @user.password = @user.password_confirmation = "abc12"
    assert_not @user.valid?
    assert_includes @user.errors[:password], I18n.t("Password is too short (minimum is 8 characters)")
  end

  test "terms and service should be accepted" do
    @user.terms_and_service = "0"
    assert_not @user.valid?
    assert_includes @user.errors[:terms_and_service], I18n.t("activerecord.errors.models.user.attributes.terms_and_service.accepted")
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
   assert_includes duplicate_user.errors[:email_address], "has already been taken"
  end
end
