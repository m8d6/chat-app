require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get registration_path
    assert_response :success
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
  end
end
