require "application_system_test_case"

class UserRegistrationTest < ApplicationSystemTestCase
  test "user can register with valid details" do
    visit registration_path

    fill_in I18n.t("forms.email_label"), with: "test@example.com"
    fill_in I18n.t("forms.password_label"), with: "password123"
    fill_in I18n.t("forms.password_confirmation_label"), with: "password123"
    check I18n.t("forms.terms_and_service_label")
    click_button I18n.t("forms.register_button")

    assert_text I18n.t("flash.registration.success")
  end

  test "shows error if email is already taken" do
    visit registration_path

    fill_in I18n.t("forms.email_label"), with: users(:test_user).email_address
    fill_in I18n.t("forms.password_label"), with: "password123"
    fill_in I18n.t("forms.password_confirmation_label"), with: "password123"
    check I18n.t("forms.terms_and_service_label")
    click_button I18n.t("forms.register_button")

    assert_text I18n.t("errors.email_taken")
  end

  test "shows error if password confirmation does not match" do
    visit registration_path

    fill_in I18n.t("forms.email_label"), with: "newuser@example.com"
    fill_in I18n.t("forms.password_label"), with: "password123"
    fill_in I18n.t("forms.password_confirmation_label"), with: "wrongpassword"
    check I18n.t("forms.terms_and_service_label")
    click_button I18n.t("forms.register_button")

    assert_text I18n.t("errors.password_mismatch")
  end

  test "shows error if password is blank" do
    visit registration_path

    fill_in I18n.t("forms.email_label"), with: "newuser@example.com"
    fill_in I18n.t("forms.password_label"), with: ""
    fill_in I18n.t("forms.password_confirmation_label"), with: ""
    check I18n.t("forms.terms_and_service_label")
    click_button I18n.t("forms.register_button")

    assert_text I18n.t("errors.password_blank")
  end
end
