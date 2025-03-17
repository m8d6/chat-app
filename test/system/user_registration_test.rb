require "application_system_test_case"

class UserRegistrationTest < ApplicationSystemTestCase
  test "user can register with valid details" do
    visit new_registration_path

    find(I18n.t("forms.user.email_selector")).fill_in with: "test@example.com"
    find(I18n.t("forms.user.password_selector")).fill_in with: "Password123!"
    find(I18n.t("forms.user.password_confirmation_selector")).fill_in with: "Password123!"
    find(I18n.t("forms.user.terms_and_service_selector")).check
    find(I18n.t("forms.user.submit_selector")).click

    assert_text I18n.t("registrations.create.success")
  end

  test "shows error if email is already taken" do
    visit new_registration_path

    find(I18n.t("forms.user.email_selector")).fill_in with: users(:first).email_address
    find(I18n.t("forms.user.password_selector")).fill_in with: "Password123!"
    find(I18n.t("forms.user.password_confirmation_selector")).fill_in with: "Password123!"
    find(I18n.t("forms.user.terms_and_service_selector")).check
    find(I18n.t("forms.user.submit_selector")).click

    assert_text I18n.t("activerecord.errors.models.user.attributes.email_address.taken")
  end

  test "shows error if password confirmation does not match" do
    visit new_registration_path

    find(I18n.t("forms.user.email_selector")).fill_in with: "newuser@example.com"
    find(I18n.t("forms.user.password_selector")).fill_in with: "Password123!"
    find(I18n.t("forms.user.password_confirmation_selector")).fill_in with: "DifferentPassword123!"
    find(I18n.t("forms.user.terms_and_service_selector")).check
    find(I18n.t("forms.user.submit_selector")).click

    assert_text I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
  end

  test "shows error if password is blank" do
    visit new_registration_path

    find(I18n.t("forms.user.email_selector")).fill_in with: "newuser@example.com"
    find(I18n.t("forms.user.terms_and_service_selector")).check
    find(I18n.t("forms.user.submit_selector")).click

    assert_text I18n.t("activerecord.errors.models.user.attributes.password.blank")
  end
end
