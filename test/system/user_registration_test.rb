require "application_system_test_case"

class UserRegistrationTest < ApplicationSystemTestCase
  test "user can register with valid details" do
    visit new_registration_path

    fill_in User.human_attribute_name(:email_address), with: "test@example.com"
    fill_in User.human_attribute_name(:password), with: "Password123!"
    fill_in User.human_attribute_name(:password_confirmation), with: "Password123!"
    check I18n.t("registrations.form.agreement.text").strip

    click_on I18n.t("registrations.form.submit")

    assert_text I18n.t("registrations.create.success")
  end

  test "shows error if email is already taken" do
    visit new_registration_path

    fill_in User.human_attribute_name(:email_address), with: users(:first).email_address
    fill_in User.human_attribute_name(:password), with: "Password123!"
    fill_in User.human_attribute_name(:password_confirmation), with: "Password123!"
    check I18n.t("registrations.form.agreement.text").strip

    click_on I18n.t("registrations.form.submit")

    assert_text I18n.t("activerecord.errors.models.user.attributes.email_address.taken")
  end

  test "shows error if password confirmation does not match" do
    visit new_registration_path

    fill_in User.human_attribute_name(:email_address), with: "newuser@example.com"
    fill_in User.human_attribute_name(:password), with: "Password123!"
    fill_in User.human_attribute_name(:password_confirmation), with: "DifferentPassword123!"
    check I18n.t("registrations.form.agreement.text").strip

    click_on I18n.t("registrations.form.submit")

    assert_text I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
  end

  test "shows error if password is blank" do
    visit new_registration_path

    fill_in User.human_attribute_name(:email_address), with: "newuser@example.com"
    check I18n.t("registrations.form.agreement.text").strip

    click_on I18n.t("registrations.form.submit")

    assert_text I18n.t("activerecord.errors.models.user.attributes.password.blank")
  end
end
