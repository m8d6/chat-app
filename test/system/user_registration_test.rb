require "application_system_test_case"

class UserRegistrationTest < ApplicationSystemTestCase
  test "user can register with valid details" do
    visit registration_path

    fill_in I18n.t("registrations.form.email.placeholder"), with: "test@example.com"
    fill_in I18n.t("registrations.form.password.placeholder"), with: "password123"
    fill_in I18n.t("registrations.form.password_confirmation.placeholder"), with: "password123"
    check I18n.t("terms_and_services.agreement_text") + " " + I18n.t("terms_and_services.link_text")
    click_button I18n.t("registrations.form.submit")

    assert_text I18n.t("registrations.create.success")
  end

  test "shows error if email is already taken" do
    visit registration_path

    fill_in I18n.t("registrations.form.email.placeholder"), with: users(:first).email_address
    fill_in I18n.t("registrations.form.password.placeholder"), with: "password123"
    fill_in I18n.t("registrations.form.password_confirmation.placeholder"), with: "password123"
    check I18n.t("terms_and_services.agreement_text") + " " + I18n.t("terms_and_services.link_text")
    click_button I18n.t("registrations.form.submit")

    assert_text I18n.t("activerecord.errors.models.user.attributes.email_address.taken")
  end

  test "shows error if password confirmation does not match" do
    visit registration_path

    fill_in I18n.t("registrations.form.email.placeholder"), with: "newuser@example.com"
    fill_in I18n.t("registrations.form.password.placeholder"), with: "password123"
    fill_in I18n.t("registrations.form.password_confirmation.placeholder"), with: "wrongpassword"
    check I18n.t("terms_and_services.agreement_text") + " " + I18n.t("terms_and_services.link_text")
    click_button I18n.t("registrations.form.submit")

    assert_text I18n.t("activerecord.errors.messages.confirmation", attribute: I18n.t("activerecord.attributes.user.password"))
  end

  test "shows error if password is blank" do
    visit registration_path

    fill_in I18n.t("registrations.form.email.placeholder"), with: "newuser@example.com"
    fill_in I18n.t("registrations.form.password.placeholder"), with: ""
    fill_in I18n.t("registrations.form.password_confirmation.placeholder"), with: ""
    check I18n.t("terms_and_services.agreement_text") + " " + I18n.t("terms_and_services.link_text")
    click_button I18n.t("registrations.form.submit")

    assert_text I18n.t("activerecord.errors.messages.blank", attribute: I18n.t("activerecord.attributes.user.password"))
  end
end
