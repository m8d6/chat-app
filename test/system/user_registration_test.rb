require "application_system_test_case"

class UserRegistrationTest < ApplicationSystemTestCase
  test "user can register with valid details" do
    visit registration_path

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    check "Terms and service"
    click_button "Register"

    assert_text "Registration successful"
  end

  test "shows error if email is already taken" do
    User.create!(email_address: "test@example.com", password: "password123")

    visit registration_path

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"
    check "Terms and service"
    click_button "Register"

    assert_text "Email has already been taken"
  end

  test "shows error if password confirmation does not match" do
    visit registration_path

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "wrongpassword"
    check "Terms and service"
    click_button "Register"

    assert_text "Passwords do not match"
  end

  test "shows error if password is blank" do
    visit registration_path

    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    check "Terms and service"
    click_button "Register"

    assert_text "Password can't be blank"
  end
end
