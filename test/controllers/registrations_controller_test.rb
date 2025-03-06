require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get registration_path
    assert_response :success
    assert_nil flash[:alert]
  end

  test "should create user" do
    assert_difference("User.count") do
      post registration_path, params: {
        user: {
          email_address: "test@example.com",
          password: "123abc",
          password_confirmation: "123abc",
          terms_and_service: "1"
        }
      }
    end
    assert_redirected_to registration_path
    assert_not_empty flash[:notice]
    assert_equal I18n.t("registration.success"), flash[:notice]
  end

  test "should not create user without terms acceptance" do
    assert_no_difference("User.count") do
      post registration_path, params: {
        user: {
          email_address: "test@example.com",
          password: "123abc",
          password_confirmation: "123abc",
          terms_and_service: "0"
        }
      }
    end
    assert_response :unprocessable_entity
    assert_not_empty flash[:alert]
    assert_includes flash[:alert], I18n.t("activerecord.errors.messages.terms_of_use_acceptance_required")
  end

  test "should not create user with invalid data" do
    assert_no_difference("User.count") do
      post registration_path, params: {
        user: {
          email_address: "",
          password: "123",
          password_confirmation: "456",
          terms_and_service: "1"
        }
      }
    end
    assert_response :unprocessable_entity
    assert_not_empty flash[:alert]
    assert_includes flash[:alert], I18n.t("activerecords.errors.models.user.attributes.email_address.blank")
    assert_includes flash[:alert], I18n.t("activerecords.errors.models.user.attributes.password.too_short")
    assert_includes flash[:alert], I18n.t("activerecords.errors.models.user.attributes.password_confirmation.confirmation")
  end
end
