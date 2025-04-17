require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    password = Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true)

    @exist_user                 = users(:first)
    @non_exist_user_parameters  = {
      email_address: Faker::Internet.unique.email,
      password: password,
      password_confirmation: password,
      terms_and_service: "1"
    }
  end

  test "should get new" do
    get new_registration_path
    assert_response :success
  end

  test "should create user" do
    params = { user: @non_exist_user_parameters }

    assert_difference("User.count", 1) do
      post registration_path, params:
    end

    assert_redirected_to new_registration_path
    assert_equal I18n.t("registrations.create.success_with_activation"), flash[:notice]
  end

  test "should not create user without terms acceptance" do
    params = { user: @non_exist_user_parameters.merge(terms_and_service: "0") }

    assert_no_difference("User.count") do
      post registration_path, params:
    end

    assert_response :unprocessable_entity
    assert_match I18n.t("registrations.create.failure"), flash.now[:alert]
  end

  test "should not create user with invalid data" do
    params = { user: @non_exist_user_parameters.merge(email_address: "") }

    assert_no_difference("User.count") do
      post registration_path, params:
    end

    assert_response :unprocessable_entity
    assert_match I18n.t("registrations.create.failure"), flash.now[:alert]
  end
end
